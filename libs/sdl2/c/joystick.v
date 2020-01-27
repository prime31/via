module c

pub enum JoystickType {
	unknown
	gamecontroller
	wheel
	arcade_stick
	flight_stick
	dance_pad
	guitar
	drum_kit
	arcade_pad
	throttle
}

pub enum JoystickPowerLevel {
	unknown = -1
	empty = 0
	low = 1
	medium = 2
	full = 3
	wired = 4
	max = 5
}

pub struct C.SDL_Joystick {
}

pub struct C.SDL_JoystickGUID {
pub:
	data [16]byte
}

fn C.SDL_LockJoysticks()
fn C.SDL_UnlockJoysticks()
fn C.SDL_NumJoysticks() int
fn C.SDL_JoystickNameForIndex(device_index int) byteptr
fn C.SDL_JoystickGetDevicePlayerIndex(device_index int) int
fn C.SDL_JoystickGetDeviceGUID(device_index int) SDL_JoystickGUID
fn C.SDL_JoystickGetDeviceVendor(device_index int) u16
fn C.SDL_JoystickGetDeviceProduct(device_index int) u16
fn C.SDL_JoystickGetDeviceProductVersion(device_index int) u16
fn C.SDL_JoystickGetDeviceType(device_index int) JoystickType
fn C.SDL_JoystickGetDeviceInstanceID(device_index int) int
fn C.SDL_JoystickOpen(device_index int) &SDL_Joystick
fn C.SDL_JoystickFromInstanceID(joyid int) &SDL_Joystick
fn C.SDL_JoystickName(joystick &SDL_Joystick) byteptr
fn C.SDL_JoystickGetPlayerIndex(joystick &SDL_Joystick) int
fn C.SDL_JoystickGetGUID(joystick &SDL_Joystick) SDL_JoystickGUID
fn C.SDL_JoystickGetVendor(joystick &SDL_Joystick) u16
fn C.SDL_JoystickGetProduct(joystick &SDL_Joystick) u16
fn C.SDL_JoystickGetProductVersion(joystick &SDL_Joystick) u16
fn C.SDL_JoystickGetType(joystick &SDL_Joystick) JoystickType
fn C.SDL_JoystickGetGUIDString(guid SDL_JoystickGUID, pszGUID byteptr, cbGUID int)
fn C.SDL_JoystickGetGUIDFromString(pchGUID byteptr) SDL_JoystickGUID
fn C.SDL_JoystickGetAttached(joystick &SDL_Joystick) Bool
fn C.SDL_JoystickInstanceID(joystick &SDL_Joystick) int
fn C.SDL_JoystickNumAxes(joystick &SDL_Joystick) int
fn C.SDL_JoystickNumBalls(joystick &SDL_Joystick) int
fn C.SDL_JoystickNumHats(joystick &SDL_Joystick) int
fn C.SDL_JoystickNumButtons(joystick &SDL_Joystick) int
fn C.SDL_JoystickUpdate()
fn C.SDL_JoystickEventState(state int) int
fn C.SDL_JoystickGetAxis(joystick &SDL_Joystick, axis int) i16
fn C.SDL_JoystickGetAxisInitialState(joystick &SDL_Joystick, axis int, state &i16) Bool
fn C.SDL_JoystickGetHat(joystick &SDL_Joystick, hat int) byte
fn C.SDL_JoystickGetBall(joystick &SDL_Joystick, ball int, dx &int, dy &int) int
fn C.SDL_JoystickGetButton(joystick &SDL_Joystick, button int) byte
fn C.SDL_JoystickRumble(joystick &SDL_Joystick, low_frequency_rumble u16, high_frequency_rumble u16, duration_ms u32) int
fn C.SDL_JoystickClose(joystick &SDL_Joystick)
fn C.SDL_JoystickCurrentPowerLevel(joystick &SDL_Joystick) JoystickPowerLevel