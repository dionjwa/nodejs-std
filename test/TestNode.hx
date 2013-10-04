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
	}

	public function testJson()
	{
		var obj :{test :String} = Node.json.parse('{"test":"foo"}');
		assertTrue(obj.test == "foo");
	}
}
