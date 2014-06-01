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
	//public var tile_width:Int;
	//public var tile_height:Int;
	public var tile_width:Float;
	public var tile_height:Float;
	
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
		sheet.index = arr[0][3];
		
		var b_keys:Array<Int> = cast arr[2];
		var b_values:Array<Dynamic> = cast arr[3];
		var ind:Int = 0;
		
		while (ind < b_keys.length)
		{
			var b:Brush = new Brush();
			b.arr = cast b_values[ind][0];
			b.total_members = cast b_values[ind][1];
			sheet.brushes.set(b_keys[ind], b);
			ind++;
		}
		
		var t_keys:Array<Int> = cast arr[4];
		var t_values:Array<Int> = cast arr[5];
		var ind2:Int = 0;
		
		while (ind2 < t_keys.length)
		{
			sheet.tiles.set(t_keys[ind2], t_values[ind2]);
			ind2++;
		}
		
		return sheet;
	}
	
	public function stringify():String
	{
		var arr:Array<Dynamic> = [];
		arr.push([name, tile_width, tile_height, index]);
		
		var arr2:Array<String> = [];
		for (x in Reg.proj)
		{
			arr2.push(x.name);
		}
		arr.push(arr2);
		
		var b_keys:Array<Int> = [];
		var b_values:Array<Dynamic> = [];
		for (k in brushes.keys())
		{
			b_keys.push(k);
			b_values.push([brushes.get(k).arr, brushes.get(k).total_members]);
		}
		arr.push(b_keys);
		arr.push(b_values);
		
		var t_keys:Array<Int> = [];
		var t_values:Array<Int> = [];
		for (k in tiles.keys())
		{
			t_keys.push(k);
			t_values.push(tiles.get(k));
		}
		arr.push(t_keys);
		arr.push(t_values);
		
		return Json.stringify(arr);
	}
	
}