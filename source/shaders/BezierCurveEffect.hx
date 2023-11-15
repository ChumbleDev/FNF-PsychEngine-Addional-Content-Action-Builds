package shaders;

import shaders.ShaderBase.EffectBase;

class BezierCurveEffect extends EffectBase<BezierCurveShader>
{
    public var points:Array<Float>=[];
    public var offset:Float;
    public var maxUV:Float;
    function set_points(af:Array<Float>) {
        shader.points.value = af;
        return af;
    }
    function set_offset(f:Float) {
        shader.offset.value = [f];
        return f;
    }
    function set_maxUV(f:Float) {
        shader.maxUV.value = [f];
        return f;
    }

    public function new()
    {
        super(new BezierCurveShader());
        shader.points.value = [0, 0, 0, 0];
        shader.offset.value = [0];
        shader.maxUV.value = [1];
    }
}

class BezierCurveShader extends ShaderBase
{
    @:glFragmentSource('
    #pragma header

    uniform vec4 points;
    uniform float offset;
    uniform float maxUV;

    void mainImage( out vec4 fragColor, in vec2 fragCoord )
    {
        vec2 uv = openfl_TextureCoordv;
        vec4 fix = points;
        float t = uv.y * maxUV + offset;
        float bezier = pow(1.0 - t, 3.0) * fix.r + 3.0 * pow((1.0 - t), 2.0) * t * fix.g + 3.0 * (1.0 - t) * pow(t,2.0) * fix.b + pow(t,3.0) * fix.a;
        uv.x += bezier;
        fragColor = texture2D(bitmap, uv);
    }

    void main(){
        mainImage(gl_FragColor, gl_FragCoord);
    }')

    public function new(){super();}
}