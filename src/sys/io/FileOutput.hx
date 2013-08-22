package sys.io;

@:allow(sys.io.File)
class FileOutput extends haxe.io.Output {

    var stream:js.Node.NodeWriteStream;
    var byteBuffer:js.Node.NodeBuffer;
    function new(path:String, ?binary:Bool) {
        stream = js.Node.fs.createWriteStream(path);
        byteBuffer = new js.Node.NodeBuffer(1);
    }

    public function seek(p:Int, pos:FileSeek):Void  {
        throw "not implemented";
    }
    public function tell():Int {
        throw "not implemented";
        return 0;
    }

    public override function write(bytes:haxe.io.Bytes):Void {
        stream.write(bytes.getData());
    }
    public override function writeByte(c:Int):Void {
        byteBuffer[0] = c;
        stream.write(byteBuffer);
    }
    public override function close():Void {
        stream.end();
    }
}
