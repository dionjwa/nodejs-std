package ;

import js.Node;

/**
  * Nodejs Sys class.
  * http://haxe.org/api/sys/
  * Currently incomplete, but should be straightforward to fill in the missing calls.
  */
class Sys
{
	public static function args () :Array<String>
	{
		return untyped process.argv;
	}

	public static function getEnv (key :String) :String
	{
		return Reflect.field(untyped process.env, key);
	}

	public static function environment () : haxe.ds.StringMap<String>
	{
		return untyped process.env;
	}

	public static function exit (code :Int) :Void
	{
		untyped process.exit(code);
	}

	/**
		Gives the most precise timestamp value (in seconds).
	**/
	public static function time () :Float
	{
		return untyped __js__('Date.now() / 1000');
	}
	
	public static function systemName() : String {
		switch(untyped process.platform)
		{
		case "darwin": return "Darwin";
		case "freebsd": return "BSD";
		case "linux": return "Linux";
		case "sunos": return "SunOS";
		case "win32": return "Windows";
		default: return "";
		}
	}
	
	public static function println(v:Dynamic) : Void {
		untyped console.log(v);
	}
	
	public static function executablePath() : String {
		return untyped process.execPath;
	}
	
	public static function setCwd(s:String) : Void {
		untyped process.chdir(s);
	}
}
