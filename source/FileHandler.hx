package ;

import flash.display.Loader;
import flash.net.FileReference;
import flash.net.FileFilter;
import flash.events.Event;
import flixel.FlxG;
import haxe.Json;

/**
 * ...
 * @author Ohmnivore
 */
class FileHandler
{
	static private var call:String->Void;
	
	static public function newProj(Name:String):Void
	{
		var ref:FileReference = new FileReference();
		ref.save("", Name + ".tset");
	}
	
	static public function newSheet(Name:String, TileWidth:Float, TileHeight:Float):Void
	{
		var ref:FileReference = new FileReference();
		
		Reg.sheet = new Sheet(Name, Std.int(TileWidth), Std.int(TileHeight));
		
		ref.save(Reg.sheet.stringify(), Name + ".json");
	}
	
	static public function openSheet(FileRef:FileReference, Callback:String->Void):Void
	{
		call = Callback;
		FileRef.addEventListener(Event.SELECT, onSelect);
		FileRef.browse([new FileFilter("TileSetter level", "*.json")]);
	}
	
	static public function saveSheet():Void
	{
		var ref:FileReference = new FileReference();
		ref.save(Reg.sheet.stringify(), Reg.sheet.name + ".json");
	}
	
	static public function openProj(FileRef:FileReference, Callback:String->Void):Void
	{
		call = Callback;
		FileRef.addEventListener(Event.SELECT, onSelectProj);
		FileRef.browse([new FileFilter("TileSetter project", "*.tset")]);
	}
	
	static public function saveProj():Void
	{
		var ref:FileReference = new FileReference();
		ref.save(Json.stringify(Reg.proj), Reg.proj_name);
	}
	
	static private function onSelectProj(e:Event):Void
	{
		var f:FileReference = cast e.target;
		Reg.proj_name = f.name;
		f.load();
		f.addEventListener(Event.COMPLETE, onComplete);
	}
	
	static private function onSelect(e:Event):Void
	{
		var f:FileReference = cast e.target;
		f.load();
		f.addEventListener(Event.COMPLETE, onComplete);
	}
	
	static private function onComplete(e:Dynamic):Void
	{
		var f:FileReference = cast e.target;
		var inp:String = f.data.readMultiByte(f.data.length, "iso-8859-01");
		call(inp);
	}
	
}