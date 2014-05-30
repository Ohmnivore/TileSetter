package ;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.Event;
import flash.net.FileReference;
import flixel.addons.display.FlxGridOverlay;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Ohmnivore
 */
class ImgHandler
{
	public var seek:FileReference;
	public var s:BasePage;
	
	public function new()
	{
		s = Reg.base;
		
		seek = new FileReference();
		seek.addEventListener(Event.SELECT, onSelect);
		seek.browse();
	}
	
	private function onSelect(e:Dynamic):Void
	{
		seek.load();
		seek.addEventListener(Event.COMPLETE, onComplete);
	}
	
	private function onComplete(e:Dynamic):Void
	{
		var l:Loader = new Loader();
		l.contentLoaderInfo.addEventListener(Event.COMPLETE, loadBytesHandler);
		l.loadBytes(seek.data);
	}
	
	private function loadBytesHandler(event:Event):Void
	{
		var loaderInfo:LoaderInfo = cast(event.target, LoaderInfo);
		
		s.tileset = loaderToFlxSprite(loaderInfo);
		
		FlxGridOverlay.overlay(s.tileset, 16, 16, Std.int(s.tileset.width), Std.int(s.tileset.height), false,
			true, 0x00000000, 0x33000000);
		
		s.under_hud.clear();
		s.under_hud.add(s.tileset);
		
		FlxSpriteUtil.screenCenter(s.tileset, true, true);
		
		Reg.image_name = seek.name;
		
		Reg.image_opened = true;
		Reg.base.updateNames();
	}
	
	public function loaderToFlxSprite(L:LoaderInfo):FlxSprite
	{
		var spr:FlxSprite = new FlxSprite(0, 0);
		spr.makeGraphic(Std.int(L.content.width), Std.int(L.content.height));
		var temp:BitmapData = spr.pixels;
		temp.draw(L.content);
		return spr;
	}
	
}