package backend;

import sys.FileSystem;
import sys.io.File;
import haxe.Json;

typedef StageAssets = {
    var anim_n:Array<Array<String>>; // the xml name
    var position:Array<Array<Float>>; // the sprite's positions.
    var sprites:Array<String>; // the static Sprites.
    var sizes:Array<Array<Int>>; // the sprite's width/height
    var scroll:Array<Array<Float>>; // the sprite's Scroll Factor
    var anim_frame:Array<String>; // the animation file
    var anim_loop:Array<Array<Bool>>; // the animation loop
}

class StageAsset
{
    public static function getStageAsset(name:String):StageAssets
    {
        var rawJson:String = null;
		var path:String = Paths.getPreloadPath('stages/asset/' + name + '.json');

		#if MODS_ALLOWED
		var modPath:String = Paths.modFolders('stages/asset/' + name + '.json');
		if(FileSystem.exists(modPath)) {
			rawJson = File.getContent(modPath);
		} else if(FileSystem.exists(path)) {
			rawJson = File.getContent(path);
		}
		#else
		if(Assets.exists(path)) {
			rawJson = Assets.getText(path);
		}
		#end
		else
		{
			return null;
		}
		return cast Json.parse(rawJson);
    }

    public static function makeStageAsset():StageAssets
    {
        return {
            anim_n: [],
            position: [],
            sprites: [],
            sizes: [],
            scroll: [],
            anim_frame: [],
            anim_loop: []
        };
    }
}