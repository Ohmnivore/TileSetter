package;

import flixel.util.FlxSave;
import flixel.addons.ui.StrIdLabel;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	public static inline var VERSION:String = "0.1";
	
	static public function makeStrIdArray(Arr:Array<String>):Array<StrIdLabel>
	{
		var ret:Array<StrIdLabel> = [];
		
		for (s in Arr)
		{
			ret.push(new StrIdLabel(s, s));
		}
		
		return ret;
	}
	
	public static var image_opened:Bool = false;
	
	public static var proj_name:String;
	
	public static var image_name:String;
	
	public static var sheet:Sheet;
	
	public static var props_inspect:Map<String, Dynamic>;
	
	public static var props:Map<String, Dynamic>;
	
	public static var proj:Array<ProjField>;
	
	public static var base:BasePage;
	
	/**
	 * Generic levels Array that can be used for cross-state stuff.
	 * Example usage: Storing the levels of a platformer.
	 */
	public static var levels:Array<Dynamic> = [];
	/**
	 * Generic level variable that can be used for cross-state stuff.
	 * Example usage: Storing the current level number.
	 */
	public static var level:Int = 0;
	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level.
	 */
	public static var scores:Array<Dynamic> = [];
	/**
	 * Generic score variable that can be used for cross-state stuff.
	 * Example usage: Storing the current score.
	 */
	public static var score:Int = 0;
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];
}