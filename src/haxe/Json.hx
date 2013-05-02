package haxe;

import js.Node;

class Json
{
	inline public static function stringify (obj :Dynamic) :String
	{
		return Node.stringify(obj);
	}
	
	inline public static function parse (jsonString :String) :Dynamic
	{
		return Node.parse(jsonString);
	}
}
