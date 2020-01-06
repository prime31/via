module via
import via.libs.flextgl
import via.libs.sokol
import via.libs.sokol.gfx
import via.libs.sdl2

pub struct Via {
mut:
	sdl_window voidptr
	gl_context voidptr
pub:
	audio &Audio
	filesystem &FileSystem
	graphics &Graphics
	timer &Timer
	window &Window
}

fn create_via(config &ViaConfig) &Via {
	filesystem := create_filesystem(config)

	via := &Via {
		sdl_window: voidptr(0)
		gl_context: voidptr(0)
		audio: create_audio(config)
		filesystem: filesystem
		graphics: create_graphics(config, filesystem)
		timer: create_timer(config)
		window: create_window(config)
	}

	return via
}

pub fn run<T>(config &ViaConfig, ctx &T) {
	mut v := create_via(config)
	v.setup_sdl(config)
	sg_setup(&sg_desc{})

	ctx.initialize(v)

	mut done := false
	for !done {
		ev := SDL_Event{}
		for 0 < C.SDL_PollEvent(&ev) {
			match int(ev.@type) {
				C.SDL_QUIT {
					done = true
					break
				}
				C.SDL_WINDOWEVENT {
					if ev.window.event == C.SDL_WINDOWEVENT_CLOSE && ev.window.windowID == C.SDL_GetWindowID(v.sdl_window) {
						done = true
						break
					}
				}
				else {}
			}
		}

		ctx.update(v)
		ctx.draw(v)

		w := 0
		h := 0
		SDL_GL_GetDrawableSize(v.sdl_window, &w, &h)

		pass_action := gfx.create_clear_pass(1.0, 0.3, 1.0, 1.0)
		sg_begin_default_pass(&pass_action, w, h)
		sg_end_pass()
		sg_commit()

		C.SDL_GL_SwapWindow(v.sdl_window)
	}

	C.SDL_GL_DeleteContext(v.gl_context)
	C.SDL_VideoQuit()

	v.free()
}

fn (v mut Via) setup_sdl(config &ViaConfig) {
	C.SDL_Init(C.SDL_INIT_VIDEO)

    C.SDL_GL_SetAttribute(C.SDL_GL_CONTEXT_FLAGS, C.SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG)
    C.SDL_GL_SetAttribute(C.SDL_GL_CONTEXT_PROFILE_MASK, C.SDL_GL_CONTEXT_PROFILE_CORE)
    C.SDL_GL_SetAttribute(C.SDL_GL_CONTEXT_MAJOR_VERSION, 3)
    C.SDL_GL_SetAttribute(C.SDL_GL_CONTEXT_MINOR_VERSION, 3)

	C.SDL_GL_SetAttribute(C.SDL_GL_DOUBLEBUFFER, 1)
	C.SDL_GL_SetAttribute(C.SDL_GL_DEPTH_SIZE, 24)
	C.SDL_GL_SetAttribute(C.SDL_GL_STENCIL_SIZE, 8)

	window_flags := C.SDL_WINDOW_OPENGL | C.SDL_WINDOW_RESIZABLE | C.SDL_WINDOW_ALLOW_HIGHDPI
	v.sdl_window = C.SDL_CreateWindow("V SDL2 + OpenGL3 + Sokol demo", C.SDL_WINDOWPOS_CENTERED, C.SDL_WINDOWPOS_CENTERED, config.window_width, config.window_height, window_flags)
	v.gl_context = C.SDL_GL_CreateContext(v.sdl_window)

	C.SDL_GL_MakeCurrent(v.sdl_window, v.gl_context)
	C.SDL_GL_SetSwapInterval(1) // Enable vsync

	flextgl.flext_init()
}

fn (v &Via) free() {
	v.audio.free()
	v.filesystem.free()
	v.graphics.free()
	v.timer.free()
	v.window.free()

	sg_shutdown()

	unsafe { free(v) }
}