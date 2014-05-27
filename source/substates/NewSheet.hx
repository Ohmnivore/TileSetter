package substates;
import flash.display.Bitmap;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUISubState;
import flixel.util.FlxSpriteUtil;
import flash.net.FileReference;

/**
 * ...
 * @author Ohmnivore
 */
class NewSheet extends FlxUISubState
{
	private var inp:FlxUIInputText;
	private var inp2:FlxUIInputText;
	private var inp3:FlxUIInputText;
	
	override public function create():Void 
	{
		super.create();
		
		inp = new FlxUIInputText();
		add(inp);
		FlxSpriteUtil.screenCenter(inp, true, true);
		inp.text = "Sheet name";
		inp2 = new FlxUIInputText();
		add(inp2);
		FlxSpriteUtil.screenCenter(inp2, true, true);
		inp2.x += inp.width;
		inp2.text = "Tile width";
		inp3 = new FlxUIInputText();
		add(inp3);
		FlxSpriteUtil.screenCenter(inp3, true, true);
		inp3.x += inp.width + inp2.width;
		inp3.text = "Tile height";
		
		var go:FlxUIButton = new FlxUIButton(0, inp.y + 20, "New sheet", createNew);
		add(go);
		FlxSpriteUtil.screenCenter(go, true, false);
		
		var cancel:FlxUIButton = new FlxUIButton(0, go.y + 20, "Cancel", cancel);
		add(cancel);
		FlxSpriteUtil.screenCenter(cancel, true, false);
	}
	
	private function createNew():Void
	{
		FileHandler.newSheet(inp.text, inp2.text, inp3.text);
		close();
	}
	
	private function cancel():Void
	{
		close();
	}
}