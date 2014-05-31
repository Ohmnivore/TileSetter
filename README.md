**WORK IN PROGRESS**

Written using Haxe, with haxeflixel and its library flixel-ui.

2D tile-based editors are really neat. I personally use Ogmo Editor, and it covers all my mapping needs. However, I often find that I need to set different properties for tiles. I used to hard-code that, or write JSON files by hand. In the end, I got sick of these horrible solutions so I wrote a sort of Ogmo Editor for tilesets, where it's possible to attribute properties to every tile in a tileset.

Instructions:

At this stage, to run TileSetter you must open TileSetter.swf in a stand-alone flash player (doesn't seem to work in-browser for reasons I don't understand). In the future I plan to fix the browser issue and port it to Neko and native platforms.

TODO:
* Figure out flash local file sandbox security stuff
* Rework architecture
* Explain tilesheet JSON format
* Write flixel loader for tilesheets

***
Screenshot:

![alt text](https://raw.githubusercontent.com/Ohmnivore/TileSetter/master/SCREENSHOT.png "Screenshot")
