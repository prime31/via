module via
import via.time
import via.debug
import via.input
import via.audio
import via.window
import via.graphics
import via.filesystem
import via.libs.flextgl
import via.libs.sokol
import via.libs.sokol.gfx
import via.libs.sdl2

const ( used_import = gfx.used_import + sokol.used_import + sdl2.used_import + flextgl.used_import )

pub struct Via {
pub mut:
	imgui bool
}


fn create_via(config &ViaConfig) &Via {
	filesystem.init_filesystem(config.identity, config.append_identity)
	audio.create()

	mut via := &Via {
		imgui: config.imgui
	}

	// disable imgui for metal
	$if metal? { via.imgui = false }

	return via
}

fn (v &Via) free() {
	audio.free()
	graphics.free()
	window.free()
	filesystem.free()
	time.free()

	C.sg_shutdown()

	unsafe { C.free(v) }
}

pub fn run<T>(config &ViaConfig, mut ctx T) {
	v := create_via(config)
	if C.SDL_Init(C.SDL_INIT_VIDEO | C.SDL_INIT_HAPTIC | C.SDL_INIT_GAMECONTROLLER) != 0 {
		C.SDL_Log(c'Unable to initialize SDL: %s', C.SDL_GetError())
	}

	window.create(config.window_config())
	graphics.setup(config.graphics_config())
	debug.setup()

	input.set_window_scale(window.scale())

	if v.imgui { imgui_init(window.win.C.SDL_window, window.win.gl_context, config.imgui_viewports, config.imgui_docking, config.imgui_gfx_debug) }

	ctx.initialize()

	for !v.poll_events() {
		time.tick()
		if v.imgui { imgui_new_frame(window.win.C.SDL_window, config.imgui_gfx_debug) }

		ctx.update()
		ctx.draw()
		graphics.commit()

		if v.imgui { imgui_render(window.win.C.SDL_window, window.win.gl_context) }
		window.swap()
	}

	if v.imgui { imgui_shutdown() }
	C.SDL_VideoQuit()

	v.free()
}

fn (v &Via) poll_events() bool {
	input.new_frame()

	ev := C.SDL_Event{}
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
