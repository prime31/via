module input
import via.libs.sdl2

struct Input {
mut:
	keys [243]byte
	dirty_keys []sdl2.Scancode
	mouse_buttons [3]byte
	dirty_mouse_buttons []byte
	mouse_wheel_y int
	mouse_rel_x int
	mouse_rel_y int
}

pub enum MouseButton {
	left = 1
	middle = 2
	right = 3
}

const (
	input = &Input{}
	released = 1 // true only the frame the key is released
	down = 2 // true the entire time the key is down
	pressed = 3 // only true if down this frame and not down the previous frame
)

pub fn free() {
	unsafe {
		input.dirty_keys.free()
		free(input)
	}
}

//#region internal event handling

// clears any released keys
pub fn new_frame() {
	mut i := input

	if input.dirty_keys.len > 0 {
		for k in i.dirty_keys {
			i.keys[k]--
		}
		i.dirty_keys.clear()
	}

	if input.dirty_mouse_buttons.len > 0 {
		for b in i.dirty_mouse_buttons {
			i.mouse_buttons[b]--
		}
		i.dirty_mouse_buttons.clear()
	}

	i.mouse_wheel_y = 0
	i.mouse_rel_x = 0
	i.mouse_rel_y = 0
}

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
			i.mouse_rel_x = evt.motion.xrel
			i.mouse_rel_y = evt.motion.yrel
		}
		.mousebuttondown { i.handle_mouse_event(evt.button) }
		.mousebuttonup { i.handle_mouse_event(evt.button) }
		.mousewheel { i.mouse_wheel_y = evt.wheel.y	}
		.controlleraxismotion {
			// evt.caxis
		}
		.controllerbuttondown {
			// evt.cbutton
			println('controllerbuttondown')
		}
		.controllerbuttonup {
			// evt.cbutton
			println('controllerbuttonup')
		}
		.controllerdeviceadded {
			// evt.cdevice
			println('controllerdeviceadded')
		}
		.controllerdeviceremoved {
			// evt.cdevice
			println('controllerdeviceremoved')
		}
		.controllerdeviceremapped {
			// evt.cdevice
			println('controllerdeviceremapped')
		}
		else {}
	}
}

fn (i mut Input) handle_keyboard_event(evt &C.SDL_KeyboardEvent) {
	if evt.state == 0 {
		i.keys[evt.keysym.scancode] = released
		i.dirty_keys << evt.keysym.scancode
	} else {
		i.keys[evt.keysym.scancode] = pressed
		i.dirty_keys << evt.keysym.scancode
	}

	key := tos2(C.SDL_GetScancodeName(evt.keysym.scancode))
	println('kbd evt. key: $key, state: $evt.state, scancode: $evt.keysym.scancode, mod: $evt.keysym.mod')
}

fn (i mut Input) handle_mouse_event(evt &C.SDL_MouseButtonEvent) {
	if evt.state == 0 {
		i.mouse_buttons[evt.button] = released
		i.dirty_mouse_buttons << evt.button
	} else {
		i.mouse_buttons[evt.button] = pressed
		i.dirty_mouse_buttons << evt.button
	}

	// println('$evt.str()')
}

//#endregion

//#region input data

// only true if down this frame and not down the previous frame
pub fn is_key_pressed(scancode sdl2.Scancode) bool {
	return input.keys[scancode] == 3
}

// true the entire time the key is down
pub fn is_key_down(scancode sdl2.Scancode) bool {
	return input.keys[scancode] > 1
}

// true only the frame the key is released
pub fn is_key_released(scancode sdl2.Scancode) bool {
	return input.keys[scancode] == 1
}

pub fn is_mouse_pressed(button MouseButton) bool {
	return input.mouse_buttons[button] == 3
}

pub fn is_mouse_down(button MouseButton) bool {
	return input.mouse_buttons[button] > 1
}

pub fn is_mouse_released(button MouseButton) bool {
	return input.mouse_buttons[button] == 1
}

pub fn mouse_wheel() f32 {
	return input.mouse_wheel_y
}

pub fn mouse_pos() (int, int) {
	x := 0
	y := 0
	C.SDL_GetMouseState(&x, &y)
	return x, y
}

// gets the scaled mouse position based on the currently bound render texture scale and offset
// as calcuated in OffscreenPass. offset_n is the calcualted x, y value.
pub fn mouse_pos_scaled(scale, offset_x, offset_y int) (int, int) {
	mut x, y := mouse_pos()
	return (x - offset_x) * scale, (y - offset_y) * scale
}

pub fn mouse_rel_motion() (int, int) {
	return input.mouse_rel_x, input.mouse_rel_y
}

//#endregion