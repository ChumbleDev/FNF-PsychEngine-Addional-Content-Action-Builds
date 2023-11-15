package shaders;

class ShaderControll
{
    public var values:Dynamic = null;

    /**
    * @param values Example Like {fisheye: 0.0, glitch: 0.0}
    */
    public function new(values:Dynamic)
    {
        this.values = values;
    }

    public function get(name:String):Float
    {
        return Reflect.field(values, name);
    }

    public function set(name:String, value:Float)
    {
        return Reflect.setField(values, name, value);
    }
}