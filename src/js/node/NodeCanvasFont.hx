package js.node;

import js.Node;

@:native("Font")
extern class NodeCanvasFont
{
	public function addFace(fontPath :String, face :String) :Void;
	public function new(name :String, path :String) : Void;

	private static function __init__() : Void untyped
	{
		try {
			var Font = Node.require('canvas').Font;
		} catch (e :Dynamic) {}
	}
}