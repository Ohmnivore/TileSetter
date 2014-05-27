package substates;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUISubState;
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
		
		inp = new FlxUIInputText();
		add(inp);
		FlxSpriteUtil.screenCenter(inp, true, true);
		
		var go:FlxUIButton = new FlxUIButton(0, inp.y + 20, "New project", createNew);
		add(go);
		FlxSpriteUtil.screenCenter(go, true, false);
		
		var cancel:FlxUIButton = new FlxUIButton(0, go.y + 20, "Cancel", cancel);
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