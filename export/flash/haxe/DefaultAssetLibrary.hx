package;


import haxe.Timer;
import haxe.Unserializer;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.text.Font;
import openfl.media.Sound;
import openfl.net.URLRequest;
import openfl.utils.ByteArray;
import openfl.Assets;

#if (flash || js)
import openfl.display.Loader;
import openfl.events.Event;
import openfl.net.URLLoader;
#end

#if sys
import sys.FileSystem;
#end

#if ios
import openfl.utils.SystemPath;
#end


@:access(openfl.media.Sound)
class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("assets/images/background.png", __ASSET__assets_images_background_png);
		type.set ("assets/images/background.png", AssetType.IMAGE);
		className.set ("assets/images/button.png", __ASSET__assets_images_button_png);
		type.set ("assets/images/button.png", AssetType.IMAGE);
		className.set ("assets/images/button_thin.png", __ASSET__assets_images_button_thin_png);
		type.set ("assets/images/button_thin.png", AssetType.IMAGE);
		className.set ("assets/images/chrome.png", __ASSET__assets_images_chrome_png);
		type.set ("assets/images/chrome.png", AssetType.IMAGE);
		className.set ("assets/images/images-go-here.txt", __ASSET__assets_images_images_go_here_txt);
		type.set ("assets/images/images-go-here.txt", AssetType.TEXT);
		className.set ("assets/images/tab.png", __ASSET__assets_images_tab_png);
		type.set ("assets/images/tab.png", AssetType.IMAGE);
		className.set ("assets/images/tab_back.png", __ASSET__assets_images_tab_back_png);
		type.set ("assets/images/tab_back.png", AssetType.IMAGE);
		className.set ("assets/images_source/box.png", __ASSET__assets_images_source_box_png);
		type.set ("assets/images_source/box.png", AssetType.IMAGE);
		className.set ("assets/images_source/button.png", __ASSET__assets_images_source_button_png);
		type.set ("assets/images_source/button.png", AssetType.IMAGE);
		className.set ("assets/images_source/button_arrow_down.png", __ASSET__assets_images_source_button_arrow_down_png);
		type.set ("assets/images_source/button_arrow_down.png", AssetType.IMAGE);
		className.set ("assets/images_source/button_arrow_left.png", __ASSET__assets_images_source_button_arrow_left_png);
		type.set ("assets/images_source/button_arrow_left.png", AssetType.IMAGE);
		className.set ("assets/images_source/button_arrow_right.png", __ASSET__assets_images_source_button_arrow_right_png);
		type.set ("assets/images_source/button_arrow_right.png", AssetType.IMAGE);
		className.set ("assets/images_source/button_arrow_up.png", __ASSET__assets_images_source_button_arrow_up_png);
		type.set ("assets/images_source/button_arrow_up.png", AssetType.IMAGE);
		className.set ("assets/images_source/button_thin.png", __ASSET__assets_images_source_button_thin_png);
		type.set ("assets/images_source/button_thin.png", AssetType.IMAGE);
		className.set ("assets/images_source/button_toggle.png", __ASSET__assets_images_source_button_toggle_png);
		type.set ("assets/images_source/button_toggle.png", AssetType.IMAGE);
		className.set ("assets/images_source/check_box.png", __ASSET__assets_images_source_check_box_png);
		type.set ("assets/images_source/check_box.png", AssetType.IMAGE);
		className.set ("assets/images_source/check_mark.png", __ASSET__assets_images_source_check_mark_png);
		type.set ("assets/images_source/check_mark.png", AssetType.IMAGE);
		className.set ("assets/images_source/chrome.png", __ASSET__assets_images_source_chrome_png);
		type.set ("assets/images_source/chrome.png", AssetType.IMAGE);
		className.set ("assets/images_source/chrome_flat.png", __ASSET__assets_images_source_chrome_flat_png);
		type.set ("assets/images_source/chrome_flat.png", AssetType.IMAGE);
		className.set ("assets/images_source/chrome_inset.png", __ASSET__assets_images_source_chrome_inset_png);
		type.set ("assets/images_source/chrome_inset.png", AssetType.IMAGE);
		className.set ("assets/images_source/chrome_light.png", __ASSET__assets_images_source_chrome_light_png);
		type.set ("assets/images_source/chrome_light.png", AssetType.IMAGE);
		className.set ("assets/images_source/dropdown_mark.png", __ASSET__assets_images_source_dropdown_mark_png);
		type.set ("assets/images_source/dropdown_mark.png", AssetType.IMAGE);
		className.set ("assets/images_source/finger_big.png", __ASSET__assets_images_source_finger_big_png);
		type.set ("assets/images_source/finger_big.png", AssetType.IMAGE);
		className.set ("assets/images_source/finger_small.png", __ASSET__assets_images_source_finger_small_png);
		type.set ("assets/images_source/finger_small.png", AssetType.IMAGE);
		className.set ("assets/images_source/hilight.png", __ASSET__assets_images_source_hilight_png);
		type.set ("assets/images_source/hilight.png", AssetType.IMAGE);
		className.set ("assets/images_source/invis.png", __ASSET__assets_images_source_invis_png);
		type.set ("assets/images_source/invis.png", AssetType.IMAGE);
		className.set ("assets/images_source/minus_mark.png", __ASSET__assets_images_source_minus_mark_png);
		type.set ("assets/images_source/minus_mark.png", AssetType.IMAGE);
		className.set ("assets/images_source/plus_mark.png", __ASSET__assets_images_source_plus_mark_png);
		type.set ("assets/images_source/plus_mark.png", AssetType.IMAGE);
		className.set ("assets/images_source/radio.png", __ASSET__assets_images_source_radio_png);
		type.set ("assets/images_source/radio.png", AssetType.IMAGE);
		className.set ("assets/images_source/radio_dot.png", __ASSET__assets_images_source_radio_dot_png);
		type.set ("assets/images_source/radio_dot.png", AssetType.IMAGE);
		className.set ("assets/images_source/swatch.png", __ASSET__assets_images_source_swatch_png);
		type.set ("assets/images_source/swatch.png", AssetType.IMAGE);
		className.set ("assets/images_source/tab.png", __ASSET__assets_images_source_tab_png);
		type.set ("assets/images_source/tab.png", AssetType.IMAGE);
		className.set ("assets/images_source/tab_back.png", __ASSET__assets_images_source_tab_back_png);
		type.set ("assets/images_source/tab_back.png", AssetType.IMAGE);
		className.set ("assets/xml/message_popup.xml", __ASSET__assets_xml_message_popup_xml);
		type.set ("assets/xml/message_popup.xml", AssetType.TEXT);
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		className.set ("flixel/flixel-ui/img/box.png", __ASSET__flixel_flixel_ui_img_box_png);
		type.set ("flixel/flixel-ui/img/box.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/button.png", __ASSET__flixel_flixel_ui_img_button_png);
		type.set ("flixel/flixel-ui/img/button.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/button_arrow_down.png", __ASSET__flixel_flixel_ui_img_button_arrow_down_png);
		type.set ("flixel/flixel-ui/img/button_arrow_down.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/button_arrow_left.png", __ASSET__flixel_flixel_ui_img_button_arrow_left_png);
		type.set ("flixel/flixel-ui/img/button_arrow_left.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/button_arrow_right.png", __ASSET__flixel_flixel_ui_img_button_arrow_right_png);
		type.set ("flixel/flixel-ui/img/button_arrow_right.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/button_arrow_up.png", __ASSET__flixel_flixel_ui_img_button_arrow_up_png);
		type.set ("flixel/flixel-ui/img/button_arrow_up.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/button_thin.png", __ASSET__flixel_flixel_ui_img_button_thin_png);
		type.set ("flixel/flixel-ui/img/button_thin.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/button_toggle.png", __ASSET__flixel_flixel_ui_img_button_toggle_png);
		type.set ("flixel/flixel-ui/img/button_toggle.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/check_box.png", __ASSET__flixel_flixel_ui_img_check_box_png);
		type.set ("flixel/flixel-ui/img/check_box.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/check_mark.png", __ASSET__flixel_flixel_ui_img_check_mark_png);
		type.set ("flixel/flixel-ui/img/check_mark.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/chrome.png", __ASSET__flixel_flixel_ui_img_chrome_png);
		type.set ("flixel/flixel-ui/img/chrome.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/chrome_flat.png", __ASSET__flixel_flixel_ui_img_chrome_flat_png);
		type.set ("flixel/flixel-ui/img/chrome_flat.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/chrome_inset.png", __ASSET__flixel_flixel_ui_img_chrome_inset_png);
		type.set ("flixel/flixel-ui/img/chrome_inset.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/chrome_light.png", __ASSET__flixel_flixel_ui_img_chrome_light_png);
		type.set ("flixel/flixel-ui/img/chrome_light.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/dropdown_mark.png", __ASSET__flixel_flixel_ui_img_dropdown_mark_png);
		type.set ("flixel/flixel-ui/img/dropdown_mark.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/finger_big.png", __ASSET__flixel_flixel_ui_img_finger_big_png);
		type.set ("flixel/flixel-ui/img/finger_big.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/finger_small.png", __ASSET__flixel_flixel_ui_img_finger_small_png);
		type.set ("flixel/flixel-ui/img/finger_small.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/hilight.png", __ASSET__flixel_flixel_ui_img_hilight_png);
		type.set ("flixel/flixel-ui/img/hilight.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/invis.png", __ASSET__flixel_flixel_ui_img_invis_png);
		type.set ("flixel/flixel-ui/img/invis.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/minus_mark.png", __ASSET__flixel_flixel_ui_img_minus_mark_png);
		type.set ("flixel/flixel-ui/img/minus_mark.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/plus_mark.png", __ASSET__flixel_flixel_ui_img_plus_mark_png);
		type.set ("flixel/flixel-ui/img/plus_mark.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/radio.png", __ASSET__flixel_flixel_ui_img_radio_png);
		type.set ("flixel/flixel-ui/img/radio.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/radio_dot.png", __ASSET__flixel_flixel_ui_img_radio_dot_png);
		type.set ("flixel/flixel-ui/img/radio_dot.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/swatch.png", __ASSET__flixel_flixel_ui_img_swatch_png);
		type.set ("flixel/flixel-ui/img/swatch.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/tab.png", __ASSET__flixel_flixel_ui_img_tab_png);
		type.set ("flixel/flixel-ui/img/tab.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/tab_back.png", __ASSET__flixel_flixel_ui_img_tab_back_png);
		type.set ("flixel/flixel-ui/img/tab_back.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/xml/defaults.xml", __ASSET__flixel_flixel_ui_xml_defaults_xml);
		type.set ("flixel/flixel-ui/xml/defaults.xml", AssetType.TEXT);
		className.set ("flixel/flixel-ui/xml/default_loading_screen.xml", __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml);
		type.set ("flixel/flixel-ui/xml/default_loading_screen.xml", AssetType.TEXT);
		className.set ("flixel/flixel-ui/xml/default_popup.xml", __ASSET__flixel_flixel_ui_xml_default_popup_xml);
		type.set ("flixel/flixel-ui/xml/default_popup.xml", AssetType.TEXT);
		
		
		#elseif html5
		
		var id;
		id = "assets/images/background.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/button.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/button_thin.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/chrome.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/images-go-here.txt";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/images/tab.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tab_back.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/box.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/button.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/button_arrow_down.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/button_arrow_left.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/button_arrow_right.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/button_arrow_up.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/button_thin.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/button_toggle.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/check_box.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/check_mark.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/chrome.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/chrome_flat.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/chrome_inset.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/chrome_light.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/dropdown_mark.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/finger_big.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/finger_small.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/hilight.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/invis.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/minus_mark.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/plus_mark.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/radio.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/radio_dot.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/swatch.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/tab.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images_source/tab_back.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/xml/message_popup.xml";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/beep.mp3";
		path.set (id, id);
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/flixel.mp3";
		path.set (id, id);
		type.set (id, AssetType.MUSIC);
		id = "flixel/flixel-ui/img/box.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/button.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/button_arrow_down.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/button_arrow_left.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/button_arrow_right.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/button_arrow_up.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/button_thin.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/button_toggle.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/check_box.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/check_mark.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/chrome.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/chrome_flat.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/chrome_inset.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/chrome_light.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/dropdown_mark.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/finger_big.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/finger_small.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/hilight.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/invis.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/minus_mark.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/plus_mark.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/radio.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/radio_dot.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/swatch.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/tab.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/tab_back.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/xml/defaults.xml";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "flixel/flixel-ui/xml/default_loading_screen.xml";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "flixel/flixel-ui/xml/default_popup.xml";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		
		
		#else
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("assets/images/background.png", __ASSET__assets_images_background_png);
		type.set ("assets/images/background.png", AssetType.IMAGE);
		
		className.set ("assets/images/button.png", __ASSET__assets_images_button_png);
		type.set ("assets/images/button.png", AssetType.IMAGE);
		
		className.set ("assets/images/button_thin.png", __ASSET__assets_images_button_thin_png);
		type.set ("assets/images/button_thin.png", AssetType.IMAGE);
		
		className.set ("assets/images/chrome.png", __ASSET__assets_images_chrome_png);
		type.set ("assets/images/chrome.png", AssetType.IMAGE);
		
		className.set ("assets/images/images-go-here.txt", __ASSET__assets_images_images_go_here_txt);
		type.set ("assets/images/images-go-here.txt", AssetType.TEXT);
		
		className.set ("assets/images/tab.png", __ASSET__assets_images_tab_png);
		type.set ("assets/images/tab.png", AssetType.IMAGE);
		
		className.set ("assets/images/tab_back.png", __ASSET__assets_images_tab_back_png);
		type.set ("assets/images/tab_back.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/box.png", __ASSET__assets_images_source_box_png);
		type.set ("assets/images_source/box.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/button.png", __ASSET__assets_images_source_button_png);
		type.set ("assets/images_source/button.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/button_arrow_down.png", __ASSET__assets_images_source_button_arrow_down_png);
		type.set ("assets/images_source/button_arrow_down.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/button_arrow_left.png", __ASSET__assets_images_source_button_arrow_left_png);
		type.set ("assets/images_source/button_arrow_left.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/button_arrow_right.png", __ASSET__assets_images_source_button_arrow_right_png);
		type.set ("assets/images_source/button_arrow_right.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/button_arrow_up.png", __ASSET__assets_images_source_button_arrow_up_png);
		type.set ("assets/images_source/button_arrow_up.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/button_thin.png", __ASSET__assets_images_source_button_thin_png);
		type.set ("assets/images_source/button_thin.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/button_toggle.png", __ASSET__assets_images_source_button_toggle_png);
		type.set ("assets/images_source/button_toggle.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/check_box.png", __ASSET__assets_images_source_check_box_png);
		type.set ("assets/images_source/check_box.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/check_mark.png", __ASSET__assets_images_source_check_mark_png);
		type.set ("assets/images_source/check_mark.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/chrome.png", __ASSET__assets_images_source_chrome_png);
		type.set ("assets/images_source/chrome.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/chrome_flat.png", __ASSET__assets_images_source_chrome_flat_png);
		type.set ("assets/images_source/chrome_flat.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/chrome_inset.png", __ASSET__assets_images_source_chrome_inset_png);
		type.set ("assets/images_source/chrome_inset.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/chrome_light.png", __ASSET__assets_images_source_chrome_light_png);
		type.set ("assets/images_source/chrome_light.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/dropdown_mark.png", __ASSET__assets_images_source_dropdown_mark_png);
		type.set ("assets/images_source/dropdown_mark.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/finger_big.png", __ASSET__assets_images_source_finger_big_png);
		type.set ("assets/images_source/finger_big.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/finger_small.png", __ASSET__assets_images_source_finger_small_png);
		type.set ("assets/images_source/finger_small.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/hilight.png", __ASSET__assets_images_source_hilight_png);
		type.set ("assets/images_source/hilight.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/invis.png", __ASSET__assets_images_source_invis_png);
		type.set ("assets/images_source/invis.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/minus_mark.png", __ASSET__assets_images_source_minus_mark_png);
		type.set ("assets/images_source/minus_mark.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/plus_mark.png", __ASSET__assets_images_source_plus_mark_png);
		type.set ("assets/images_source/plus_mark.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/radio.png", __ASSET__assets_images_source_radio_png);
		type.set ("assets/images_source/radio.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/radio_dot.png", __ASSET__assets_images_source_radio_dot_png);
		type.set ("assets/images_source/radio_dot.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/swatch.png", __ASSET__assets_images_source_swatch_png);
		type.set ("assets/images_source/swatch.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/tab.png", __ASSET__assets_images_source_tab_png);
		type.set ("assets/images_source/tab.png", AssetType.IMAGE);
		
		className.set ("assets/images_source/tab_back.png", __ASSET__assets_images_source_tab_back_png);
		type.set ("assets/images_source/tab_back.png", AssetType.IMAGE);
		
		className.set ("assets/xml/message_popup.xml", __ASSET__assets_xml_message_popup_xml);
		type.set ("assets/xml/message_popup.xml", AssetType.TEXT);
		
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		
		className.set ("flixel/flixel-ui/img/box.png", __ASSET__flixel_flixel_ui_img_box_png);
		type.set ("flixel/flixel-ui/img/box.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/button.png", __ASSET__flixel_flixel_ui_img_button_png);
		type.set ("flixel/flixel-ui/img/button.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/button_arrow_down.png", __ASSET__flixel_flixel_ui_img_button_arrow_down_png);
		type.set ("flixel/flixel-ui/img/button_arrow_down.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/button_arrow_left.png", __ASSET__flixel_flixel_ui_img_button_arrow_left_png);
		type.set ("flixel/flixel-ui/img/button_arrow_left.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/button_arrow_right.png", __ASSET__flixel_flixel_ui_img_button_arrow_right_png);
		type.set ("flixel/flixel-ui/img/button_arrow_right.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/button_arrow_up.png", __ASSET__flixel_flixel_ui_img_button_arrow_up_png);
		type.set ("flixel/flixel-ui/img/button_arrow_up.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/button_thin.png", __ASSET__flixel_flixel_ui_img_button_thin_png);
		type.set ("flixel/flixel-ui/img/button_thin.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/button_toggle.png", __ASSET__flixel_flixel_ui_img_button_toggle_png);
		type.set ("flixel/flixel-ui/img/button_toggle.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/check_box.png", __ASSET__flixel_flixel_ui_img_check_box_png);
		type.set ("flixel/flixel-ui/img/check_box.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/check_mark.png", __ASSET__flixel_flixel_ui_img_check_mark_png);
		type.set ("flixel/flixel-ui/img/check_mark.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/chrome.png", __ASSET__flixel_flixel_ui_img_chrome_png);
		type.set ("flixel/flixel-ui/img/chrome.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/chrome_flat.png", __ASSET__flixel_flixel_ui_img_chrome_flat_png);
		type.set ("flixel/flixel-ui/img/chrome_flat.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/chrome_inset.png", __ASSET__flixel_flixel_ui_img_chrome_inset_png);
		type.set ("flixel/flixel-ui/img/chrome_inset.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/chrome_light.png", __ASSET__flixel_flixel_ui_img_chrome_light_png);
		type.set ("flixel/flixel-ui/img/chrome_light.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/dropdown_mark.png", __ASSET__flixel_flixel_ui_img_dropdown_mark_png);
		type.set ("flixel/flixel-ui/img/dropdown_mark.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/finger_big.png", __ASSET__flixel_flixel_ui_img_finger_big_png);
		type.set ("flixel/flixel-ui/img/finger_big.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/finger_small.png", __ASSET__flixel_flixel_ui_img_finger_small_png);
		type.set ("flixel/flixel-ui/img/finger_small.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/hilight.png", __ASSET__flixel_flixel_ui_img_hilight_png);
		type.set ("flixel/flixel-ui/img/hilight.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/invis.png", __ASSET__flixel_flixel_ui_img_invis_png);
		type.set ("flixel/flixel-ui/img/invis.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/minus_mark.png", __ASSET__flixel_flixel_ui_img_minus_mark_png);
		type.set ("flixel/flixel-ui/img/minus_mark.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/plus_mark.png", __ASSET__flixel_flixel_ui_img_plus_mark_png);
		type.set ("flixel/flixel-ui/img/plus_mark.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/radio.png", __ASSET__flixel_flixel_ui_img_radio_png);
		type.set ("flixel/flixel-ui/img/radio.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/radio_dot.png", __ASSET__flixel_flixel_ui_img_radio_dot_png);
		type.set ("flixel/flixel-ui/img/radio_dot.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/swatch.png", __ASSET__flixel_flixel_ui_img_swatch_png);
		type.set ("flixel/flixel-ui/img/swatch.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/tab.png", __ASSET__flixel_flixel_ui_img_tab_png);
		type.set ("flixel/flixel-ui/img/tab.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/tab_back.png", __ASSET__flixel_flixel_ui_img_tab_back_png);
		type.set ("flixel/flixel-ui/img/tab_back.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/xml/defaults.xml", __ASSET__flixel_flixel_ui_xml_defaults_xml);
		type.set ("flixel/flixel-ui/xml/defaults.xml", AssetType.TEXT);
		
		className.set ("flixel/flixel-ui/xml/default_loading_screen.xml", __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml);
		type.set ("flixel/flixel-ui/xml/default_loading_screen.xml", AssetType.TEXT);
		
		className.set ("flixel/flixel-ui/xml/default_popup.xml", __ASSET__flixel_flixel_ui_xml_default_popup_xml);
		type.set ("flixel/flixel-ui/xml/default_popup.xml", AssetType.TEXT);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = this.type.get (id);
		
		#if pixi
		
		if (assetType == IMAGE) {
			
			return true;
			
		} else {
			
			return false;
			
		}
		
		#end
		
		if (assetType != null) {
			
			if (assetType == type || ((type == SOUND || type == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && type == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (type == BINARY || type == null) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		#if pixi
		
		return BitmapData.fromImage (path.get (id));
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), BitmapData);
		
		#elseif openfl_html5
		
		return BitmapData.fromImage (ApplicationMain.images.get (path.get (id)));
		
		#elseif js
		
		return cast (ApplicationMain.loaders.get (path.get (id)).contentLoaderInfo.content, Bitmap).bitmapData;
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), BitmapData);
		else return BitmapData.load (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if (flash)
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);

		#elseif (js || openfl_html5 || pixi)
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}

		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if pixi
		
		return null;
		
		#elseif (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists(id)) {
			var fontClass = className.get(id);
			Font.registerFont(fontClass);
			return cast (Type.createInstance (fontClass, []), Font);
		} else return new Font (path.get (id));
		
		#end
		
	}
	
	
	public override function getMusic (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		var sound = new Sound ();
		sound.__buffer = true;
		sound.load (new URLRequest (path.get (id)));
		return sound; 
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		#if flash
		
		if (type != AssetType.MUSIC && type != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:AssetType):Array<String> {
		
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (type == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		#if pixi
		
		handler (getBitmapData (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBitmapData (id));
			
		}
		
		#else
		
		handler (getBitmapData (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if pixi
		
		handler (getBytes (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getFont (id));
			
		//}
		
		#else
		
		handler (getFont (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, Type.createEnum (AssetType, asset.type));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadMusic (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getSound (id));
			
		//}
		
		#else
		
		handler (getSound (id));
		
		#end
		
	}
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		#if js
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}
		
		#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		#end
		
	}
	
	
}


#if pixi
#elseif flash

@:keep class __ASSET__assets_images_background_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_button_thin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_chrome_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_images_go_here_txt extends openfl.utils.ByteArray { }
@:keep class __ASSET__assets_images_tab_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_tab_back_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_button_arrow_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_button_arrow_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_button_arrow_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_button_arrow_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_button_thin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_button_toggle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_check_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_check_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_chrome_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_chrome_flat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_chrome_inset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_chrome_light_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_dropdown_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_finger_big_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_finger_small_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_hilight_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_invis_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_minus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_plus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_radio_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_radio_dot_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_swatch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_tab_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_source_tab_back_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_xml_message_popup_xml extends openfl.utils.ByteArray { }
@:keep class __ASSET__assets_sounds_beep_mp3 extends openfl.media.Sound { }
@:keep class __ASSET__assets_sounds_flixel_mp3 extends openfl.media.Sound { }
@:keep class __ASSET__flixel_flixel_ui_img_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_button_thin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_button_toggle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_check_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_check_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_chrome_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_chrome_light_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_finger_big_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_finger_small_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_hilight_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_invis_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_minus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_plus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_radio_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_radio_dot_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_swatch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_tab_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_img_tab_back_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_flixel_ui_xml_defaults_xml extends openfl.utils.ByteArray { }
@:keep class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends openfl.utils.ByteArray { }
@:keep class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends openfl.utils.ByteArray { }


#elseif html5




































































#elseif (windows || mac || linux)


@:bitmap("assets/images/background.png") class __ASSET__assets_images_background_png extends flash.display.BitmapData {}
@:bitmap("assets/images/button.png") class __ASSET__assets_images_button_png extends flash.display.BitmapData {}
@:bitmap("assets/images/button_thin.png") class __ASSET__assets_images_button_thin_png extends flash.display.BitmapData {}
@:bitmap("assets/images/chrome.png") class __ASSET__assets_images_chrome_png extends flash.display.BitmapData {}
@:file("assets/images/images-go-here.txt") class __ASSET__assets_images_images_go_here_txt extends flash.utils.ByteArray {}
@:bitmap("assets/images/tab.png") class __ASSET__assets_images_tab_png extends flash.display.BitmapData {}
@:bitmap("assets/images/tab_back.png") class __ASSET__assets_images_tab_back_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/box.png") class __ASSET__assets_images_source_box_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/button.png") class __ASSET__assets_images_source_button_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/button_arrow_down.png") class __ASSET__assets_images_source_button_arrow_down_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/button_arrow_left.png") class __ASSET__assets_images_source_button_arrow_left_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/button_arrow_right.png") class __ASSET__assets_images_source_button_arrow_right_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/button_arrow_up.png") class __ASSET__assets_images_source_button_arrow_up_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/button_thin.png") class __ASSET__assets_images_source_button_thin_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/button_toggle.png") class __ASSET__assets_images_source_button_toggle_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/check_box.png") class __ASSET__assets_images_source_check_box_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/check_mark.png") class __ASSET__assets_images_source_check_mark_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/chrome.png") class __ASSET__assets_images_source_chrome_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/chrome_flat.png") class __ASSET__assets_images_source_chrome_flat_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/chrome_inset.png") class __ASSET__assets_images_source_chrome_inset_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/chrome_light.png") class __ASSET__assets_images_source_chrome_light_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/dropdown_mark.png") class __ASSET__assets_images_source_dropdown_mark_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/finger_big.png") class __ASSET__assets_images_source_finger_big_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/finger_small.png") class __ASSET__assets_images_source_finger_small_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/hilight.png") class __ASSET__assets_images_source_hilight_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/invis.png") class __ASSET__assets_images_source_invis_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/minus_mark.png") class __ASSET__assets_images_source_minus_mark_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/plus_mark.png") class __ASSET__assets_images_source_plus_mark_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/radio.png") class __ASSET__assets_images_source_radio_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/radio_dot.png") class __ASSET__assets_images_source_radio_dot_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/swatch.png") class __ASSET__assets_images_source_swatch_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/tab.png") class __ASSET__assets_images_source_tab_png extends flash.display.BitmapData {}
@:bitmap("assets/images_source/tab_back.png") class __ASSET__assets_images_source_tab_back_png extends flash.display.BitmapData {}
@:file("assets/xml/message_popup.xml") class __ASSET__assets_xml_message_popup_xml extends flash.utils.ByteArray {}
@:sound("C:/HaxeToolkit/haxe/lib/flixel/3,3,4/assets/sounds/beep.mp3") class __ASSET__assets_sounds_beep_mp3 extends flash.media.Sound {}
@:sound("C:/HaxeToolkit/haxe/lib/flixel/3,3,4/assets/sounds/flixel.mp3") class __ASSET__assets_sounds_flixel_mp3 extends flash.media.Sound {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/box.png") class __ASSET__flixel_flixel_ui_img_box_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/button.png") class __ASSET__flixel_flixel_ui_img_button_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/button_arrow_down.png") class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/button_arrow_left.png") class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/button_arrow_right.png") class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/button_arrow_up.png") class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/button_thin.png") class __ASSET__flixel_flixel_ui_img_button_thin_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/button_toggle.png") class __ASSET__flixel_flixel_ui_img_button_toggle_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/check_box.png") class __ASSET__flixel_flixel_ui_img_check_box_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/check_mark.png") class __ASSET__flixel_flixel_ui_img_check_mark_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/chrome.png") class __ASSET__flixel_flixel_ui_img_chrome_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/chrome_flat.png") class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/chrome_inset.png") class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/chrome_light.png") class __ASSET__flixel_flixel_ui_img_chrome_light_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/dropdown_mark.png") class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/finger_big.png") class __ASSET__flixel_flixel_ui_img_finger_big_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/finger_small.png") class __ASSET__flixel_flixel_ui_img_finger_small_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/hilight.png") class __ASSET__flixel_flixel_ui_img_hilight_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/invis.png") class __ASSET__flixel_flixel_ui_img_invis_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/minus_mark.png") class __ASSET__flixel_flixel_ui_img_minus_mark_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/plus_mark.png") class __ASSET__flixel_flixel_ui_img_plus_mark_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/radio.png") class __ASSET__flixel_flixel_ui_img_radio_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/radio_dot.png") class __ASSET__flixel_flixel_ui_img_radio_dot_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/swatch.png") class __ASSET__flixel_flixel_ui_img_swatch_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/tab.png") class __ASSET__flixel_flixel_ui_img_tab_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/images/tab_back.png") class __ASSET__flixel_flixel_ui_img_tab_back_png extends flash.display.BitmapData {}
@:file("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/xml/defaults.xml") class __ASSET__flixel_flixel_ui_xml_defaults_xml extends flash.utils.ByteArray {}
@:file("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/xml/default_loading_screen.xml") class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends flash.utils.ByteArray {}
@:file("C:/HaxeToolkit/haxe/lib/flixel-ui/git/assets/xml/default_popup.xml") class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends flash.utils.ByteArray {}


#end
