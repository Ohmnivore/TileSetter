package ;
import flash.display.BitmapData;
import openfl.display.Loader;
import openfl.display.LoaderInfo;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;
import flixel.addons.display.FlxGridOverlay;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import haxe.io.Bytes;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.display.Loader;
import flixel.util.loaders.CachedGraphics;

#if flash
import flash.net.FileReference;
#else
import sys.io.File;
import systools.Dialogs;
#end

/**
 * ...
 * @author Ohmnivore
 */
class ImgHandler
{
	#if flash
	public var seek:FileReference;
	#else
	public var seek:URLLoader;
	#end
	public var s:BasePage;
	
	public function new()
	{
		s = Reg.base;
		
		#if flash
		seek = new FileReference();
		seek.addEventListener(Event.SELECT, onSelect);
		seek.browse();
		#else
		var opts:FILEFILTERS = { count: 1, descriptions: ["Image file"], extensions: ["*.*"] };
		var selected:Array<String> = Dialogs.openFile("Open image", "", opts);
		if (selected.length > 0)
		{
			var path:String = selected[0];
			
			var l:Loader = new Loader();
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, loadBytesHandler);
			//l.loadBytes(cast File.getBytes(path));
			l.load(new URLRequest(path));
		}
		#end
	}
	
	private function onSelect(e:Dynamic):Void
	{
		#if flash
		seek.load();
		seek.addEventListener(Event.COMPLETE, onComplete);
		#else
		#end
	}
	
	private function onComplete(e:Dynamic):Void
	{
		#if flash
		var l:Loader = new Loader();
		l.contentLoaderInfo.addEventListener(Event.COMPLETE, loadBytesHandler);
		l.loadBytes(seek.data);
		#else
		#end
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
		
		#if flash
		Reg.image_name = seek.name;
		#else
		Reg.image_name = "Unfinished feature";
		#end
		
		Reg.image_opened = true;
		Reg.base.updateNames();
		Reg.base.selector.zoom = 1;
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