package substates;
import flash.geom.Rectangle;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUISubState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Ohmnivore
 */
class NewProj extends FlxUISubState
{
	private var inp:FlxUIInputText;
	
	override public function create():Void 
	{
		super.create();
		
		add(new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0x99000000));
		
		var chrome:FlxUI9SliceSprite = new FlxUI9SliceSprite(0, 0, Assets.CHROME, new Rectangle(0, 0, 400, 200));
		FlxSpriteUtil.screenCenter(chrome);
		add(chrome);
		
		inp = new FlxUIInputText();
		add(inp);
		FlxSpriteUtil.screenCenter(inp, true, true);
		inp.text = "Project name";
		
		var go:FlxUIButton = new FlxUIButton(0, inp.y + 20, "New project", createNew);
		Assets.setBtnGraphic(go);
		add(go);
		FlxSpriteUtil.screenCenter(go, true, false);
		
		var cancel:FlxUIButton = new FlxUIButton(0, go.y + 20, "Cancel", cancel);
		Assets.setBtnGraphic(cancel);
		add(cancel);
		FlxSpriteUtil.screenCenter(cancel, true, false);
	}
	
	private function createNew():Void
	{
		FileHandler.newProj(inp.text);
		close();
	}
	
	private function cancel():Void
	{
		close();
	}
}