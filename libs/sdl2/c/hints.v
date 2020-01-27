module c

pub enum HintPriority {
	default
	normal
	override
}

fn C.SDL_SetHintWithPriority(name byteptr, value byteptr, priority HintPriority) Bool
fn C.SDL_SetHint(name byteptr, value byteptr) Bool
fn C.SDL_GetHint(name byteptr) byteptr
fn C.SDL_GetHintBoolean(name byteptr, default_value Bool) Bool
fn C.SDL_AddHintCallback(name byteptr, callback fn(voidptr, byteptr, byteptr, byteptr), userdata voidptr)
fn C.SDL_DelHintCallback(name byteptr, callback fn(voidptr, byteptr, byteptr, byteptr), userdata voidptr)
fn C.SDL_ClearHints()
