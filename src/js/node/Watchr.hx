package js.node;
import js.Node;

/**
 * ...
 * @author AS3Boyan
 */
 
typedef Listeners =
{
	@:optional var log:String->Void;
	@:optional var error:Dynamic->Void;
	@:optional var watching:Dynamic->Dynamic->Bool->Void;
	@:optional var change:String->String->NodeStat->NodeStat->Void;
}
 
typedef Config =
{
	@:optional var path:String;
	@:optional var paths:Array<String>;
	@:optional var listener:Dynamic;
	@:optional var listeners:Dynamic;
	@:optional var next:Dynamic;
	@:optional var stat:Dynamic;
	@:optional var interval:Int;
	@:optional var persistent:Bool;
	@:optional var catchupDelay:Int;
	@:optional var preferredMethods:Array<String>;
	@:optional var followLinks:Bool;
	@:optional var ignorePaths:Bool;
	@:optional var ignoreHiddenFiles:Bool;
	@:optional var ignoreCommonPatterns:Bool;
	@:optional var ignoreCustomPatterns:Dynamic;
}

@:native("Watchr")
extern class Watchr
{
	static function watch(config:Config):Dynamic;
	
	static function __init__() : Void untyped {
		var Watchr = Node.require('watchr');
	}	
}