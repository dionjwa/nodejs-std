[haxe]: http://http://haxe.org
[nodejs]:http://nodejs.org/
[haxelib]:http://lib.haxe.org

# Std [haxe lib][haxelib] for [node.js][nodejs]

Haxe 2.10 compatible.

Partner to the [nodejs haxelib](http://lib.haxe.org/p/nodejs).

This library includes code from [Ritchie Turner's haxe node.js github libraries](https://github.com/cloudshift).  There doesn't seem to be a canonical haxe std lib to match the [nodejs haxelib](http://lib.haxe.org/p/nodejs).  Many of the existing libraries have an unknown status, or have migrated to other projects.

I've focused on the Http and related classes for now since these are most important for [Node.js][nodejs].

Also it includes the *sys.io* classes, although they're in a parent *js* package until I can get the compiler to accept that js output is allowed the sys package.

