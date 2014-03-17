package ;

import js.Node;

class TestNode extends haxe.unit.TestCase
{
	public function testLazyRequire()
	{
		assertTrue(Node.assert != null);
		Node.assert.ok(true);
	}

	public function testStandardModules()
	{
		//util
		assertTrue(Node.util != null);
		assertTrue(Node.util.isArray([]));

		//assert
		Node.assert.ok(true);

		//childProcess
		assertTrue(Node.child_process.spawn != null);

		//cluster
		assertTrue(Node.cluster.fork != null);

		//globals
		assertTrue(Node.setTimeout != null);
		assertTrue(Node.clearTimeout != null);
		assertTrue(Node.setInterval != null);
		// Not present in Node < 0.9
		var version = Node.process.version.substr(1).split(".").map(Std.parseInt);
		if (version[0] > 0 || version[1] >= 9) {
			assertTrue(Node.setImmediate != null);
			assertTrue(Node.clearImmediate != null);
		}
	}

	public function testJson()
	{
		var obj :{test :String} = Node.json.parse('{"test":"foo"}');
		assertTrue(obj.test == "foo");
	}
}
