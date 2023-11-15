package backend;

// why this exists
/**
* You know what this means, right?
*/
class Version<T>
{
    private var ___ver(default, null):T;

    /**
    * Creates A New Version.
    */
    public function new(Version:T)
    {
        ___ver = Version;
    }

    /**
    * Returns The Version.
    */
    public function getVer():T
    {
        return ___ver;
    }

    /**
    * Sets The New Version.
    */
    public function setVer(newVal:T)
    {
        ___ver = newVal;
    }
}