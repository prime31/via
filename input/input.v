module input
import via.time
import via.math
import via.graphics
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
	window_scale int = 1
	res_scaler &graphics.ResolutionScaler
}

pub enum MouseButton {
	left = 1
	middle = 2
	right = 3
}

const (
	ginput = &Input{
		res_scaler: 0
	}
	released = 1 // true only the frame the key is released
	down = 2 // true the entire time the key is down
	pressed = 3 // only true if down this frame and not down the previous frame
)

pub fn free() {
	unsafe {
		ginput.dirty_keys.free()
		C.free(ginput)
	}
}

//#region internal event handling

// used for scaling mouse input. On macos, mouse position is in points but we always render in pixels.
// scale should be drawable_size / window_size
pub fn set_window_scale(scale f32) {
	mut i := ginput
	i.window_scale = int(scale)

	// TODO: this is a bit of a cheat, but we know that graphics is all set here so we fetch the scaler
	i.res_scaler = graphics.get_resolution_scaler()
}

// clears any released keys
pub fn new_frame() {
	mut i := ginput

	if ginput.dirty_keys.len > 0 {
		for k in i.dirty_keys {
			i.keys[k]--
		}
		i.dirty_keys.clear()
	}

	if ginput.dirty_mouse_buttons.len > 0 {
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
	mut i := ginput

	match evt.@type {
		.keydown, .keyup { i.handle_keyboard_event(evt.key) }
		.mousemotion {
			i.mouse_rel_x = evt.motion.xrel
			i.mouse_rel_y = evt.motion.yrel
		}
		.mousebuttondown, .mousebuttonup { i.handle_mouse_event(evt.button) }
		.mousewheel { i.mouse_wheel_y = evt.wheel.y	}
		.controlleraxismotion {
			// evt.caxis
			println('controlleraxismotion')
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

fn (mut i Input) handle_keyboard_event(evt &C.SDL_KeyboardEvent) {
	if evt.state == 0 {
		i.keys[evt.keysym.scancode] = released
		i.dirty_keys << evt.keysym.scancode
	} else {
		i.keys[evt.keysym.scancode] = pressed
		i.dirty_keys << evt.keysym.scancode
	}

	//key := tos2(C.SDL_GetScancodeName(evt.keysym.scancode))
	//println('kbd evt [${time.frames()}]. TING: ${i.keys[evt.keysym.scancode]} key: $key, state: $evt.state, scancode: $evt.keysym.scancode, mod: $evt.keysym.mod')
}

fn (mut i Input) handle_mouse_event(evt &C.SDL_MouseButtonEvent) {
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
pub fn key_pressed(scancode sdl2.Scancode) bool {
	return ginput.keys[scancode] == 3
}

// true the entire time the key is down
pub fn key_down(scancode sdl2.Scancode) bool {
	return ginput.keys[scancode] > 1
}

// true only the frame the key is released
pub fn key_up(scancode sdl2.Scancode) bool {
	return ginput.keys[scancode] == 1
}

pub fn mouse_pressed(button MouseButton) bool {
	return ginput.mouse_buttons[button] == 3
}

// true the entire time the button is down
pub fn mouse_down(button MouseButton) bool {
	return ginput.mouse_buttons[button] > 1
}

pub fn mouse_up(button MouseButton) bool {
	return ginput.mouse_buttons[button] == 1
}

pub fn mouse_wheel() f32 {
	return ginput.mouse_wheel_y
}

pub fn mouse_pos() (int, int) {
	x := 0
	y := 0
	C.SDL_GetMouseState(&x, &y)
	return x * ginput.window_scale, y * ginput.window_scale
}

// gets the scaled mouse position based on the currently bound render texture scale and offset
// as calcuated in OffscreenPass. scale should be scale and offset_n is the calculated x, y value.
pub fn mouse_pos_scaled() (int, int) {
	x, y := mouse_pos()
	xf := f32(x) - ginput.res_scaler.x
	yf := f32(y) - ginput.res_scaler.y
	return int(xf / ginput.res_scaler.scale), int(yf / ginput.res_scaler.scale)
}

pub fn mouse_pos_scaledv() math.Vec2 {
	x, y := mouse_pos_scaled()
	return math.Vec2{x, y}
}

pub fn mouse_rel_motion() (int, int) {
	return ginput.mouse_rel_x, ginput.mouse_rel_y
}

//#endregion