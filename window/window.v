module window
import via.libs.sdl2
import via.libs.flextgl
import via.libs.sokol.sdl_metal_util

pub struct Window {
pub mut:
	id u32
	sdl_window &C.SDL_Window
	gl_context voidptr
}

pub const (
	win = &Window{
		sdl_window: 0
		gl_context: 0
	}
)

pub struct WindowConfig {
pub:
	title string
	width int
	height int
	resizable bool
	fullscreen bool
	vsync bool
	highdpi bool
}

pub enum WindowMode {
	windowed = 0
	fullscreen = 1
	desktop = 4097
}

pub fn create(config &WindowConfig) {
	mut window_flags := C.SDL_WINDOW_OPENGL | C.SDL_WINDOW_MOUSE_FOCUS
	if config.resizable { window_flags = window_flags | C.SDL_WINDOW_RESIZABLE }
	if config.highdpi { window_flags = window_flags | C.SDL_WINDOW_ALLOW_HIGHDPI }
	if config.fullscreen { window_flags = window_flags | C.SDL_WINDOW_FULLSCREEN }

	$if metal? { create_metal_window(config, window_flags) }
	$if !metal? { create_gl_window(config, window_flags) }
}

pub fn free() {
	C.SDL_GL_DeleteContext(win.gl_context)
	$if !metal? { unsafe { free(win) } }
}

fn create_gl_window(config &WindowConfig, window_flags int) {
	mut w := win

	SDL_GL_SetAttribute(C.SDL_GL_CONTEXT_FLAGS, C.SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG)
	SDL_GL_SetAttribute(C.SDL_GL_CONTEXT_PROFILE_MASK, C.SDL_GL_CONTEXT_PROFILE_CORE)
	SDL_GL_SetAttribute(C.SDL_GL_CONTEXT_MAJOR_VERSION, 3)
	SDL_GL_SetAttribute(C.SDL_GL_CONTEXT_MINOR_VERSION, 3)

	SDL_GL_SetAttribute(C.SDL_GL_DOUBLEBUFFER, 1)
	SDL_GL_SetAttribute(C.SDL_GL_DEPTH_SIZE, 24)
	SDL_GL_SetAttribute(C.SDL_GL_STENCIL_SIZE, 8)

	w.sdl_window = SDL_CreateWindow(config.title.str, C.SDL_WINDOWPOS_CENTERED, C.SDL_WINDOWPOS_CENTERED, config.width, config.height, window_flags)
	w.gl_context = SDL_GL_CreateContext(w.sdl_window)
	w.id = SDL_GetWindowID(w.sdl_window)

	SDL_GL_MakeCurrent(w.sdl_window, w.gl_context)
	if config.vsync {
		SDL_GL_SetSwapInterval(1)
	} else {
		SDL_GL_SetSwapInterval(0)
	}

	flextgl.flext_init()
}

[if metal]
fn create_metal_window(config &WindowConfig, window_flags int) {
	mut w := win
	println('metal window')
	C.SDL_SetHint(C.SDL_HINT_RENDER_DRIVER, 'metal')
	C.SDL_Init(C.SDL_INIT_VIDEO | C.SDL_INIT_AUDIO)

	w.sdl_window = C.SDL_CreateWindow("V SDL2 + Metal + Sokol demo", C.SDL_WINDOWPOS_CENTERED, C.SDL_WINDOWPOS_CENTERED, 512, 384, window_flags)
	w.id = C.SDL_GetWindowID(w.sdl_window)

	sdl_metal_util.init_metal(w.sdl_window)
}

pub fn swap() {
	$if !metal? { C.SDL_GL_SwapWindow(win.sdl_window) }
}

// returns the drawable size / the window size. Used to scale mouse coords when the OS gives them to us in points.
pub fn scale() f32 {
	wx, _ := size()
	dx, _ := drawable_size()
	return dx / wx
}

pub fn drawable_size() (int, int) {
	$if metal? { return int(sdl_metal_util.width()), int(sdl_metal_util.height()) }

	width := 0
	height := 0
	C.SDL_GL_GetDrawableSize(win.sdl_window, &width, &height)
	return width, height
}

pub fn size() (int, int) {
	width := 0
	height := 0
	C.SDL_GetWindowSize(win.sdl_window, &width, &height)
	return width, height
}

pub fn width() int {
	w, _ := size()
	return w
}

pub fn height() int {
	_, h := size()
	return h
}

pub fn set_size(width, height int) {
	C.SDL_SetWindowSize(win.sdl_window, width, height)
}

pub fn set_fullscreen(mode WindowMode) {
	C.SDL_SetWindowFullscreen(win.sdl_window, mode)
}