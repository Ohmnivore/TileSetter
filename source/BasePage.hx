package ;
import flash.net.FileReference;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUIAssets;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUIList;
import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUIText;
import flixel.addons.ui.StrIdLabel;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.util.FlxRect;
import flixel.util.FlxSpriteUtil;
import haxe.Json;
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
	
	override public function create() 
	{
		super.create();
		Reg.base = this;
		//Reg.proj = new Array<ProjField>();
		
		FlxG.scaleMode = new RatioScaleMode();
		
		under_hud = new FlxGroup();
		hud = new FlxGroup();
		add(under_hud);
		add(hud);
		
		tileset = new FlxSprite();
		under_hud.add(tileset);
		
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
		if (!tabRect.containsFlxPoint(FlxG.mouse.getScreenPosition()))
		{
			if (FlxG.mouse.justPressed && FlxG.mouse.y > 21)
			{
				selector.setFirstAnchor(FlxG.mouse.x, FlxG.mouse.y, tileset);
			}
			if (FlxG.mouse.justReleased && FlxG.mouse.y > 21)
			{
				selector.setFinalAnchor(FlxG.mouse.x, FlxG.mouse.y, tileset);
			}
			if (FlxG.mouse.pressed && FlxG.mouse.y > 21)
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
					
					Reg.sheet.brushes.set(Reg.sheet.index, brush);
					
					for (x in selector.getSelected())
					{
						Reg.sheet.tiles.set(x, Reg.sheet.index);
					}
				}
				
				Reg.sheet.index++;
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
		
		var cover:FlxSprite = new FlxSprite(0, 0);
		cover.scrollFactor.set();
		cover.makeGraphic(FlxG.width, 20, 0x99ffffff);
		hud.add(cover);
		
		var opt:Array<StrIdLabel> = Reg.makeStrIdArray(["New project", "Open project", "Edit project", "Save project", "Close project"]);
		var proj:FlxUIDropDownMenu = new FlxUIDropDownMenu(0, 0, opt, projCall);
		hud.add(proj);
		
		var opt2:Array<StrIdLabel> = Reg.makeStrIdArray(["Open image", "Close image"]);
		var proj2:FlxUIDropDownMenu = new FlxUIDropDownMenu(proj.width, 0, opt2, imgCall);
		hud.add(proj2);
		
		var opt3:Array<StrIdLabel> = Reg.makeStrIdArray(["New sheet", "Open sheet", "Save sheet", "Close sheet"]);
		var proj3:FlxUIDropDownMenu = new FlxUIDropDownMenu(proj.width + proj2.width, 0, opt3, sheetCall);
		hud.add(proj3);
		
		var tabs = [{ id:"Inspect", label:"Inspect" },
		{ id:"Apply", label:"Apply" }];
		
		tab = new FlxUITabMenu(null, tabs, true);
		
		tab.y = 21;
		tab.width = FlxG.width * 0.30;
		tab.x = FlxG.width - tab.width;
		tabRect = new FlxRect(tab.x, tab.y, tab.width, tab.height);
		
		fieldlist = new FlxUIList(0, 0, null, FlxG.width / 4, (FlxG.height - 80) * 0.75);
		fieldlist.x = FlxG.width - fieldlist.width;
		var tab_group_1:FlxUI = new FlxUI(null, tab);
		tab_group_1.id = "Inspect";
		//tab_group_1.add(fieldlist);
		//tab_group_1.add(new FlxUICheckBox(0, 0, FlxUIAssets.IMG_CHECK_BOX,FlxUIAssets.IMG_CHECK_MARK, "Test"));
		tab.addGroup(tab_group_1);
		
		fieldlist2 = new FlxUIList(0, 0, null, FlxG.width / 4, (FlxG.height - 80) * 0.75);
		fieldlist2.x = FlxG.width - fieldlist2.width;
		var tab_group_2:FlxUI = new FlxUI(null, tab);
		tab_group_2.id = "Apply";
		//tab_group_2.add(fieldlist2);
		//tab_group_2.add(new FlxUICheckBox(0, 0, FlxUIAssets.IMG_CHECK_BOX,FlxUIAssets.IMG_CHECK_MARK, "Test"));
		tab.addGroup(tab_group_2);
		
		hud.add(tab);
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
					//FileHandler.saveProj();
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
					
			}
		}
	}
	
	private function sheetCall(S:String):Void
	{
		if (Reg.proj == null)
		{
			openSubState(new MessagePopup("You must open a project first."));
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
						//FileHandler.saveSheet();
					}
			}
		}
	}
	
	public function loadSheet(S:String):Void
	{
		Reg.sheet = Sheet.parse(S);
	}
	
	public function loadProject(S:String):Void
	{
		Reg.proj = new Array<ProjField>();
		Reg.props = new Map<String, Dynamic>();
		Reg.props_inspect = new Map<String, Dynamic>();
		
		if (S.length > 0)
		{
			var data:Array<Dynamic> = cast Json.parse(S);
			
			for (x in data)
			{
				var n:String = Reflect.field(x, "name");
				var t:String = Reflect.field(x, "type");
				
				Reg.proj.push(new ProjField(n, t));
				
				makeNewPropAssets(n, t, "Inspect");
				makeNewPropAssets(n, t, "Apply");
			}
		}
	}
	
	private function makeNewPropAssets(Name:String, TypeOfUI:String, Tab:Dynamic):Void
	{
		var g:FlxUIGroup = tab.getTabGroup(Tab);
		var toset:Dynamic = null;
		
		if (TypeOfUI == "Checkbox")
		{
			var c:FlxUICheckBox = new FlxUICheckBox(0, g.y + g.frameHeight, FlxUIAssets.IMG_CHECK_BOX,FlxUIAssets.IMG_CHECK_MARK, Name);
			g.add(c);
			toset = c;
		}
		
		if (TypeOfUI == "Textfield")
		{
			var t:FlxUIInputText = new FlxUIInputText();
			t.x = 0;
			g.add(t);
			
			var n:FlxUIText = new FlxUIText();
			n.color = 0xffffffff;
			n.borderColor = 0xff000000;
			n.text = Name;
			n.x = t.width;
			g.add(n);
			
			toset = t;
		}
		
		if (Tab == "Apply")
			Reg.props.set(Name, toset);
		if (Tab == "Inspect")
			Reg.props_inspect.set(Name, toset);
	}
	
}