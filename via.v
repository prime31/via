module via
import via.time
import via.input
import via.debug
import via.audio
import via.window
import via.filesystem
import via.libs.flextgl
import via.libs.sokol
import via.libs.sokol.gfx
import via.libs.sdl2

pub struct Via {
pub mut:
	g &Graphics
	imgui bool
}


fn create_via(config &ViaConfig) &Via {
	filesystem.init_filesystem(config.identity, config.append_identity)
	audio.create()

	mut via := &Via {
		g: graphics(config)
		imgui: config.imgui
	}

	// disable imgui for metal
	$if metal? { via.imgui = false }

	return via
}

fn (v &Via) free() {
	audio.free()
	v.g.free()
	window.free()
	filesystem.free()
	time.free()

	sg_shutdown()

	unsafe { free(v) }
}

pub fn run<T>(config &ViaConfig, ctx mut T) {
	mut v := create_via(config)
	if C.SDL_Init(C.SDL_INIT_VIDEO | C.SDL_INIT_HAPTIC | C.SDL_INIT_GAMECONTROLLER) != 0 {
		C.SDL_Log(c'Unable to initialize SDL: %s', C.SDL_GetError())
	}

	window.create(config.get_win_config())
	v.g.setup()
	debug.setup()

	input.set_window_scale(window.scale())

	if v.imgui { imgui_init(window.win.sdl_window, window.win.gl_context, config.imgui_viewports, config.imgui_docking, config.imgui_gfx_debug) }
	v.g.init_defaults()

	ctx.initialize(v)

	for !v.poll_events() {
		time.tick()
		if v.imgui { imgui_new_frame(window.win.sdl_window, config.imgui_gfx_debug) }

		w, h := window.drawable_size()
		debug.begin(w, h)
		ctx.update(mut v)
		ctx.draw(mut v)
		sg_commit()

		if v.imgui { imgui_render(window.win.sdl_window, window.win.gl_context) }
		window.swap()
	}

	if v.imgui { imgui_shutdown() }
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
				if ev.window.windowID == window.win.id {
					if ev.window.event == C.SDL_WINDOWEVENT_CLOSE { return true }
					window.handle_event(&ev)
				}
			}
			.render_targets_reset { println('render_targets_reset') }
			.render_device_reset { println('render_device_reset') }
			else {
				// defer all other events to input to handle
				input.handle_event(&ev)
			}
		}
	}

	return false
}
