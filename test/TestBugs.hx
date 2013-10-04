package ;

import js.Node;

class TestBugs extends haxe.unit.TestCase
{
	//https://github.com/dionjwa/nodejs-std/issues/10
	public function testMacroJson()
	{
		var macroBlob = bugs.BugJson.test();
		var nonMacroBlob :Dynamic = {};
		assertTrue(haxe.Json.stringify(macroBlob) == haxe.Json.stringify(nonMacroBlob));
	}
}
