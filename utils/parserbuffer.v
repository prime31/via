module utils

// works like a Builder but it can be reset to avoid allocations
pub struct ParserBuffer {
mut:
	buf []byte
pub mut:
	len int = 0
}

pub fn new_parser_buffer(initial_size int) ParserBuffer {
	return ParserBuffer{
		buf: new_arr<byte>(initial_size, initial_size)
	}
}

pub fn (mut b ParserBuffer) str() string {
	b.buf[b.len] = `\0`
	return b.buf.str()
}

pub fn (mut b ParserBuffer) reset() {
	b.len = 0
}

pub fn (mut b ParserBuffer) write_b(data byte) {
	b.buf[b.len] = data
	b.len++
}

pub fn (mut b ParserBuffer) free() {
	unsafe { b.buf.free() }
	b.len = 0
}