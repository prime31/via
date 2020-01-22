module via
import via.libs.sokol
import via.libs.sokol.gfx
import via.libs.sdl2

pub struct Via {
pub mut:
	audio &Audio
	fs &FileSystem
	g &Graphics
	clock &Clock
	win &Window
	input &Input
	imgui bool
}

pub const (
	v = &Via{
		audio: 0
		fs: 0
		g: 0
		clock: 0
		win: 0
		input: 0
	}
)

fn create_via(config &ViaConfig) &Via {
	fs := new_filesystem(config)

	// via := &Via {
	// 	audio: new_audio(config, fs)
	// 	fs: fs
	// 	g: new_graphics(config, fs)
	// 	clock: new_clock(config)
	// 	win: new_window(config)
	// 	input: new_input(config)
	// 	imgui: config.imgui_enabled
	// }

	mut vv := v
	vv.audio = new_audio(config)
	vv.fs = fs
	vv.g = new_graphics(config)
	vv.clock = new_clock(config)
	vv.win = new_window(config)
	vv.input = new_input(config)
	vv.imgui = config.imgui_enabled

	return vv
}

fn (v &Via) free() {
	v.audio.free()
	v.fs.free()
	v.g.free()
	v.clock.free()
	v.win.free()

	sg_shutdown()

	unsafe { free(v) }
}

pub fn run<T>(config &ViaConfig, ctx mut T) {
	mut v := create_via(config)
	C.SDL_Init(C.SDL_INIT_VIDEO)
	v.win.create(config)
	v.g.init_defaults()

	if v.imgui { imgui_init(v.win.sdl_window, v.win.gl_context, config.imgui_viewports_enabled, config.imgui_docking_enabled) }

	ctx.initialize(v)

	for !v.poll_events() {
		if v.imgui { imgui_new_frame(v.win.sdl_window) }

		ctx.update(v)
		ctx.draw(v)

		if v.imgui { imgui_render(v.win.sdl_window, v.win.gl_context) }
		v.win.swap()
		v.clock.tick()
	}

	if v.imgui { imgui_shutdown() }
	C.SDL_VideoQuit()

	v.free()
}

fn (v mut Via) poll_events() bool {
	ev := SDL_Event{}
	for 0 < C.SDL_PollEvent(&ev) {
		match int(ev.@type) {
			C.SDL_QUIT {
				return true
			}
			C.SDL_WINDOWEVENT {
				if ev.window.windowID == v.win.id && ev.window.event == C.SDL_WINDOWEVENT_CLOSE {
					return true
				}
			}
			else {}
		}
	}

	return false
}
