package backend;

import flixel.FlxBasic;
import openfl.filters.ShaderFilter;
import shaders.*;
import openfl.filters.BitmapFilter;

class ShaderCamera extends FlxBasic
{
    @:noPrivateAccess @:noCompletion private var _fisheye      (default,never)     :FisheyeEffect = new FisheyeEffect();
    @:noPrivateAccess @:noCompletion private var _glitch         (default,never)     :GlitchEffect = new GlitchEffect();
    @:noPrivateAccess @:noCompletion private var _glitch2       (default,never)     :Glitch02Effect = new Glitch02Effect();
    @:noPrivateAccess @:noCompletion private var _glitchline   (default,never)     :GlitchLinesEffect = new GlitchLinesEffect();

    public var fisheye     (default,set)         :Float;
    public var glitch        (default,set)         :Float;
    public var glitch02    (default,set)         :Float;
    public var glitchline  (default,set)         :Float;
    public var glitchliney(default,set)        :Float;

    /**
        Alias of `ClientPrefs.data.shaders`.

        you cant edit this lol
    **/
    public var enable(get,never):Bool;
    function get_enable() return ClientPrefs.data.shaders;

    /**
        Called on if shader's variable changed via `fisheye` or `glitch` or etc.
    **/
    public var onChange:(val:Float) -> Void;

    public function new()
    {
        super();
    }

    // shader iTime or uTime stuffs goes here
    override function update(elapsed:Float)
    {
        if (enable) {
            var state = PlayState.instance != null;
            _glitch2.elapsedtime += state ? PlayState.instance.curDecBeat : elapsed;
            _glitchline.time += state ? PlayState.instance.curDecBeat : elapsed;
        }

        super.update(elapsed);
    }

    @:noCompletion public function getShader():Array<BitmapFilter> {
        // add your shaders here and it will be applyed
        var shaders:Array<BitmapFilter> = [
            new ShaderFilter(_glitch.shader), new ShaderFilter(_fisheye.shader), new ShaderFilter(_glitch2.shader),
            new ShaderFilter(_glitchline.shader)
        ];
        return enable ? shaders : [];
    }

    function set_fisheye(f:Float) {
        if (enable) {
            if (onChange != null) onChange(f);
            _fisheye.shader.power.value = [f];
        }
        return f;
    }

    function set_glitch(f:Float) {
        if (enable) {
            if (onChange != null) onChange(f);
            _glitch.shader.distance.value = [f];
        }
        return f;
    }

    function set_glitch02(f:Float) {
        if (enable) {
            if (onChange != null) onChange(f);
            _glitch2.glitch = f;
        }
        return f;
    }

    function set_glitchline(f:Float) {
        if (enable) {
            if (onChange != null) onChange(f);
            _glitchline.amount = f;
        }
        return f;
    }

    function set_glitchliney(f:Float) {
        if (enable) {
            if (onChange != null) onChange(f);
            _glitchline.amounty = f;
        }
        return f;
    }
}