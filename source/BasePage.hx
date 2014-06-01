package ;
import flash.geom.Rectangle;
import flash.net.FileReference;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIAssets;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUIList;
import flixel.addons.ui.FlxUIRadioGroup;
import flixel.addons.ui.FlxUISpriteButton;
import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUIText;
import flixel.addons.ui.StrIdLabel;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.system.scaleModes.PixelPerfectScaleMode;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import flixel.util.FlxRect;
import flixel.util.FlxSpriteUtil;
import haxe.Json;
import substates.Help;
import substates.MessagePopup;
import substates.NewProj;
import substates.EditProj;
import substates.NewSheet;

/**
 * ...
 * @author Ohmnivore
 */
class BasePage extends FlxUIState
{
	public var under_hud:FlxGroup;
	public var hud:FlxGroup;
	
	public var tileset:FlxSprite;
	
	public var selector:Selector;
	
	public var tab:FlxUITabMenu;
	public var tabRect:FlxRect;
	public var fieldlist:FlxUIList;
	public var fieldlist2:FlxUIList;
	
	private var show_inspect:Bool = false;
	
	private var name_project:FlxUIText;
	private var name_image:FlxUIText;
	private var name_sheet:FlxUIText;
	
	override public function create() 
	{
		super.create();
		Reg.base = this;
		
		add(new FlxSprite(0, 0, "assets/images/background.png"));
		
		FlxG.scaleMode = new PixelPerfectScaleMode();
		
		under_hud = new FlxGroup();
		hud = new FlxGroup();
		add(under_hud);
		add(hud);
		
		tileset = new FlxSprite();
		under_hud.add(tileset);
		tileset.makeGraphic(32, 32, 0x00000000);
		
		addHUD();
		
		Json.stringify(new Map<Int, Dynamic>());
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (FlxG.keys.pressed.A)
		{
			tileset.x -= 5;
			selector.x -= 5;
		}
		if (FlxG.keys.pressed.D)
		{
			tileset.x += 5;
			selector.x += 5;
		}
		if (FlxG.keys.pressed.W)
		{
			tileset.y -= 5;
			selector.y -= 5;
		}
		if (FlxG.keys.pressed.S)
		{
			tileset.y += 5;
			selector.y += 5;
		}
		if (FlxG.keys.pressed.SPACE)
		{
			FlxSpriteUtil.screenCenter(tileset, true, true);
		}
		if (!tabRect.containsFlxPoint(FlxG.mouse.getScreenPosition()) && FlxG.mouse.y > 26
			&& Reg.sheet != null)
		{
			if (FlxG.mouse.justPressed)
			{
				selector.setFirstAnchor(FlxG.mouse.x, FlxG.mouse.y, tileset);
			}
			if (FlxG.mouse.justReleased)
			{
				selector.setFinalAnchor(FlxG.mouse.x, FlxG.mouse.y, tileset);
			}
			if (FlxG.mouse.pressed)
			{
				selector.setMediumAnchor(FlxG.mouse.x, FlxG.mouse.y, tileset);
			}
		}
		
		if (Reg.sheet != null)
		{
			if (FlxG.keys.justPressed.E)
			{
				var arr:Array<Int> = selector.getSelected();
				
				var selected:Int = -1;
				if (arr.length >= 1)
				{
					if (Reg.sheet.tiles.exists(arr[0]))
					{
						var to_compare:Int = Reg.sheet.tiles.get(arr[0]);
						
						for (x in arr)
						{
							if (Reg.sheet.tiles.exists(x))
							{
								var brush:Int = Reg.sheet.tiles.get(x);
								
								if (brush == to_compare)
								{
									selected = x;
								}
								
								else
								{
									selected = -1;
									break;
								}
							}
							
							else
							{
								selected = -1;
								break;
							}
						}
					}
				}
				
				if (selected == -1)
				{
					show_inspect = false;
				}
				
				else
				{
					show_inspect = true;
					
					var ind:Int = 0;
					var brush:Brush = Reg.sheet.brushes.get(Reg.sheet.tiles.get(selected));
					
					for (field in Reg.proj.iterator())
					{
						if (field.type == "Checkbox")
						{
							var check:FlxUICheckBox = cast Reg.props_inspect.get(field.name);
							
							check.checked = brush.arr[ind];
						}
						
						if (field.type == "Textfield")
						{
							var inp:FlxUIInputText = cast Reg.props_inspect.get(field.name);
							
							inp.text = brush.arr[ind];
						}
						
						if (field.type == "Radio group")
						{
							var inp:FlxUIRadioGroup = cast Reg.props_inspect.get(field.name);
							
							inp.selectedId = brush.arr[ind];
						}
						
						ind++;
					}
				}
			}
			
			if (FlxG.keys.justPressed.Q)
			{
				var brush:Brush = new Brush();
				
				for (field in Reg.proj.iterator())
				{
					if (field.type == "Checkbox")
					{
						var check:FlxUICheckBox = cast Reg.props.get(field.name);
						
						brush.arr.push(check.checked);
					}
					
					if (field.type == "Textfield")
					{
						var inp:FlxUIInputText = cast Reg.props.get(field.name);
						
						brush.arr.push(inp.text);
					}
					
					if (field.type == "Radio group")
					{
						var inp:FlxUIRadioGroup = cast Reg.props.get(field.name);
						
						brush.arr.push(inp.selectedId);
					}
				}
				
				var same:Bool = false;
				var found_key:Int = Reg.sheet.index;
				var found_brush:Brush = brush;
				for (key in Reg.sheet.brushes.keys())
				{
					same = true;
					var b:Brush = Reg.sheet.brushes.get(key);
					
					var ind:Int = 0;
					while (ind < b.arr.length)
					{
						if (b.arr[ind] != brush.arr[ind])
						{
							same = false;
							break;
						}
						ind++;
					}
					
					if (same)
					{
						found_brush = b;
						found_key = key;
						break;
					}
				}
				
				if (same)
				{
					for (x in selector.getSelected())
					{
						if (Reg.sheet.tiles.exists(x))
						{
							var old_brush:Brush = Reg.sheet.brushes.get(Reg.sheet.tiles.get(x));
							old_brush.total_members--;
							
							if (old_brush.total_members <= 0)
							{
								Reg.sheet.brushes.remove(Reg.sheet.tiles.get(x));
							}
						}
						
						Reg.sheet.tiles.set(x, found_key);
						found_brush.total_members++;
					}
				}
				
				else
				{
					Reg.sheet.brushes.set(Reg.sheet.index, brush);
					
					for (x in selector.getSelected())
					{
						if (Reg.sheet.tiles.exists(x))
						{
							var old_brush:Brush = Reg.sheet.brushes.get(Reg.sheet.tiles.get(x));
							old_brush.total_members--;
							
							if (old_brush.total_members <= 0)
							{
								Reg.sheet.brushes.remove(Reg.sheet.tiles.get(x));
							}
						}
						
						Reg.sheet.tiles.set(x, Reg.sheet.index);
						brush.total_members++;
					}
					
					Reg.sheet.index++;
				}
			}
			
			if (FlxG.keys.justPressed.BACKSPACE || FlxG.keys.justPressed.DELETE)
			{
				for (x in selector.getSelected())
				{
					if (Reg.sheet.tiles.exists(x))
					{
						var old_brush:Brush = Reg.sheet.brushes.get(Reg.sheet.tiles.get(x));
						old_brush.total_members--;
						
						if (old_brush.total_members <= 0)
						{
							Reg.sheet.brushes.remove(Reg.sheet.tiles.get(x));
						}
						
						Reg.sheet.tiles.remove(x);
					}
				}
			}
			
			if (FlxG.keys.justPressed.R)
			{
				for (field in Reg.proj.iterator())
				{
					if (field.type == "Checkbox")
					{
						var check:FlxUICheckBox = cast Reg.props.get(field.name);
						var check_source:FlxUICheckBox = cast Reg.props_inspect.get(field.name);
						
						check.checked = check_source.checked;
					}
					
					if (field.type == "Textfield")
					{
						var inp:FlxUIInputText = cast Reg.props.get(field.name);
						var inp_source:FlxUIInputText = cast Reg.props_inspect.get(field.name);
						
						inp.text = inp_source.text;
					}
					
					if (field.type == "Radio group")
					{
						var inp:FlxUIRadioGroup = cast Reg.props.get(field.name);
						var inp_source:FlxUIRadioGroup = cast Reg.props_inspect.get(field.name);
						
						inp.selectedId = inp_source.selectedId;
					}
				}
			}
		}
		
		if (show_inspect)
		{
			tab.getTabGroup("Inspect").visible = true;
		}
		
		else
		{
			tab.getTabGroup("Inspect").visible = false;
		}
	}
	
	public function addHUD():Void
	{
		selector = new Selector();
		hud.add(selector);
		
		var cover:FlxUI9SliceSprite = new FlxUI9SliceSprite(0, 0, Assets.CHROME, new Rectangle(0, 0, FlxG.width, 25));
		hud.add(cover);
		
		var opt:Array<StrIdLabel> = Reg.makeStrIdArray(["New project", "Open project", "Edit project", "Save project", "Close project"]);
		var proj:FlxUIDropDownMenu = new FlxUIDropDownMenu(3, 2, opt, projCall, Assets.createHeader());
		proj.header.text.text = "Project";
		hud.add(proj);
		
		var opt2:Array<StrIdLabel> = Reg.makeStrIdArray(["Open image", "Close image"]);
		var proj2:FlxUIDropDownMenu = new FlxUIDropDownMenu(proj.width + 3, 2, opt2, imgCall, Assets.createHeader());
		proj2.header.text.text = "Image";
		hud.add(proj2);
		
		var opt3:Array<StrIdLabel> = Reg.makeStrIdArray(["New sheet", "Open sheet", "Save sheet", "Close sheet"]);
		var proj3:FlxUIDropDownMenu = new FlxUIDropDownMenu(proj.width + proj2.width + 3, 2, opt3, sheetCall, Assets.createHeader());
		proj3.header.text.text = "File";
		hud.add(proj3);
		
		var tabs = [{ id:"Inspect", label:"Inspect" },
		{ id:"Apply", label:"Apply" } ];
		
		var tabs_btns:Array<FlxUIButton> = [];
		tabs_btns.push(Assets.getTab("Inspect"));
		tabs_btns.push(Assets.getTab("Apply"));
		
		tab = new FlxUITabMenu(Assets.getTabBackground(), tabs_btns, tabs, true);
		
		tab.y = 28;
		tab.width = FlxG.width * 0.30;
		tab.x = FlxG.width - tab.width;
		tab.resize(tab.width, FlxG.height - 56);
		tabRect = new FlxRect(tab.x, tab.y, tab.width, tab.height);
		
		fieldlist = new FlxUIList(0, 10, null, FlxG.width / 4, (FlxG.height - 66));
		fieldlist.x = FlxG.width - fieldlist.width;
		var tab_group_1:FlxUI = new FlxUI(null, tab);
		tab_group_1.id = "Inspect";
		//tab_group_1.add(fieldlist);
		//tab_group_1.add(new FlxUICheckBox(0, 0, FlxUIAssets.IMG_CHECK_BOX,FlxUIAssets.IMG_CHECK_MARK, "Test"));
		tab.addGroup(tab_group_1);
		
		fieldlist2 = new FlxUIList(0, 10, null, FlxG.width / 4, (FlxG.height - 80) * 0.75);
		fieldlist2.x = FlxG.width - fieldlist2.width;
		var tab_group_2:FlxUI = new FlxUI(null, tab);
		tab_group_2.id = "Apply";
		//tab_group_2.add(fieldlist2);
		//tab_group_2.add(new FlxUICheckBox(0, 0, FlxUIAssets.IMG_CHECK_BOX,FlxUIAssets.IMG_CHECK_MARK, "Test"));
		tab.addGroup(tab_group_2);
		
		hud.add(tab);
		
		var chrome2:FlxUI9SliceSprite = new FlxUI9SliceSprite(0, FlxG.height - 20, Assets.CHROME, new Rectangle(0, 0, FlxG.width, 20));
		hud.add(chrome2);
		
		name_project = new FlxUIText();
		name_project.x = 5;
		name_project.y = FlxG.height - 15;
		name_project.borderColor = 0xff000000;
		hud.add(name_project);
		
		name_image = new FlxUIText();
		name_image.x = name_project.x + name_project.width + 5;
		name_image.y = FlxG.height - 15;
		name_image.borderColor = 0xff000000;
		hud.add(name_image);
		
		name_sheet = new FlxUIText();
		name_sheet.x = name_sheet.x + name_sheet.width + 5;
		name_sheet.y = FlxG.height - 15;
		name_sheet.borderColor = 0xff000000;
		hud.add(name_sheet);
		
		updateNames();
		
		var help_btn:FlxUIButton = new FlxUIButton(0, 2, "Help", showHelp);
		Assets.setBtnGraphic(help_btn);
		help_btn.x = proj.width + proj2.width + proj3.width + 5 + 2;
		hud.add(help_btn);
		
		var plus:FlxUIButton = new FlxUIButton(0, 2, "+", zoomIn);
		Assets.setBtnGraphic(plus);
		plus.x = FlxG.width - plus.width;
		add(plus);
		
		var minus:FlxUIButton = new FlxUIButton(0, 2, "-", zoomOut);
		Assets.setBtnGraphic(minus);
		minus.x = FlxG.width - plus.width - minus.width;
		add(minus);
		
		var info_zoom:FlxUIText = new FlxUIText();
		info_zoom.y = 2;
		info_zoom.text = "Zoom: ";
		info_zoom.color = 0xffffffff;
		info_zoom.borderColor = 0xff000000;
		info_zoom.updateFrameData();
		info_zoom.x = FlxG.width - plus.width - minus.width - info_zoom.textField.width;
		add(info_zoom);
	}
	
	private function zoomIn():Void
	{
		tileset.setGraphicSize(Std.int(tileset.width * 1.2), Std.int(tileset.height * 1.2));
		tileset.setSize(Std.int(tileset.width * 1.2), Std.int(tileset.height * 1.2));
		tileset.origin.set();
		selector.zoom *= 1.2;
	}
	
	private function zoomOut():Void
	{
		tileset.setGraphicSize(Std.int(tileset.width / 1.2), Std.int(tileset.height / 1.2));
		tileset.setSize(Std.int(tileset.width / 1.2), Std.int(tileset.height / 1.2));
		tileset.origin.set();
		selector.zoom /= 1.2;
	}
	
	public function showHelp():Void
	{
		openSubState(new Help());
	}
	
	public function updateNames():Void
	{
		if (Reg.proj_name == null)
		{
			name_project.text = "No project opened.";
		}
		else
		{
			name_project.text = "Project: " + Reg.proj_name;
		}
		
		if (!Reg.image_opened)
		{
			name_image.text = "No image opened.";
		}
		else
		{
			name_image.text = "Image: " + Reg.image_name;
		}
		
		if (Reg.sheet == null)
		{
			name_sheet.text = "No tilesheet opened.";
		}
		else
		{
			name_sheet.text = "Tilesheet: " + Reg.sheet.name;
		}
		
		name_image.x = name_project.x + name_project.textField.textWidth + 5;
		name_sheet.x = name_image.x + name_image.textField.textWidth + 5;
	}
	
	private function projCall(S:String):Void
	{
		switch (S)
		{
			case "New project":
				openSubState(new NewProj());
			case "Open project":
				FileHandler.openProj(new FileReference(), loadProject);
			case "Edit project":
				if (Reg.proj == null)
				{
					openSubState(new MessagePopup("You must open a project first."));
				}
				else
				{
					openSubState(new EditProj());
				}
			case "Save project":
				if (Reg.proj == null)
				{
					openSubState(new MessagePopup("You must open a project first."));
				}
				else
				{
					FileHandler.saveProj();
				}
			case "Close project":
				if (Reg.proj == null)
				{
					openSubState(new MessagePopup("You must open a project first."));
				}
				else
				{
					if (Reg.image_opened)
					{
						openSubState(new MessagePopup("You must close the image first."));
					}
					
					else
					{
						Reg.proj_name = null;
						FlxG.switchState(new BasePage());
					}
				}
		}
	}
	
	private function imgCall(S:String):Void
	{
		if (Reg.proj == null)
		{
			openSubState(new MessagePopup("You must open a project first."));
		}
		
		else
		{
			switch (S)
			{
				case "Open image":
					new ImgHandler();
					
				case "Close image":
					if (!Reg.image_opened)
					{
						openSubState(new MessagePopup("You must open an image first."));
					}
					
					else
					{
						if (Reg.sheet == null)
						{
							under_hud.clear();
							tileset = new FlxSprite();
							tileset.makeGraphic(32, 32, 0x00000000);
							Reg.image_opened = false;
							
							updateNames();
						}
						
						else
						{
							openSubState(new MessagePopup("You must close the tilesheet first."));
						}
					}
			}
		}
	}
	
	private function sheetCall(S:String):Void
	{
		if (!Reg.image_opened)
		{
			openSubState(new MessagePopup("You must open an image first."));
		}
		
		else
		{
			switch (S)
			{
				case "New sheet":
					openSubState(new NewSheet());
					
				case "Open sheet":
					FileHandler.openSheet(new FileReference(), loadSheet);
					
				case "Save sheet":
					if (Reg.sheet == null)
					{
						openSubState(new MessagePopup("You must open a sheet first."));
					}
					else
					{
						FileHandler.saveSheet();
					}
				case "Close sheet":
					if (Reg.sheet == null)
					{
						openSubState(new MessagePopup("You must open a sheet first."));
					}
					else
					{
						Reg.sheet = null;
						updateNames();
					}
			}
		}
	}
	
	public function loadSheet(S:String):Void
	{
		Reg.sheet = Sheet.parse(S);
		
		Reg.base.updateNames();
	}
	
	public function loadProject(S:String):Void
	{
		Reg.proj = new Array<ProjField>();
		Reg.props = new Map<String, Dynamic>();
		Reg.props_inspect = new Map<String, Dynamic>();
		tab.getTabGroup("Apply").clear();
		tab.getTabGroup("Inspect").clear();
		
		if (S.length > 0)
		{
			var data:Array<Dynamic> = cast Json.parse(S);
			
			for (x in data)
			{
				if (Reflect.hasField(x, "opts"))
				{
					var n:String = Reflect.field(x, "name");
					var t:String = Reflect.field(x, "type");
					
					var radio:RadioField = new RadioField(n, t);
					radio.opts = Reflect.field(x, "opts");
					Reg.proj.push(radio);
					
					makeNewPropAssets(n, t, "Inspect", radio);
					makeNewPropAssets(n, t, "Apply", radio);
				}
				else
				{
					var n:String = Reflect.field(x, "name");
					var t:String = Reflect.field(x, "type");
					
					Reg.proj.push(new ProjField(n, t));
					
					makeNewPropAssets(n, t, "Inspect");
					makeNewPropAssets(n, t, "Apply");
				}
			}
		}
		
		Reg.base.updateNames();
	}
	
	public function updateTabs():Void
	{
		Reg.props = new Map<String, Dynamic>();
		Reg.props_inspect = new Map<String, Dynamic>();
		tab.getTabGroup("Apply").clear();
		tab.getTabGroup("Inspect").clear();
		
		for (x in Reg.proj)
		{
			if (Reflect.hasField(x, "opts"))
			{
				var n:String = Reflect.field(x, "name");
				var t:String = Reflect.field(x, "type");
				
				var radio:RadioField = new RadioField(n, t);
				radio.opts = Reflect.field(x, "opts");
				//Reg.proj.push(radio);
				
				makeNewPropAssets(n, t, "Inspect", radio);
				makeNewPropAssets(n, t, "Apply", radio);
			}
			else
			{
				var n:String = Reflect.field(x, "name");
				var t:String = Reflect.field(x, "type");
				
				//Reg.proj.push(new ProjField(n, t));
				
				makeNewPropAssets(n, t, "Inspect");
				makeNewPropAssets(n, t, "Apply");
			}
		}
	}
	
	public function makeNewPropAssets(Name:String, TypeOfUI:String, Tab:Dynamic, Radio:RadioField = null):Void
	{
		var g:FlxUIGroup = tab.getTabGroup(Tab);
		var toset:Dynamic = null;
		
		if (TypeOfUI == "Checkbox")
		{
			var n:FlxUIText = new FlxUIText();
			n.setBorderStyle(FlxText.BORDER_OUTLINE);
			n.color = 0xffffffff;
			n.borderColor = 0xffb82323;
			n.text = Name;
			n.x = 5;
			n.y = g.height + 2;
			g.add(n);
			
			var c:FlxUICheckBox = new FlxUICheckBox(5, g.height + 2, FlxUIAssets.IMG_CHECK_BOX,FlxUIAssets.IMG_CHECK_MARK, "");
			g.add(c);
			c.getLabel().setBorderStyle(FlxText.BORDER_OUTLINE);
			c.getLabel().borderColor = 0xffb82323;
			toset = c;
		}
		
		if (TypeOfUI == "Textfield")
		{
			var n:FlxUIText = new FlxUIText();
			n.setBorderStyle(FlxText.BORDER_OUTLINE);
			n.color = 0xffffffff;
			n.borderColor = 0xffb82323;
			n.text = Name;
			n.x = 5;
			n.y = g.height + 2;
			g.add(n);
			
			var t:FlxUIInputText = new FlxUIInputText();
			t.x = 5;
			t.y = g.height + 2;
			g.add(t);
			
			toset = t;
		}
		
		if (TypeOfUI == "Radio group")
		{
			var n:FlxUIText = new FlxUIText();
			n.setBorderStyle(FlxText.BORDER_OUTLINE);
			n.color = 0xffffffff;
			n.borderColor = 0xffb82323;
			n.text = Name;
			n.x = 5;
			n.y = g.height + 2;
			g.add(n);
			
			var r:FlxUIRadioGroup = new FlxUIRadioGroup(5, g.height + 4, Radio.opts, Radio.opts);
			//r.height += 20;
			g.add(r);
			toset = r;
		}
		
		var spacer:FlxSprite = new FlxSprite(5, g.height + 2).makeGraphic(Std.int(g.width), 14, 0x00000000);
		g.add(spacer);
		
		if (Tab == "Apply")
			Reg.props.set(Name, toset);
		if (Tab == "Inspect")
			Reg.props_inspect.set(Name, toset);
	}
	
	public function updateRadioField(Radio:RadioField, Tab:Dynamic):Void
	{
		if (Tab == "Apply")
		{
			//trace(Radio.name);
			var radio:FlxUIRadioGroup = cast Reg.props.get(Radio.name);
			radio.updateRadios(Radio.opts, Radio.opts);
		}
		
		if (Tab == "Inspect")
		{
			var radio:FlxUIRadioGroup = cast Reg.props_inspect.get(Radio.name);
			radio.updateRadios(Radio.opts, Radio.opts);
		}
	}
	
}