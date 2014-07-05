package js.node;
import js.Node;
import js.node.Walkdir.EventEmitter;

/**
 * ...
 * @author AS3Boyan
 */

extern class EventEmitter
{
	function on(event:String, fn:Dynamic):Void;
}
 
@:native("Walkdir")
class Walkdir
{
	static var walkdir:Dynamic;
	
	static function __init__() : Void untyped {
		walkdir = Node.require('walkdir');
	}	
	
	public static function walk(path:String, ?onItem:String->NodeStat->Void):EventEmitter
	{
		var emitter:EventEmitter;
		
		if (onItem != null) 
		{
			emitter = walkdir(path);
		}
		else 
		{
			emitter = walkdir(path, onItem);
		}
		
		return emitter;
	}
}