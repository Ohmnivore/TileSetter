package substates;
import flash.geom.Rectangle;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUIList;
import flixel.addons.ui.FlxUISubState;
import flixel.addons.ui.FlxUIText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.addons.ui.StrIdLabel;
import haxe.Constraints.Function;

/**
 * ...
 * @author Ohmnivore
 */
class EditProj extends FlxUISubState
{
	private var type_select:FlxUIDropDownMenu;
	private var name:FlxUIInputText;
	private var fieldlist:FlxUIList;
	
	override public function create():Void 
	{
		super.create();
		
		add(new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0x99000000));
		
		var chrome:FlxUI9SliceSprite = new FlxUI9SliceSprite(0, 0, Assets.CHROME, new Rectangle(0, 0, FlxG.width, FlxG.height - 60));
		FlxSpriteUtil.screenCenter(chrome);
		add(chrome);
		
		var opt:Array<StrIdLabel> = Reg.makeStrIdArray(["Checkbox", "Textfield", "Radio group"]);
		type_select = new FlxUIDropDownMenu(10, 40, opt, Assets.createHeader());
		add(type_select);
		
		name = new FlxUIInputText();
		name.x = type_select.width + type_select.x;
		name.y = 43;
		name.text = "Property name";
		add(name);
		
		var go:FlxUIButton = new FlxUIButton(type_select.x + type_select.width + name.width + 5, 40, "Add", makeNewProp);
		Assets.setBtnGraphic(go);
		add(go);
		
		var ret:FlxUIButton = new FlxUIButton(type_select.x + type_select.width + name.width + go.width + 5, 40, "Done", cancel);
		Assets.setBtnGraphic(ret);
		add(ret);
		
		fieldlist = new FlxUIList(10, 95, null, FlxG.width, (FlxG.height - 95) * 0.75);
		add(fieldlist);
		
		for (f in Reg.proj.iterator())
		{
			addExistingProp(f);
		}
	}
	
	private function addExistingProp(Field:ProjField):Void
	{
		if (Field.type == "Radio group")
		{
			var radio:RadioField = cast Field;
			
			makeNewPropAssets(radio.name, radio.type, radio);
			
			//Reg.base.makeNewPropAssets(radio.name, radio.type, "Inspect", radio);
			//Reg.base.makeNewPropAssets(radio.name, radio.type, "Apply", radio);
		}
		else
		{
			makeNewPropAssets(Field.name, Field.type);
			
			//Reg.base.makeNewPropAssets(Field.name, Field.type, "Inspect");
			//Reg.base.makeNewPropAssets(Field.name, Field.type, "Apply");
		}
	}
	
	private function makeNewProp():Void
	{
		var found:Bool = false;
		
		for (f in Reg.proj)
		{
			if (name.text == f.name)
			{
				found = true;
			}
		}
		
		if (!found)
		{
			if (type_select.selectedLabel == "Radio group")
			{
				var radio:RadioField = new RadioField(name.text, type_select.selectedLabel);
				
				makeNewPropAssets(name.text, type_select.selectedLabel, radio);
				
				Reg.proj.push(radio);
				
				Reg.base.makeNewPropAssets(name.text, type_select.selectedLabel, "Inspect", radio);
				Reg.base.makeNewPropAssets(name.text, type_select.selectedLabel, "Apply", radio);
				
				openSubState(new EditRadio(radio));
			}
			else
			{
				makeNewPropAssets(name.text, type_select.selectedLabel);
				
				Reg.proj.push(new ProjField(name.text, type_select.selectedLabel));
				
				Reg.base.makeNewPropAssets(name.text, type_select.selectedLabel, "Inspect");
				Reg.base.makeNewPropAssets(name.text, type_select.selectedLabel, "Apply");
			}
		}
	}
	
	private function makeNewPropAssets(Name:String, TypeOfUI:String, Radio:RadioField = null):Void
	{
		var g:FlxUIGroup = new FlxUIGroup();
		
		var n:FlxUIText = new FlxUIText();
		n.text = Name;
		g.add(n);
		
		var t:FlxUIText = new FlxUIText();
		t.text = TypeOfUI;
		t.x += 100;
		g.add(t);
		
		var r:FlxUIButton = new FlxUIButton(200, 0, "Remove");
		Assets.setBtnGraphic(r);
		r.params = [g, n.text, t.text];
		g.add(r);
		
		if (TypeOfUI == "Radio group")
		{
			var e:FlxUIButton = new FlxUIButton(r.x + r.width, 0, "Edit");
			Assets.setBtnGraphic(e);
			e.params = [Radio];
			g.add(e);
		}
		
		fieldlist.add(g);
		fieldlist.refreshList();
	}
	
	public override function getEvent(id:String, target:Dynamic, data:Dynamic, ?params:Array<Dynamic>):Void
	{
		if (params != null)
		{
			switch(id)
			{
				case "click_button":
					if (params.length == 3)
					{
						var g:FlxUIGroup = cast params[0];
						fieldlist.remove(g, true);
						fieldlist.refreshList();
						
						for (f in Reg.proj.iterator())
						{
							if (f.name == cast(params[1], String) && f.type == cast (params[2], String))
							{
								Reg.proj.remove(f);
								f = null;
							}
						}
					}
					
					if (params.length == 1)
					{
						openSubState(new EditRadio(cast params[0]));
					}
			}
		}
	}
	
	private function cancel():Void
	{
		Reg.base.updateTabs();
		close();
	}
}