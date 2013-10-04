package ;

import js.Node;

import sys.FileSystem;
import sys.FileStat;
import sys.io.File;

import haxe.Http;
import haxe.Timer;
import haxe.io.Bytes;
import haxe.io.BytesBuffer;
import haxe.io.BytesData;
import haxe.io.StringInput;

class TestSys extends haxe.unit.TestCase
{
	public static var TEST_FOLDER :String = FileSystem.join("test", "foo");

	public function testFileSystem()
	{
		if (FileSystem.exists(TEST_FOLDER)) {
			assertTrue(FileSystem.readDirectory(TEST_FOLDER).length == 0);
			FileSystem.deleteDirectory(TEST_FOLDER);
		}

		assertFalse(FileSystem.exists(TEST_FOLDER));

		FileSystem.createDirectory(TEST_FOLDER);
		assertTrue(FileSystem.exists(TEST_FOLDER));
		assertTrue(FileSystem.isDirectory(TEST_FOLDER));
		assertTrue(FileSystem.readDirectory(TEST_FOLDER).length == 0);
		assertEquals( "A", "A" );

		var folders = ["A", "B", "C"];

		for (f in folders) {
			var path = FileSystem.join(TEST_FOLDER, f);
			FileSystem.createDirectory(path);
			assertTrue(FileSystem.exists(path));
			assertTrue(FileSystem.isDirectory(path));
		}

		FileSystem.createDirectory(FileSystem.join(TEST_FOLDER, folders[0], "D"));

		FileSystem.deleteDirectory(FileSystem.join(TEST_FOLDER, folders[0], "D"));
		for (f in folders) {
			var path = FileSystem.join(TEST_FOLDER, f);
			FileSystem.deleteDirectory(path);
			assertFalse(FileSystem.exists(path));
		}

		assertTrue(FileSystem.readDirectory(TEST_FOLDER).length == 0);
		FileSystem.deleteDirectory(TEST_FOLDER);
	}

}
