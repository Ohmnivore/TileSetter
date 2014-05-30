package ;
import haxe.Json;
import haxe.Serializer;
import haxe.Unserializer;

/**
 * ...
 * @author Ohmnivore
 */
class Sheet
{
	public var name:String;
	public var tile_width:Int;
	public var tile_height:Int;
	
	public var brushes:Map<Int, Brush>;
	public var tiles:Map<Int, Int>;
	public var index:Int = 0;
	
	public function new(Name:String, TileWidth:Int, TileHeight:Int) 
	{
		name = Name;
		tile_width = TileWidth;
		tile_height = TileHeight;
		
		brushes = new Map<Int, Brush>();
		tiles = new Map<Int, Int>();
	}
	
	static public function parse(S:String):Sheet
	{
		var arr:Array<Dynamic> = cast Json.parse(S);
		var sheet:Sheet = new Sheet(arr[0][0], arr[0][1], arr[0][2]);
		
		sheet.brushes = cast Unserializer.run(arr[2]);
		sheet.tiles = cast Unserializer.run(arr[3]);
		
		return sheet;
	}
	
	public function stringify():String
	{
		var arr:Array<Dynamic> = [];
		arr.push([name, tile_width, tile_height]);
		
		var arr2:Array<String> = [];
		for (x in Reg.proj)
		{
			arr2.push(x.name);
		}
		arr.push(arr2);
		
		arr.push(Serializer.run(brushes));
		
		arr.push(Serializer.run(tiles));
		
		return Json.stringify(arr);
	}
	
}