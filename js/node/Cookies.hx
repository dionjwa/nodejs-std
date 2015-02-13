package js.node;

import js.Node;

//Cookies
//https://www.npmjs.com/package/cookies
@:native("Cookies")
extern
class Cookies
{
	public function new(request :NodeHttpServerReq, response :NodeHttpServerResp, ?keys :Dynamic):Void;

	public function get(cookieId :String, ?options :Dynamic) :String;
	public function set(cookieId :String, ?value :String, ?options :Dynamic) :String;
	private static function __init__() : Void untyped
	{
		var Cookies = untyped __js__("require('cookies')");
	}
}