package backend;

class EaseConvert
{
    public static var stringEase:Map<String,(t:Float)->Float> = [
        "linear" => FlxEase.linear,
        "inSine" => FlxEase.sineIn,
        "outSine" => FlxEase.sineOut,
        "inOutSine" => FlxEase.sineInOut,
        "inQuad" => FlxEase.quadIn,
        "outQuad" => FlxEase.quadOut,
        "inOutQuad" => FlxEase.quadInOut,
        "inCirc" => FlxEase.circIn,
        "outCirc" => FlxEase.circOut,
        "inOutCirc" => FlxEase.circInOut,
        "inCubic" => FlxEase.cubeIn,
        "outCubic" => FlxEase.cubeOut,
        "inOutCubic" => FlxEase.cubeInOut,
        "inQuart" => FlxEase.quartIn,
        "outQuart" => FlxEase.quartOut,
        "inOutQuart" => FlxEase.quartInOut,
        "inQuint" => FlxEase.quintIn,
        "outQuint" => FlxEase.quintOut,
        "inOutQuint" => FlxEase.quintInOut,
        "inExpo" => FlxEase.expoIn,
        "outExpo" => FlxEase.expoOut,
        "inOutExpo" => FlxEase.expoInOut,
        "inBack" => FlxEase.backIn,
        "outBack" => FlxEase.backOut,
        "inOutBack" => FlxEase.backInOut,
        "inElastic" => FlxEase.elasticIn,
        "outElastic" => FlxEase.elasticOut,
        "inOutElastic" => FlxEase.elasticInOut,
        "inBounce" => FlxEase.bounceIn,
        "outBounce" => FlxEase.bounceOut,
        "inOutBounce" => FlxEase.bounceInOut
    ];
}