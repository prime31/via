module via
import via.libs.sokol
import via.libs.sokol.gfx
import via.libs.sdl2

pub struct Via {
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
		audio: create_audio(config, filesystem)
		filesystem: filesystem
		graphics: create_graphics(config, filesystem)
		timer: create_timer(config)
		window: create_window(config)
	}

	return via
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

pub fn run<T>(config &ViaConfig, ctx mut T) {
	mut v := create_via(config)
	C.SDL_Init(C.SDL_INIT_VIDEO)
	v.window.create(config)

	desc := sg_desc{}
	sg_setup(&desc)

	ctx.initialize(v)

	for !v.poll_events() {

		ctx.update(v)
		ctx.draw(v)

		// pass_action := gfx.create_clear_pass(1.0, 0.3, 1.0, 1.0)
		// w, h := v.window.get_drawable_size()
		// sg_begin_default_pass(&pass_action, w, h)
		// sg_end_pass()
		// sg_commit()

		v.window.swap()
	}

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
				if ev.window.windowID == v.window.id && ev.window.event == C.SDL_WINDOWEVENT_CLOSE {
					return true
				}
			}
			else {}
		}
	}

	return false
}
