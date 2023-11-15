package objects;

import openfl.display.BitmapDataChannel;
import openfl.geom.Point;
import openfl.geom.ColorTransform;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;

class SpriteMasking extends FlxSprite
{   
    /**
    * @param bg The Bitmap Image.
    * @param overlay The Masking Image.
    */
    public function new(bg:FlxSprite, overlay:FlxSprite, ?x:Float = 0, ?y:Float = 0)
    {
        super                                                                 ( x, y );
        loadGraphicFromSprite                                     ( bg );
        mask                                                            ( this, overlay );
    }

    // stolen from http://coinflipstudios.com/devblog/?p=421
    @:noPrivateAccess private function mask(bgSpr:FlxSprite, overlaySpr:FlxSprite):FlxSprite {
		bgSpr.drawFrame();
		var data:BitmapData = bgSpr.pixels.clone();
		data.copyChannel(overlaySpr.pixels, new Rectangle(0, 0, bgSpr.width, bgSpr.height), new Point(), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
		data.colorTransform(new Rectangle(0, 0, bgSpr.width, bgSpr.height), new ColorTransform(0,0,0,-1,0,0,0,255)); 
		pixels = data;
		return this;
    }
}