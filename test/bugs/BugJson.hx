package bugs;


class BugJson
{
	macro static public function test()
	{
		haxe.Json.parse("{}"); return macro {};
	}
}
