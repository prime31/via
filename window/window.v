module window
import via.events
import via.libs.flextgl
import via.libs.sokol.sdl_metal_util

pub struct Window {
pub mut:
	id u32
	sdl_window &C.SDL_Window
	gl_context voidptr
	evt_emitter events.EventEmitter
	focused bool
}

pub const (
	win = &Window{
		sdl_window: 0
		gl_context: 0
		evt_emitter: events.eventemitter()
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

//#region Window Management

pub fn create(config &WindowConfig) {
	mut window_flags := C.SDL_WINDOW_OPENGL | C.SDL_WINDOW_MOUSE_FOCUS
	if config.resizable { window_flags = window_flags | C.SDL_WINDOW_RESIZABLE }
	if config.highdpi { window_flags = window_flags | C.SDL_WINDOW_ALLOW_HIGHDPI }
	if config.fullscreen { window_flags = window_flags | C.SDL_WINDOW_FULLSCREEN }

	$if metal? { create_metal_window(config, window_flags) }
	$if !metal? { create_gl_window(config, window_flags) }
}

pub fn free() {
	$if !metal? { C.SDL_GL_DeleteContext(win.gl_context) }
	unsafe { C.free(win) }
}

fn create_gl_window(config &WindowConfig, window_flags int) {
	mut w := win

	C.SDL_GL_SetAttribute(C.SDL_GL_CONTEXT_FLAGS, C.SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG)
	C.SDL_GL_SetAttribute(C.SDL_GL_CONTEXT_PROFILE_MASK, C.SDL_GL_CONTEXT_PROFILE_CORE)
	C.SDL_GL_SetAttribute(C.SDL_GL_CONTEXT_MAJOR_VERSION, 3)
	C.SDL_GL_SetAttribute(C.SDL_GL_CONTEXT_MINOR_VERSION, 3)

	C.SDL_GL_SetAttribute(C.SDL_GL_DOUBLEBUFFER, 1)
	C.SDL_GL_SetAttribute(C.SDL_GL_DEPTH_SIZE, 24)
	C.SDL_GL_SetAttribute(C.SDL_GL_STENCIL_SIZE, 8)

	w.sdl_window = C.SDL_CreateWindow(config.title.str, C.SDL_WINDOWPOS_CENTERED, C.SDL_WINDOWPOS_CENTERED, config.width, config.height, window_flags)
	w.gl_context = C.SDL_GL_CreateContext(w.sdl_window)
	w.id = C.SDL_GetWindowID(w.sdl_window)

	C.SDL_GL_MakeCurrent(w.sdl_window, w.gl_context)
	if config.vsync {
		C.SDL_GL_SetSwapInterval(1)
	} else {
		C.SDL_GL_SetSwapInterval(0)
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

//#endregion

//#region Internal event handling

pub fn handle_event(evt &C.SDL_Event) {
	mut w := win
	match evt.window.event {
		.moved {}
		.shown {}
		.hidden {}
		.exposed {}
		.resized {}
		.size_changed { w.evt_emitter.publish(int(WindowEvents.resize), voidptr(0), voidptr(0)) }
		.minimized {}
		.maximized {}
		.restored {}
		.enter {}
		.leave {}
		.focus_gained { w.focused = true }
		.focus_lost { w.focused = false }
		.close {}
		.take_focus {}
		.hit_test {}
		else {}
	}
}

//#endregion

//#region External events

pub enum WindowEvents {
	resize
}

pub fn subscribe(evt WindowEvents, callback events.EventHandlerFn, context voidptr, once bool) {
	mut w := win
	w.evt_emitter.subscribe(int(evt), callback, context, once)
}

pub fn unsubscribe(evt WindowEvents, callback events.EventHandlerFn) {
	mut w := win
	w.evt_emitter.unsubscribe(int(evt), callback)
}

//#endregion

//#region Window information

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

pub fn focused() bool {
	return win.focused
}

pub fn set_size(width, height int) {
	C.SDL_SetWindowSize(win.sdl_window, width, height)
}

pub fn set_fullscreen(mode WindowMode) {
	C.SDL_SetWindowFullscreen(win.sdl_window, mode)
}

//#endregion