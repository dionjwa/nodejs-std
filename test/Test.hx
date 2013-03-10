import sys.FileSystem;

#if !haxe3
import haxe.Firebug;
#end
import haxe.unit.TestRunner;

class Test {
    
	static function main()
	{
		#if !haxe3
		// Redirect prints/traces to console.log
		TestRunner.print = cast Firebug.trace;
		#else
		untyped TestRunner.print = console.log;
        		#end
        		
		var runner = new TestRunner();
		runner.add(new TestSys());
		// your can add others TestCase here
		
		// Run them and and exit with the right return code
		var success = runner.run();
		(untyped process).exit(success ? 0 : 1);
	}
}

