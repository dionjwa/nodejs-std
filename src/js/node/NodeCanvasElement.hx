package js.node;

import js.Node;

@:native("Canvas")
extern class NodeCanvasElement
{
	var height : Int;
	var width : Int;
	function getContext( contextId : String ) : Dynamic;
	function toDataURL( ?type : String ) : String;
	/** A typed shortcut for <code>getContext("2d")</code>. */
	public inline function getContext2d() : NodeCanvasRenderingContext2D { return cast getContext("2d"); }
	public function new(width :Int, height :Int) : Void;

	public function createPNGStream() :NodeWriteStream;
	public function toBuffer() :NodeBuffer;

	private static function __init__() : Void untyped
	{
		var Canvas = Node.require('canvas');
	}

}




