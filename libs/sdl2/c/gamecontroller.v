module c

pub enum GameControllerBindType {
	non = 0
	button = 1
	axis = 2
	hat = 3
}

pub enum GameControllerAxis {
	invalid = -1
	leftx = 0
	lefty = 1
	rightx = 2
	righty = 3
	triggerleft = 4
	triggerright = 5
	max = 6
}

pub enum GameControllerButton {
	invalid = -1
	a = 0
	b = 1
	x = 2
	y = 3
	back = 4
	guide = 5
	start = 6
	leftstick = 7
	rightstick = 8
	leftshoulder = 9
	rightshoulder = 10
	dpad_up = 11
	dpad_down = 12
	dpad_left = 13
	dpad_right = 14
	max = 15
}

pub struct C.SDL_GameController {}

pub struct C.SDL_GameControllerButtonBind {
pub:
	bindType GameControllerBindType
	value voidptr
}

fn C.SDL_GameControllerAddMappingsFromRW(rw &SDL_RWops, freerw int) int
fn C.SDL_GameControllerAddMapping(mappingString byteptr) int
fn C.SDL_GameControllerNumMappings() int
fn C.SDL_GameControllerMappingForIndex(mapping_index int) byteptr
fn C.SDL_GameControllerMappingForGUID(guid SDL_JoystickGUID) byteptr
fn C.SDL_GameControllerMapping(gamecontroller &SDL_GameController) byteptr
fn C.SDL_IsGameController(joystick_index int) Bool
fn C.SDL_GameControllerNameForIndex(joystick_index int) byteptr
fn C.SDL_GameControllerMappingForDeviceIndex(joystick_index int) byteptr
fn C.SDL_GameControllerOpen(joystick_index int) &SDL_GameController
fn C.SDL_GameControllerFromInstanceID(joyid int) &SDL_GameController
fn C.SDL_GameControllerName(gamecontroller &SDL_GameController) byteptr
fn C.SDL_GameControllerGetPlayerIndex(gamecontroller &SDL_GameController) int
fn C.SDL_GameControllerGetVendor(gamecontroller &SDL_GameController) u16
fn C.SDL_GameControllerGetProduct(gamecontroller &SDL_GameController) u16
fn C.SDL_GameControllerGetProductVersion(gamecontroller &SDL_GameController) u16
fn C.SDL_GameControllerGetAttached(gamecontroller &SDL_GameController) Bool
fn C.SDL_GameControllerGetJoystick(gamecontroller &SDL_GameController) &SDL_Joystick
fn C.SDL_GameControllerEventState(state int) int
fn C.SDL_GameControllerUpdate()
fn C.SDL_GameControllerGetAxisFromString(pchString byteptr) GameControllerAxis
fn C.SDL_GameControllerGetStringForAxis(axis GameControllerAxis) byteptr
fn C.SDL_GameControllerGetBindForAxis(gamecontroller &SDL_GameController, axis GameControllerAxis) SDL_GameControllerButtonBind
fn C.SDL_GameControllerGetAxis(gamecontroller &SDL_GameController, axis GameControllerAxis) i16
fn C.SDL_GameControllerGetButtonFromString(pchString byteptr) GameControllerButton
fn C.SDL_GameControllerGetStringForButton(button GameControllerButton) byteptr
fn C.SDL_GameControllerGetBindForButton(gamecontroller &SDL_GameController, button GameControllerButton) SDL_GameControllerButtonBind
fn C.SDL_GameControllerGetButton(gamecontroller &SDL_GameController, button GameControllerButton) byte
fn C.SDL_GameControllerRumble(gamecontroller &SDL_GameController, low_frequency_rumble u16, high_frequency_rumble u16, duration_ms u32) int
fn C.SDL_GameControllerClose(gamecontroller &SDL_GameController)