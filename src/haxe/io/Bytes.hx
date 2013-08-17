/*
 * Copyright (c) 2005-2008, The haXe Project Contributors
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE HAXE PROJECT CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE HAXE PROJECT CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 */
package haxe.io;

class Bytes {

	public var length(default,null) : Int;
	var b : BytesData;

	function new(length,b) {
		this.length = length;
		this.b = b;
	}

	public inline function get( pos : Int ) : Int {
		#if neko
		return untyped __dollar__sget(b,pos);
		#elseif flash9
		return b[pos];
		#elseif php
		return untyped __call__("ord", b[pos]);
		#elseif cpp
		return untyped b[pos];
		#else
		return b[pos];
		#end
	}

	public inline function set( pos : Int, v : Int ) : Void {
		#if neko
		untyped __dollar__sset(b,pos,v);
		#elseif flash9
		b[pos] = v;
		#elseif php
		b[pos] = untyped __call__("chr", v);
		#elseif cpp
		untyped b[pos] = v;
    #elseif (nodejs || nodejs_std)
    b[pos] = v;
		#else
		b[pos] = v & 0xFF;
		#end
	}

	public function blit( pos : Int, src : Bytes, srcpos : Int, len : Int ) : Void {
		#if !neko
		if( pos < 0 || srcpos < 0 || len < 0 || pos + len > length || srcpos + len > src.length ) throw Error.OutsideBounds;
		#end
		#if neko
		try untyped __dollar__sblit(b,pos,src.b,srcpos,len) catch( e : Dynamic ) throw Error.OutsideBounds;
		#elseif php
		// TODO: test me
		b = untyped __php__("substr($this->b, 0, $pos) . substr($src->b, $srcpos, $len) . substr($this->b, $pos+$len)"); //__call__("substr", b, 0, pos)+__call__("substr", src.b, srcpos, len)+__call__("substr", b, pos+len);
		#elseif flash9
		b.position = pos;
		b.writeBytes(src.b,srcpos,len);
		#elseif (nodejs || nodejs_std)
    src.getData().copy(b,pos,srcpos,srcpos+len);
    #else
		var b1 = b;
		var b2 = src.b;
		if( b1 == b2 && pos > srcpos ) {
			var i = len;
			while( i > 0 ) {
				i--;
				b1[i + pos] = b2[i + srcpos];
			}
			return;
		}
		for( i in 0...len )
			b1[i+pos] = b2[i+srcpos];
		#end
	}

	public function sub( pos : Int, len : Int ) : Bytes {
		#if !neko
		if( pos < 0 || len < 0 || pos + len > length ) throw Error.OutsideBounds;
		#end
		#if neko
		return try new Bytes(len,untyped __dollar__ssub(b,pos,len)) catch( e : Dynamic ) throw Error.OutsideBounds;
		#elseif flash9
		b.position = pos;
		var b2 = new flash.utils.ByteArray();
		b.readBytes(b2,0,len);
		return new Bytes(len,b2);
		#elseif php
		// TODO: test me
		return new Bytes(len, untyped __call__("substr", b, pos, len));
		#elseif (nodejs || nodejs_std)

    /* node slice does not return a copy, so need a blit(copy) */
    var
      nb = new js.Node.NodeBuffer(len),
      slice:js.Node.NodeBuffer = b.slice(pos,pos+len);

    slice.copy(nb,0,0,len);
		return new Bytes(len,nb);
		#else
		return new Bytes(len,b.slice(pos,pos+len));
    #end
	}

	public function compare( other : Bytes ) : Int {
		#if neko
		return untyped __dollar__compare(b,other.b);
		#elseif flash9
		var len = (length < other.length) ? length : other.length;
		var b1 = b;
		var b2 = other.b;
		b1.position = 0;
		b2.position = 0;
		for( i in 0...len>>2 )
			if( b1.readUnsignedInt() != b2.readUnsignedInt() ) {
				b1.position -= 4;
				b2.position -= 4;
				return b1.readUnsignedInt() - b2.readUnsignedInt();
			}
		for( i in 0...len & 3 )
			if( b1.readUnsignedByte() != b2.readUnsignedByte() )
				return b1[b1.position-1] - b2[b2.position-1];
		return length - other.length;
		#elseif php
		return untyped __php__("$this->b < $other->b ? -1 : ($this->b == $other->b ? 0 : 1)");
		#else
		var b1 = b;
		var b2 = other.b;
		var len = (length < other.length) ? length : other.length;
		for( i in 0...len )
			if( b1[i] != b2[i] )
				#if cpp
				return untyped b1[i] - untyped b2[i];
				#else
				return b1[i] - b2[i];
				#end
		return length - other.length;
		#end
	}

	public function readString( pos : Int, len : Int ) : String {
		#if !neko
		if( pos < 0 || len < 0 || pos + len > length ) throw Error.OutsideBounds;
		#end
		#if neko
		return try new String(untyped __dollar__ssub(b,pos,len)) catch( e : Dynamic ) throw Error.OutsideBounds;
		#elseif flash9
		b.position = pos;
		return b.readUTFBytes(len);
		#elseif php
		// TODO: test me
		return untyped __call__("substr", b, pos, len);
//		return untyped __call__("call_user_func_array", "pack", __call__("array_merge", __call__("array", "C*"), __call__("array_slice", b.�a, pos, len)));
		#elseif cpp
		var result:String="";
		untyped __global__.__hxcpp_string_of_bytes(b,result,pos,len);
		return result;
		#else
		var s = "";
		var b = b;
		var fcc = String.fromCharCode;
		var i = pos;
		var max = pos+len;
		// utf8-encode
		while( i < max ) {
			var c = b[i++];
			if( c < 0x80 ) {
				if( c == 0 ) break;
				s += fcc(c);
			} else if( c < 0xE0 )
				s += fcc( ((c & 0x3F) << 6) | (b[i++] & 0x7F) );
			else if( c < 0xF0 ) {
				var c2 = b[i++];
				s += fcc( ((c & 0x1F) << 12) | ((c2 & 0x7F) << 6) | (b[i++] & 0x7F) );
			} else {
				var c2 = b[i++];
				var c3 = b[i++];
				s += fcc( ((c & 0x0F) << 18) | ((c2 & 0x7F) << 12) | ((c3 << 6) & 0x7F) | (b[i++] & 0x7F) );
			}
		}
		return s;
    #else (nodejs || nodejs_std)
       return b.toString(js.Node.UTF8,pos,pos+len);
		#end
	}

	public function toString() : String {
		#if neko
		return new String(untyped __dollar__ssub(b,0,length));
		#elseif flash9
		b.position = 0;
		return b.readUTFBytes(length);
		#elseif php
		// TODO: test me
		return cast b;
//		return untyped __call__("call_user_func_array", "pack", __call__("array_merge", __call__("array", "C*"), b.�a));
		#else
		return readString(0,length);
		#end
	}
	
	public function toHex() : String {
		var s = new StringBuf();
		var chars = [];
		var str = "0123456789abcdef";
		for( i in 0...str.length )
			chars.push(str.charCodeAt(i));
		for( i in 0...length ) {
			var c = get(i);
			s.addChar(chars[c >> 4]);
			s.addChar(chars[c & 15]);
		}
		return s.toString();
	}

	public inline function getData() : BytesData {
		return b;
	}

	public static function alloc( length : Int ) : Bytes {
		#if neko
		return new Bytes(length,untyped __dollar__smake(length));
		#elseif flash9
		var b = new flash.utils.ByteArray();
		b.length = length;
		return new Bytes(length,b);
		#elseif php
		// TODO: test me
		return new Bytes(length, untyped __call__("str_repeat", __call__("chr", 0), length));
		/*
		if(length > 0)
			return new Bytes(length, untyped __call__("new _hx_array", __call__("array_fill", 0, length, 0)));
		else
			return new Bytes(0, untyped __call__("new _hx_array", __call__("array")));
		*/
		#elseif cpp
		var a = new BytesData();
		if (length>0) a[length-1] = untyped 0;
		return new Bytes(length,a);
		#elseif (nodejs || nodejs_std)
    return new Bytes(length,new js.Node.NodeBuffer(length));

    #else
		var a = new Array();
		for( i in 0...length )
			a.push(0);
		return new Bytes(length,a);
		#end
	}

	public static function ofString( s : String ) : Bytes {
		#if neko
		return new Bytes(s.length,untyped __dollar__ssub(s.__s,0,s.length));
		#elseif flash9
		var b = new flash.utils.ByteArray();
		b.writeUTFBytes(s);
		return new Bytes(b.length,b);
		#elseif php
		return new Bytes(untyped __call__("strlen", s), cast s);
//		return ofData(untyped __call__("new _hx_array", __call__("array_values", __call__("unpack", "C*",  s))));
		#elseif cpp
		var a = new BytesData();
		untyped __global__.__hxcpp_bytes_of_string(a,s);
		return new Bytes(a.length,a);
		#elseif (nodejs || nodejs_std)
    var nb = new js.Node.NodeBuffer(s, js.Node.NodeC.UTF8);
    return new Bytes(nb.length,nb);
    #else
		var a = new Array();
		// utf8-decode
		for( i in 0...s.length ) {
			var c : Int = untyped s["cca"](i);
			if( c <= 0x7F )
				a.push(c);
			else if( c <= 0x7FF ) {
				a.push( 0xC0 | (c >> 6) );
				a.push( 0x80 | (c & 63) );
			} else if( c <= 0xFFFF ) {
				a.push( 0xE0 | (c >> 12) );
				a.push( 0x80 | ((c >> 6) & 63) );
				a.push( 0x80 | (c & 63) );
			} else {
				a.push( 0xF0 | (c >> 18) );
				a.push( 0x80 | ((c >> 12) & 63) );
				a.push( 0x80 | ((c >> 6) & 63) );
				a.push( 0x80 | (c & 63) );
			}
		}
		return new Bytes(a.length,a);
		#end
	}

	public static function ofData( b : BytesData ) {
		#if flash9
		return new Bytes(b.length,b);
		#elseif neko
		return new Bytes(untyped __dollar__ssize(b),b);
		#elseif php
		return new Bytes(untyped __call__("strlen", b), b);
		#else
		return new Bytes(b.length,b);
		#end
	}

}
