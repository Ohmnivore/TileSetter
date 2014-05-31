package substates;
import flash.geom.Rectangle;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUIList;
import flixel.addons.ui.FlxUISubState;
import flixel.addons.ui.FlxUIText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Ohmnivore
 */
class EditRadio extends FlxUISubState
{
	public var name:FlxUIInputText;
	public var fieldlist:FlxUIList;
	
	public var radio:RadioField;
	
	public function new(Radio:RadioField)
	{
		super();
		
		radio = Radio;
	}
	
	override public function create():Void 
	{
		super.create();
		
		add(new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0x99000000));
		
		var chrome:FlxUI9SliceSprite = new FlxUI9SliceSprite(0, 0, null, new Rectangle(0, 0, FlxG.width, FlxG.height - 60));
		FlxSpriteUtil.screenCenter(chrome);
		add(chrome);
		
		name = new FlxUIInputText();
		name.x = 10;
		name.y = 43;
		name.text = "Option name";
		add(name);
		
		var go:FlxUIButton = new FlxUIButton(10 + name.width + 5, 40, "Add", makeNewProp);
		add(go);
		
		var ret:FlxUIButton = new FlxUIButton(10 + name.width + go.width + 5, 40, "Done", cancel);
		add(ret);
		
		fieldlist = new FlxUIList(10, 95, null, FlxG.width, (FlxG.height - 95) * 0.75);
		add(fieldlist);
		
		for (x in radio.opts)
		{
			makeNewPropAssets(x);
		}
	}
	
	private function makeNewProp():Void
	{
		var found:Bool = false;
		
		for (opt in radio.opts)
		{
			if (name.text == opt)
			{
				found = true;
			}
		}
		
		if (!found)
		{
			makeNewPropAssets(name.text);
			
			radio.opts.push(name.text);
		}
	}
	
	private function makeNewPropAssets(Name:String):Void
	{
		var g:FlxUIGroup = new FlxUIGroup();
		
		var n:FlxUIText = new FlxUIText();
		n.text = Name;
		g.add(n);
		
		var r:FlxUIButton = new FlxUIButton(200, 0, "Remove");
		r.params = [g, n.text];
		g.add(r);
		
		fieldlist.add(g);
		fieldlist.refreshList();
	}
	
	public override function getEvent(id:String, target:Dynamic, data:Dynamic, ?params:Array<Dynamic>):Void
	{
		if (params != null)
		{
			switch(id)
			{
				case "click_button":
					var g:FlxUIGroup = cast params[0];
					fieldlist.remove(g, true);
					fieldlist.refreshList();
					radio.opts.remove(cast params[1]);
			}
		}
	}
	
	private function cancel():Void
	{
		Reg.base.updateRadioField(radio, "Apply");
		Reg.base.updateRadioField(radio, "Inspect");
		close();
	}
}