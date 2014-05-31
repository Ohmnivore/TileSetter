package ;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIAssets;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIDropDownMenu.FlxUIDropDownHeader;
import flixel.addons.ui.FlxUISpriteButton;
import flixel.addons.ui.FlxUIText;
import flixel.addons.ui.FlxUITypedButton.FlxUITypedButton;
import flixel.FlxSprite;
import flixel.util.FlxStringUtil;

/**
 * ...
 * @author ...
 */
class Assets
{
	static public var CHROME:String = "assets/images/chrome.png";
	static public var BUTTON:String = "assets/images/button.png";
	static public var BUTTON_THIN:String = "assets/images/button_thin.png";
	
	static public function setBtnGraphic(Btn:FlxUIButton):Void
	{
		Btn.loadGraphicSlice9([Assets.BUTTON], 80, 20, []);
		Btn.label.color = 0xff000000;
	}
	
	static public function createHeader(Width:Int = 120):FlxUIDropDownHeader
	{
		var btn:FlxUISpriteButton;
		btn = new FlxUISpriteButton(0, 0, new FlxSprite(0, 0, FlxUIAssets.IMG_DROPDOWN));
		btn.loadGraphicSlice9([Assets.BUTTON_THIN], 80, 20, 
								[FlxStringUtil.toIntArray(FlxUIAssets.SLICE9_BUTTON)],
								FlxUI9SliceSprite.TILE_NONE, -1, false, FlxUIAssets.IMG_BUTTON_SIZE, FlxUIAssets.IMG_BUTTON_SIZE);
		return new FlxUIDropDownHeader(Width, null, null, btn);
	}
	
	static public function getStepperPlus():FlxUITypedButton<FlxSprite>
	{
		var ButtonPlus:FlxUITypedButton<FlxSprite> = new FlxUITypedButton<FlxSprite>(0, 0);
		ButtonPlus.loadGraphicSlice9([Assets.BUTTON_THIN], 21, 21, [FlxStringUtil.toIntArray(FlxUIAssets.SLICE9_BUTTON_THIN)], FlxUI9SliceSprite.TILE_NONE, -1, false, FlxUIAssets.IMG_BUTTON_SIZE, FlxUIAssets.IMG_BUTTON_SIZE);
		ButtonPlus.label = new FlxSprite(0, 0, FlxUIAssets.IMG_PLUS);
		
		return ButtonPlus;
	}
	
	static public function getStepperMinus():FlxUITypedButton<FlxSprite>
	{
		var ButtonPlus:FlxUITypedButton<FlxSprite> = new FlxUITypedButton<FlxSprite>(0, 0);
		ButtonPlus.loadGraphicSlice9([Assets.BUTTON_THIN], 21, 21, [FlxStringUtil.toIntArray(FlxUIAssets.SLICE9_BUTTON_THIN)], FlxUI9SliceSprite.TILE_NONE, -1, false, FlxUIAssets.IMG_BUTTON_SIZE, FlxUIAssets.IMG_BUTTON_SIZE);
		ButtonPlus.label = new FlxSprite(0, 0, FlxUIAssets.IMG_MINUS);
		
		return ButtonPlus;
	}
}