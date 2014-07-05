package nodejs.webkit;

/**
 * ...
 * @author AS3Boyan
 */
extern class App
{
	static var argv:Dynamic;
	static var fullArgv:Dynamic;
	static var dataPath:String;
	static var manifest:Dynamic;
	static function quit():Void;
	static function clearCache():Void;
	static function closeAllWindows():Void;
	static function crashBrowser():Void;
	static function crashRenderer():Void;
	static function getProxyForURL(url:String):Dynamic;
	static function setCrashDumpDir(path:String):Void;
	
	static function __init__() : Void untyped {
		App = UI.App;
	}
}