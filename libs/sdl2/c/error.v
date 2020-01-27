module c

pub enum Errorcode {
	enomem
	efread
	efwrite
	efseek
	unsupported
	lasterror
}

fn C.SDL_SetError(fmt byteptr) int
fn C.SDL_GetError() byteptr
fn C.SDL_ClearError()
fn C.SDL_Error(code Errorcode) int