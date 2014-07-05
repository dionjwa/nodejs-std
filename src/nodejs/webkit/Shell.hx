package nodejs.webkit;

extern class Shell
{
	static public function openExternal(url:String):Void;
	static public function openItem(path:String):Void;
	static public function showItemInFolder(Path:String):Void;

	static function __init__() : Void untyped {
		Shell = UI.Shell;
	}
	
}