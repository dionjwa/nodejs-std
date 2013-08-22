package sys.io;

@:allow(sys.io.File)
class FileOutput extends haxe.io.Output {

    var stream:js.Node.NodeWriteStream;
    var buffer:js.Node.NodeBuffer;
    function new(path:String, ?binary:Bool) {
        stream = js.Node.fs.createWriteStream(path);
        buffer = new js.Node.NodeBuffer(1);
    }

    public function seek(p:Int, pos:FileSeek):Void  {
        throw "not implemented";
    }
    public function tell():Int {
        throw "not implemented";
        return 0;
    }

    public override function writeByte(c:Int):Void {
        buffer[0] = c;
        stream.write(buffer);
    }
    public override function close():Void {
        stream.end();
    }
}
