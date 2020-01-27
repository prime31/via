module via
import via.libs.sdl2
import via.libs.flextgl

struct Window {
pub mut:
	id u32
mut:
	sdl_window voidptr
	gl_context voidptr
}

fn window(config ViaConfig) &Window {
	return &Window{
		sdl_window: voidptr(0)
		gl_context: voidptr(0)
	}
}

fn (w &Window) free() {
	C.SDL_GL_DeleteContext(w.gl_context)
	unsafe { free(w) }
}

fn (w mut Window) create(config &ViaConfig) {
	SDL_GL_SetAttribute(C.SDL_GL_CONTEXT_FLAGS, C.SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG)
	SDL_GL_SetAttribute(C.SDL_GL_CONTEXT_PROFILE_MASK, C.SDL_GL_CONTEXT_PROFILE_CORE)
	SDL_GL_SetAttribute(C.SDL_GL_CONTEXT_MAJOR_VERSION, 3)
	SDL_GL_SetAttribute(C.SDL_GL_CONTEXT_MINOR_VERSION, 3)

	SDL_GL_SetAttribute(C.SDL_GL_DOUBLEBUFFER, 1)
	SDL_GL_SetAttribute(C.SDL_GL_DEPTH_SIZE, 24)
	SDL_GL_SetAttribute(C.SDL_GL_STENCIL_SIZE, 8)

	mut window_flags := C.SDL_WINDOW_OPENGL | C.SDL_WINDOW_MOUSE_FOCUS
	if config.window_resizable { window_flags = window_flags | C.SDL_WINDOW_RESIZABLE }
	if config.window_highdpi { window_flags = window_flags | C.SDL_WINDOW_ALLOW_HIGHDPI }
	if config.window_fullscreen { window_flags = window_flags | C.SDL_WINDOW_FULLSCREEN }

	w.sdl_window = SDL_CreateWindow(config.window_title.str, C.SDL_WINDOWPOS_CENTERED, C.SDL_WINDOWPOS_CENTERED, config.window_width, config.window_height, window_flags)
	w.gl_context = SDL_GL_CreateContext(w.sdl_window)
	w.id = SDL_GetWindowID(w.sdl_window)

	SDL_GL_MakeCurrent(w.sdl_window, w.gl_context)
	if config.window_vsync {
		SDL_GL_SetSwapInterval(1)
	}

	flextgl.flext_init()
}

fn (w &Window) swap() {
	SDL_GL_SwapWindow(w.sdl_window)
}

pub fn (w &Window) get_drawable_size() (int, int) {
	width := 0
	height := 0
	SDL_GL_GetDrawableSize(w.sdl_window, &width, &height)
	return width, height
}

pub fn (w &Window) get_size() (int, int) {
	width := 0
	height := 0
	SDL_GetWindowSize(w.sdl_window, &width, &height)
	return width, height
}

pub fn (w &Window) set_size(width, height int) {
	SDL_SetWindowSize(w.sdl_window, width, height)
}