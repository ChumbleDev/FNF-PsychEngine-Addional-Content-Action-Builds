package backend;

@:cppFileCode('
#include <math.h>
')
class MathUtil
{
    // "PIE" insanity
    public static var PI_DEVIDE_2:Float = Math.PI / 2;
    public static var PI_POW_2:Float = Math.pow(Math.PI, 2);
    public static var PI_SQURE_ROOT:Float = Math.sqrt(Math.PI);
    public static var PI_TIMES_2:Float = Math.PI * 2;
    public static var PI_INT:Int = Std.parseInt(Std.string(Math.PI / FlxMath.EPSILON));
    public static var PI_HEX:String = PI_INT.hex();

    /**
        Converts Degress to Radians.
    **/
    public static function rad(deg:Float):Float
    {
        return deg * Math.PI / 180;
    }

    /**
        Converts Radians to Degress.
    **/
    public static function deg(rad:Float):Float
    {
        return rad * 180 / Math.PI;
    }

    /**
    * @param n The angle in radians.
    * @see https://api.haxeflixel.com/flixel/math/FlxMath.html#fastSin
    * @see https://api.haxeflixel.com/flixel/math/FlxMath.html#fastCos 
    * @return An approximated tangent of n.
    */
    public static function fastTan(n:Float):Float
    {
        return FlxMath.fastSin(n) / FlxMath.fastCos(n);
    }

    // doing this cuz im stopid
    @:functionCode('
        result = fmodf(x, y);
    ')
    public static function fmod(x:Float, y:Float, ?result:Int=0)
    {
        return result;
    }
}