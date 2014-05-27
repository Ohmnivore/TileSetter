package ;
import flash.net.FileReference;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUIList;
import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUIText;
import flixel.addons.ui.StrIdLabel;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.util.FlxSpriteUtil;
import substates.NewProj;
import substates.EditProj;
import tjson.TJSON;

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
	
	public var fieldlist:FlxUIList;
	
	override public function create() 
	{
		super.create();
		Reg.base = this;
		Reg.proj = new Array<ProjField>();
		
		FlxG.scaleMode = new RatioScaleMode();
		
		under_hud = new FlxGroup();
		hud = new FlxGroup();
		add(under_hud);
		add(hud);
		
		tileset = new FlxSprite();
		under_hud.add(tileset);
		
		addHUD();
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
		//if (FlxG.keys.justPressed.R)
		//{
			//trace(selector.getSelected());
		//}
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
		
		var opt2:Array<StrIdLabel> = Reg.makeStrIdArray(["New sheet", "Open sheet", "Save sheet", "Close sheet"]);
		var proj2:FlxUIDropDownMenu = new FlxUIDropDownMenu(proj.width, 0, opt2, imgCall);
		hud.add(proj2);
		
		//var opt3:Array<StrIdLabel> = Reg.makeStrIdArray(["New sheet", "Open sheet", "Save sheet", "Close sheet"]);
		//var proj3:FlxUIDropDownMenu = new FlxUIDropDownMenu(proj.width + proj2.width, 0, opt3);
		//hud.add(proj3);
		
		fieldlist = new FlxUIList(0, 80, null, FlxG.width / 4, (FlxG.height - 80) * 0.75);
		fieldlist.x = FlxG.width - fieldlist.width;
		hud.add(fieldlist);
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
				openSubState(new EditProj());
			case "Save project":
				FileHandler.saveProj();
		}
	}
	
	private function imgCall(S:String):Void
	{
		switch (S)
		{
			case "New sheet":
				//new ImgHandler();
				
			case "Close image":
				
		}
	}
	
	public function loadProject(S:String):Void
	{
		Reg.proj = new Array<ProjField>();
		
		if (S.length > 0)
		{
			var data:Array<Dynamic> = cast TJSON.parse(S);
			
			for (x in data)
			{
				var n:String = Reflect.field(x, "name");
				var t:String = Reflect.field(x, "type");
				
				Reg.proj.push(new ProjField(n, t));
				makeNewPropAssets(n, t);
			}
		}
	}
	
	private function makeNewPropAssets(Name:String, TypeOfUI:String):Void
	{
		var g:FlxUIGroup = new FlxUIGroup();
		
		var n:FlxUIText = new FlxUIText();
		n.text = Name;
		g.add(n);
		
		var t:FlxUIText = new FlxUIText();
		t.text = TypeOfUI;
		t.x += 100;
		g.add(t);
		
		var r:FlxUIButton = new FlxUIButton(200, 0, "Remove");
		r.params = [g, n.text, t.text];
		g.add(r);
		
		fieldlist.add(g);
		fieldlist.refreshList();
	}
	
}