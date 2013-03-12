[haxe]: http://http://haxe.org
[nodejs]:http://nodejs.org/
[haxelib]:http://lib.haxe.org

# Std [haxe lib][haxelib] for [node.js][nodejs]

### Please note:

Due to issue [1603](https://code.google.com/p/haxe/issues/detail?id=1603) you will need to add 
	
	--remap sys:sys
	
to your hxml file or build command *after the -js option* (until that issue gets resolved).

*Haxe 3/2.10 compatible.*

*Include the compiler flag -D nodejs in your hxml*.

### Description

This library contains all you need to use haxe plus the std libary with node.js.

### History

Alternative to the [nodejs haxelib](http://lib.haxe.org/p/nodejs) library, forked due to a lack of maintenance form the other library.

This library includes code from [Ritchie Turner's haxe node.js github libraries](https://github.com/cloudshift).  There doesn't seem to be a canonical haxe std lib to match the [nodejs haxelib](http://lib.haxe.org/p/nodejs).  Many of the existing libraries have an unknown status, or have migrated to other projects.



