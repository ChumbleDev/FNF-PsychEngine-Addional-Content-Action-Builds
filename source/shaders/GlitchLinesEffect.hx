package shaders;

import shaders.ShaderBase.EffectBase;

/**
 * OG By https://github.com/oatmealine/notitg-shaders/blob/master/fragment/post/glitch-lines-v.frag
 */
class GlitchLinesEffect extends EffectBase<GlitchLinesShader>
{
    public var time(default,set):Float = 0;
    public var amount(default,set):Float = 0;
    public var amounty(default,set):Float = 0;
    public var shift(default,set):Array<Float> = [0, 0];

    public function new()
    {
        super(new GlitchLinesShader());

        shader.resolution.value = [FlxG.width, FlxG.height];
        shader.time.value = [0];
    }

    function set_time(f:Float) {
        shader.time.value = [f];
        return f;
    }

    function set_amount(f:Float) {
        shader.amount.value = [f];
        return f;
    }

    function set_amounty(f:Float) {
        shader.amounty.value = [f];
        return f;
    }

    function set_shift(f:Array<Float>) {
        shader.shift.value = [f[0], f[1]];
        return f;
    }
}

/**
 * OG By https://github.com/oatmealine/notitg-shaders/blob/master/fragment/post/glitch-lines-v.frag
 */
class GlitchLinesShader extends ShaderBase
{
    @:glFragmentSource('
    #pragma header

    uniform float amount;
    uniform float amounty;
    uniform vec2 shift;
    uniform vec2 resolution;

    uniform float time;

    float rand( vec2 co )
    {
        return fract(sin(dot(co.xy,vec2(12.9898,78.233))) * 43758.5453);
    }

    void main()
    {
        vec2 uv = openfl_TextureCoordv;
        vec2 uvn = uv;

        uv.x += rand( vec2(uvn.y / 10.0, time / 10.0) ) * amount;
        uv.x -= rand( vec2(uvn.y * 10.0, time * 10.0) ) * amount;

        uv.y += rand( vec2(uvn.x / 10.0, time / 10.0) ) * amounty;
        uv.y -= rand( vec2(uvn.x * 10.0, time * 10.0) ) * amounty;


        vec4 col;
        col.rg = texture2D( bitmap, vec2(mod(uv + shift / resolution, 1.0)) ).rg;
        col.gb = texture2D( bitmap, vec2(mod(uv - shift / resolution, 1.0)) ).gb;
        col.a = texture2D( bitmap, uv ).a;

        gl_FragColor = col;
    }')

    public function new() {super();}
}