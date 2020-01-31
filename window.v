module via
import via.libs.sdl2
import via.libs.flextgl
import via.libs.sokol.sdl_metal_util

struct Window {
pub mut:
	id u32
mut:
	sdl_window &C.SDL_Window
	gl_context voidptr
}

fn window(config ViaConfig) &Window {
	return &Window{
		sdl_window: 0
		gl_context: voidptr(0)
	}
}

fn (w &Window) free() {
	C.SDL_GL_DeleteContext(w.gl_context)
	unsafe { free(w) }
}

fn (w mut Window) create(config &ViaConfig) {
	$if metal? { w.create_metal_window(config) }
	$if !metal? { w.create_gl_window(config) }
}

fn (w mut Window) create_gl_window(config &ViaConfig) {
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

[if metal]
fn (w mut Window) create_metal_window(config &ViaConfig) {
	println('metal window')
	C.SDL_SetHint(C.SDL_HINT_RENDER_DRIVER, 'metal')
	C.SDL_Init(C.SDL_INIT_VIDEO | C.SDL_INIT_AUDIO)

	mut window_flags := C.SDL_WINDOW_MOUSE_FOCUS
	if config.window_resizable { window_flags = window_flags | C.SDL_WINDOW_RESIZABLE }
	if config.window_highdpi { window_flags = window_flags | C.SDL_WINDOW_ALLOW_HIGHDPI }
	if config.window_fullscreen { window_flags = window_flags | C.SDL_WINDOW_FULLSCREEN }
	w.sdl_window = C.SDL_CreateWindow("V SDL2 + Metal + Sokol demo", C.SDL_WINDOWPOS_CENTERED, C.SDL_WINDOWPOS_CENTERED, 512, 384, window_flags)
	w.id = C.SDL_GetWindowID(w.sdl_window)

	sdl_metal_util.init_metal(w.sdl_window)
}

fn (w &Window) swap() {
	$if !metal? { C.SDL_GL_SwapWindow(w.sdl_window) }
}

// returns the drawable size / the window size. Used to scale mouse coords when the OS gives them to us in points.
pub fn (w &Window) get_scale() f32 {
	wx, _ := w.get_size()
	dx, _ := w.get_drawable_size()
	return dx / wx
}

pub fn (w &Window) get_drawable_size() (int, int) {
	$if metal? { return int(sdl_metal_util.width()), int(sdl_metal_util.height()) }

	width := 0
	height := 0
	C.SDL_GL_GetDrawableSize(w.sdl_window, &width, &height)
	return width, height
}

pub fn (w &Window) get_size() (int, int) {
	width := 0
	height := 0
	C.SDL_GetWindowSize(w.sdl_window, &width, &height)
	return width, height
}

pub fn (w &Window) set_size(width, height int) {
	C.SDL_SetWindowSize(w.sdl_window, width, height)
}