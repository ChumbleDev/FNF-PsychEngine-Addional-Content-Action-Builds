package shaders;

import shaders.ShaderBase.EffectBase;

class GlitchEffect extends EffectBase<GlitchShader>
{
    public function new()
    {
        super(new GlitchShader());

        shader.distance.value = [0.0];
    }    
}

class GlitchShader extends ShaderBase
{
    @:glFragmentSource('
    #pragma header

    uniform float distance;

    vec4 doGlitch(sampler2D channel, vec2 uv, float d)
    {
        return texture2D(channel, vec2(uv.x + d, uv.y));
    }

    void main()
    {
        vec2 uv = openfl_TextureCoordv;

        vec4 tex;
        tex.r = texture2D(bitmap, vec2(uv.x - distance, uv.y)).r;
        tex.g = texture2D(bitmap, uv).g;
        tex.b = texture2D(bitmap, vec2(uv.x + distance, uv.y)).b;
        tex.a = texture2D(bitmap, uv).a;

        if (distance == 0.0) tex = texture2D(bitmap, uv);
        gl_FragColor = tex;
    }')

    public function new(){super();}
}