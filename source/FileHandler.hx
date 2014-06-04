package ;

import flash.events.Event;
import flixel.FlxG;
import haxe.io.Path;
import haxe.Json;

#if flash
import flash.display.Loader;
import flash.net.FileReference;
import flash.net.FileFilter;
#else
import systools.Dialogs;
import sys.FileStat;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileInput;
#end

/**
 * ...
 * @author Ohmnivore
 */
class FileHandler
{
	static private var call:String->Void;
	
	static public function newProj(Name:String):Void
	{
		#if flash
		var ref:FileReference = new FileReference();
		ref.save("", Name + ".tset");
		#else
		var opts:FILEFILTERS = { count: 1, descriptions: ["TileSetter project"], extensions: ["*.tset"] };
		var path:String = Path.withExtension(Dialogs.saveFile("New project", "", "", opts), "tset");
		File.write(path);
		#end
	}
	
	static public function newSheet(Name:String, TileWidth:Float, TileHeight:Float):Void
	{
		#if flash
		var ref:FileReference = new FileReference();
		
		Reg.sheet = new Sheet(Name, Std.int(TileWidth), Std.int(TileHeight));
		
		ref.save(Reg.sheet.stringify(), Name + ".json");
		#else
		var opts:FILEFILTERS = { count: 1, descriptions: ["TileSetter tilesheet"], extensions: ["*.json"] };
		var path:String = Path.withExtension(Dialogs.saveFile("New tilesheet", "", "", opts), "json");
		File.write(path);
		#end
	}
	
	static public function openSheet(FileRef:Dynamic, Callback:String->Void):Void
	{
		call = Callback;
		#if flash
		FileRef.addEventListener(Event.SELECT, onSelect);
		FileRef.browse([new FileFilter("TileSetter tilesheet", "*.json")]);
		#else
		var opts:FILEFILTERS = { count: 1, descriptions: ["TileSetter project"], extensions: ["*.json"] };
		var selected:Array<String> = Dialogs.openFile("Open tilesheet", "", opts);
		if (selected.length > 0)
		{
			var path:String = selected[0];
			var inp:String = cast File.getContent(path);
			call(inp);
		}
		#end
	}
	
	static public function saveSheet():Void
	{
		#if flash
		var ref:FileReference = new FileReference();
		ref.save(Reg.sheet.stringify(), Reg.sheet.name + ".json");
		#else
		var opts:FILEFILTERS = { count: 1, descriptions: ["TileSetter tilesheet"], extensions: ["*.json"] };
		var path:String = Dialogs.saveFile("Save tilesheet", "", "", opts);
		File.saveContent(path, Reg.sheet.stringify());
		#end
	}
	
	static public function openProj(FileRef:Dynamic, Callback:String->Void):Void
	{
		call = Callback;
		#if flash
		FileRef.addEventListener(Event.SELECT, onSelectProj);
		FileRef.browse([new FileFilter("TileSetter project", "*.tset")]);
		#else
		var opts:FILEFILTERS = { count: 1, descriptions: ["TileSetter project"], extensions: ["*.tset"] };
		var selected:Array<String> = Dialogs.openFile("Open project", "", opts);
		if (selected.length > 0)
		{
			var path:String = selected[0];
			var inp:String = File.getContent(path);
			call(inp);
		}
		#end
	}
	
	static public function saveProj():Void
	{
		#if flash
		var ref:FileReference = new FileReference();
		ref.save(Json.stringify(Reg.proj), Reg.proj_name);
		#else
		var opts:FILEFILTERS = { count: 1, descriptions: ["TileSetter project"], extensions: ["*.tset"] };
		var path:String = Dialogs.saveFile("Save project", "", "", opts);
		File.saveContent(path, Json.stringify(Reg.proj));
		#end
	}
	
	static private function onSelectProj(e:Event):Void
	{
		#if flash
		var f:FileReference = cast e.target;
		Reg.proj_name = f.name;
		f.load();
		f.addEventListener(Event.COMPLETE, onComplete);
		#else
		#end
	}
	
	static private function onSelect(e:Event):Void
	{
		#if flash
		var f:FileReference = cast e.target;
		f.load();
		f.addEventListener(Event.COMPLETE, onComplete);
		#else
		#end
	}
	
	static private function onComplete(e:Dynamic):Void
	{
		#if flash
		var f:FileReference = cast e.target;
		var inp:String = f.data.readMultiByte(f.data.length, "iso-8859-01");
		call(inp);
		#else
		#end
	}
	
}