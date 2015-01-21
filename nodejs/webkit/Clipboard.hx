package nodejs.webkit;

extern class Clipboard {
	
	public static inline function getInstance() : Clipboard {
		return untyped Clipboard.get();
	}
	
	public function get( ?type : String ) : Dynamic;
	public function set( data : Dynamic, ?type : String ) : Void;
	public function clear() : Void;

	static function __init__() : Void untyped {
		Clipboard = UI.Clipboard;
	}
	
}