module via
import via.time
import via.input
import via.libs.flextgl
import via.libs.sokol
import via.libs.sokol.gfx
import via.libs.sdl2

pub struct Via {
pub mut:
	audio &Audio
	fs &FileSystem
	g &Graphics
	win &Window
	imgui bool
}

__global vv &Via

pub const (
	v = &Via{
		audio: 0
		fs: 0
		g: 0
		win: 0
	}
)

fn create_via(config &ViaConfig) &Via {
	fs := new_filesystem(config)

	vv = &Via {
		audio: audio(config)
		fs: fs
		g: graphics(config)
		win: window(config)
		imgui: config.imgui
	}

	return vv
}

fn (v &Via) free() {
	v.audio.free()
	v.fs.free()
	v.g.free()
	time.free()
	v.win.free()

	sg_shutdown()

	unsafe { free(v) }
}

pub fn run<T>(config &ViaConfig, ctx mut T) {
	mut v := create_via(config)
	if C.SDL_Init(C.SDL_INIT_VIDEO | C.SDL_INIT_HAPTIC | C.SDL_INIT_GAMECONTROLLER) != 0 {
		C.SDL_Log(c'Unable to initialize SDL: %s', C.SDL_GetError())
	}

	v.win.create(config)
	v.g.setup()

	input.set_window_scale(v.win.get_scale())

	if config.imgui { imgui_init(v.win.sdl_window, v.win.gl_context, config.imgui_viewports, config.imgui_docking, config.imgui_gfx_debug) }
	v.g.init_defaults()

	ctx.initialize(v)

	for !v.poll_events() {
		if config.imgui { imgui_new_frame(v.win.sdl_window, config.imgui_gfx_debug) }

		ctx.update(v)
		ctx.draw(v)

		if config.imgui { imgui_render(v.win.sdl_window, v.win.gl_context) }
		v.win.swap()
		time.tick()
	}

	if config.imgui { imgui_shutdown() }
	C.SDL_VideoQuit()

	v.free()
}

fn (v &Via) poll_events() bool {
	input.new_frame()

	ev := SDL_Event{}
	for 0 < C.SDL_PollEvent(&ev) {
		// ignore events imgui eats
		if v.imgui && imgui_handle_event(&ev) { continue }

		match ev.@type {
			.quit {
				return true
			}
			.windowevent {
				if ev.window.windowID == v.win.id && ev.window.event == C.SDL_WINDOWEVENT_CLOSE {
					return true
				}
			}
			.render_targets_reset { println('render_targets_reset') }
			else {
				// defer all other events to input to handle
				input.handle_event(&ev)
			}
		}
	}

	return false
}
