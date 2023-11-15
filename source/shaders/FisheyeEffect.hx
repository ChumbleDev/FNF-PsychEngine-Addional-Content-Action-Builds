package shaders;

import shaders.ShaderBase.EffectBase;

/**
* By https://www.shadertoy.com/view/td2GzW
*
* Original is https://www.shadertoy.com/view/4s2GRR, i think.
*/
class FisheyeEffect extends EffectBase<FisheyeShader>
{
    public function new()
    {
        super(new FisheyeShader());

        shader.center.value = [FlxG.width / 2];
        shader.power.value = [0.0];
        shader.iResolution.value = [FlxG.width, FlxG.height];
    }
}

class FisheyeShader extends ShaderBase
{
    @:glFragmentSource('
    #pragma header

    uniform vec2 iResolution;
    uniform float center;
    uniform float power;

    //Inspired by http://stackoverflow.com/questions/6030814/add-fisheye-effect-to-images-at-runtime-using-opengl-es
    void main()
    {
        vec2 p = gl_FragCoord.xy / iResolution.x;//normalized coords with some cheat
                                                                //(assume 1:1 prop)
        float prop = iResolution.x / iResolution.y;//screen proroption
        vec2 m = vec2(0.5, 0.5 / prop);//center coords
        vec2 d = p - m;//vector from center to current fragment
        float r = sqrt(dot(d, d)); // distance of pixel from center

        float bind;//radius of 1:1 effect
        if (power > 0.0) 
            bind = sqrt(dot(m, m));//stick to corners
        else {if (prop < 1.0) 
            bind = m.x; 
        else 
            bind = m.y;}//stick to borders

        //Weird formulas
        vec2 uv;
        if (power > 0.0)//fisheye
            uv = m + normalize(d) * tan(r * power) * bind / tan( bind * power);
        else if (power < 0.0)//antifisheye
            uv = m + normalize(d) * atan(r * -power * 10.0) * bind / atan(-power * bind * 10.0);
        else uv = p;//no effect for power = 1.0
            
        uv.y *= prop;
        
        // inverted
        //vec3 col = texture2D(bitmap, vec2(uv.x, 1.0 - uv.y)).rgb;//Second part of cheat
        //for round effect, not elliptical
        if (power == 0.0) uv = openfl_TextureCoordv;
        gl_FragColor = texture2D(bitmap, uv);
    }')

    public function new() {super();}
}