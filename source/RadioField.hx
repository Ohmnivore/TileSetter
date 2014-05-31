package ;

/**
 * ...
 * @author Ohmnivore
 */
class RadioField extends ProjField
{
	public var opts:Array<String>;
	
	public function new(Name:String, TypeOfUI:String) 
	{
		super(Name, TypeOfUI);
		
		opts = [];
	}
	
}