package substates;
import flash.display.Bitmap;
import flash.geom.Rectangle;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUISubState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxSpriteUtil;
import flash.net.FileReference;

/**
 * ...
 * @author Ohmnivore
 */
class NewSheet extends FlxUISubState
{
	private var inp:FlxUIInputText;
	private var inp2:FlxUINumericStepper;
	private var inp3:FlxUINumericStepper;
	
	override public function create():Void 
	{
		super.create();
		
		add(new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0x99000000));
		
		var chrome:FlxUI9SliceSprite = new FlxUI9SliceSprite(0, 0, null, new Rectangle(0, 0, 400, 200));
		FlxSpriteUtil.screenCenter(chrome);
		add(chrome);
		
		inp = new FlxUIInputText();
		add(inp);
		FlxSpriteUtil.screenCenter(inp, true, true);
		inp.text = "Sheet name";
		inp2 = new FlxUINumericStepper(0, 0, 1, 16, 1, 999, 0, FlxUINumericStepper.STACK_HORIZONTAL, new FlxText(0, 0, 0, "Tile width"));
		FlxSpriteUtil.screenCenter(inp2);
		inp2.y += inp.height + 4;
		add(inp2);
		add(new FlxText(inp2.x + inp2.width, inp2.y, 0, "Tile width"));
		inp3 = new FlxUINumericStepper(0, 0, 1, 16, 1, 999, 0, FlxUINumericStepper.STACK_HORIZONTAL, new FlxText(0, 0, 0, "Tile width"));
		FlxSpriteUtil.screenCenter(inp3);
		inp3.y += inp.height + 4 + inp2.height;
		add(inp3);
		add(new FlxText(inp3.x + inp3.width, inp3.y, 0, "Tile height"));
		
		var go:FlxUIButton = new FlxUIButton(0, inp3.y + 20, "New sheet", createNew);
		add(go);
		FlxSpriteUtil.screenCenter(go, true, false);
		
		var cancel:FlxUIButton = new FlxUIButton(0, go.y + 20, "Cancel", cancel);
		add(cancel);
		FlxSpriteUtil.screenCenter(cancel, true, false);
	}
	
	private function createNew():Void
	{
		FileHandler.newSheet(inp.text, inp2.value, inp3.value);
		close();
	}
	
	private function cancel():Void
	{
		close();
	}
}