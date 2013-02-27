package js.sys;

import js.Node;
/**
	This class allows you to get informations about the files and directories.
**/
class FileSystem 
{
	/**
		Tells if the given file or directory exists.
	**/
	public static function exists( path : String ) : Bool
	{
		return Node.fs.existsSync(path);
	}

	/**
		Rename the corresponding file or directory, allow to move it accross directories as well.
	**/
	public static function rename( path : String, newpath : String ) : Void
	{
		Node.fs.renameSync(path, newpath);
	}

	/**
		Returns informations for the given file/directory.
	**/
	public static function stat( path : String ) : NodeStat
	{
		return Node.fs.statSync(path);
	}

	/**
		Returns the full path for the given path which is relative to the current working directory.
	**/
	public static function fullPath( relpath : String ) : String
	{
		return Node.path.resolve(null, relpath);
	}

	/**
		Tells if the given path is a directory. Throw an exception if it does not exists or is not accesible.
	**/
	public static function isDirectory( path : String ) : Bool
	{
		return Node.fs.statSync(path).isDirectory();
	}

	/**
		Create the given directory. Not recursive : the parent directory must exists.
	**/
	public static function createDirectory( path : String ) : Void
	{
		Node.fs.mkdirSync(path);
	}

	/**
		Delete a given file.
	**/
	public static function deleteFile( path : String ) : Void
	{
		Node.fs.unlinkSync(path);
	}
	/**
		Delete a given directory.
	**/
	public static function deleteDirectory( path : String ) : Void
	{
		Node.fs.rmdirSync(path);
	}

	/**
		Read all the files/directories stored into the given directory.
	**/
	public static function readDirectory( path : String ) : Array<String>
	{
		return Node.fs.readdirSync(path);
	}
	
	public static function signature (path) :String
	{
		var shasum = Node.crypto.createHash('md5');
		shasum.update(Node.fs.readFileSync(path));
		return shasum.digest(NodeC.HEX);
	}
	
	public static function join(?p1:String,?p2:String,?p3:String) :String
	{
		return Node.path.join(p1, p2, p3);
	}
	

}
