package substates;
import flash.geom.Rectangle;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIPopup;
import flixel.addons.ui.interfaces.IFlxUIWidget;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;

/**
 * ...
 * @author Ohmnivore
 */
class Help extends FlxUIPopup
{
	private var message:String;
	
	public function new()
	{
		super();
	}
	
	override public function create():Void 
	{
		//Help message
		message = "Open a project, then an image, then a tilesheet. If necessary, create them. " +
			"Note that creating a new file doesn't automaticaly open it, you need to do this youself. " +
			"Once that's done, select tiles by clicking, holding, then releasing the left mouse button. " +
			"Hold W/A/S/D to move the tilemap around, and press the spacebar to center it. " +
			"Press Q to apply to selected tiles the properties defined in the Apply tab. " +
			"Press E to read the properties of selected tiles. They will be shown in the Inspect tab " +
			"if the tiles have been assigned a property and if their properties are all the same. " +
			"Press Backspace or Delete to remove all properties from selected tiles. " +
			"Press R to set the Apply tab's properties same as the Inspect tab's properties. " +
			"\n\nCoded by Ohmnivore." +
			"\nVersion: " + Reg.VERSION;
		
		_xml_id = "message_popup";
		
		super.create();
		
		var chrome:FlxUI9SliceSprite = new FlxUI9SliceSprite(0, 0, null, new Rectangle(0, 0, 400, 200));
		FlxSpriteUtil.screenCenter(chrome);
		add(chrome);
		
		var t:FlxText = new FlxText(0, 0, chrome.width - 20, message);
		FlxSpriteUtil.screenCenter(t, true, false);
		t.y = chrome.y + 20;
		add(t);
		
		var ok:FlxUIButton = new FlxUIButton(0, 0, "OK", close);
		FlxSpriteUtil.screenCenter(ok, true, false);
		ok.y = chrome.y + chrome.height - 30;
		add(ok);
	}
	
	override public function getEvent(id:String, sender:IFlxUIWidget, data:Array<Dynamic>, ?eventParams:Array<Dynamic>):Void 
	{
		
	}
}