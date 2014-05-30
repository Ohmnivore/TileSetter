package substates;
import flash.geom.Rectangle;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIPopup;
import flixel.addons.ui.interfaces.IFlxUIWidget;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;

/**
 * ...
 * @author Ohmnivore
 */
class MessagePopup extends FlxUIPopup
{
	private var message:String = "";
	
	public function new(Message:String)
	{
		super();
		
		message = Message;
	}
	
	override public function create():Void 
	{
		_xml_id = "message_popup";
		
		super.create();
		
		add(new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0x99000000));
		
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