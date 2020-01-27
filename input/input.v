module input
import via.libs.sdl2

struct Input {
mut:
	dummy u32
}

const (
	input = &Input{}
)

pub fn free() {
	unsafe { free(input) }
}

//#region internal event handling

pub fn handle_event(evt &C.SDL_Event) {
	mut i := input

	match evt.@type {
		.keydown {
			i.handle_keyboard_event(evt.key)
		}
		.keyup {
			i.handle_keyboard_event(evt.key)
		}
		.mousemotion {
			// evt.motion
		}
		.mousebuttondown {
			// evt.button
		}
		.mousebuttonup {
			// evt.button
		}
		.mousewheel {
			// evt.wheel
		}
		.controlleraxismotion {
			// evt.caxis
		}
		.controllerbuttondown {
			// evt.cbutton
		}
		.controllerbuttonup {
			// evt.cbutton
		}
		.controllerdeviceadded {
			// evt.cdevice
		}
		.controllerdeviceremoved {
			// evt.cdevice
		}
		.controllerdeviceremapped {
			// evt.cdevice
		}
		else {}
	}
}

fn (i mut Input) handle_keyboard_event(evt &C.SDL_KeyboardEvent) {
	key := tos2(C.SDL_GetScancodeName(evt.keysym.scancode))
	println('kbd evt state: $key, $evt.state, $evt.keysym.scancode, $evt.keysym.mod')
	if evt.state == 0 && evt.keysym.scancode == .i {
		SDL_ShowSimpleMessageBox(16, c'Poop on me', c'you released "i" fool', C.SDL_GetWindowFromID(evt.windowID))
	}
	i.dummy++
}

//#endregion

//#region input data



//#endregion