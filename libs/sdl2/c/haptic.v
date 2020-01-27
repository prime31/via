module c

pub struct C.SDL_Haptic {
}

pub struct C.SDL_HapticDirection {
pub:
	@type byte
	dir [3]int
}

pub struct C.SDL_HapticConstant {
pub:
	@type u16
	direction SDL_HapticDirection
	length u32
	delay u16
	button u16
	interval u16
	level i16
	attack_length u16
	attack_level u16
	fade_length u16
	fade_level u16
}

pub struct C.SDL_HapticPeriodic {
pub:
	@type u16
	direction SDL_HapticDirection
	length u32
	delay u16
	button u16
	interval u16
	period u16
	magnitude i16
	offset i16
	phase u16
	attack_length u16
	attack_level u16
	fade_length u16
	fade_level u16
}

pub struct C.SDL_HapticCondition {
pub:
	@type u16
	direction SDL_HapticDirection
	length u32
	delay u16
	button u16
	interval u16
	right_sat [3]u16
	left_sat [3]u16
	right_coeff [3]i16
	left_coeff [3]i16
	deadband [3]u16
	center [3]i16
}

pub struct C.SDL_HapticRamp {
pub:
	@type u16
	direction SDL_HapticDirection
	length u32
	delay u16
	button u16
	interval u16
	start i16
	end i16
	attack_length u16
	attack_level u16
	fade_length u16
	fade_level u16
}

pub struct C.SDL_HapticLeftRight {
pub:
	@type u16
	length u32
	large_magnitude u16
	small_magnitude u16
}

pub struct C.SDL_HapticCustom {
pub:
	@type u16
	direction SDL_HapticDirection
	length u32
	delay u16
	button u16
	interval u16
	channels byte
	period u16
	samples u16
	data &u16
	attack_length u16
	attack_level u16
	fade_length u16
	fade_level u16
}

pub struct C.SDL_HapticEffect {
pub:
	@type u16
	constant SDL_HapticConstant
	periodic SDL_HapticPeriodic
	condition SDL_HapticCondition
	ramp SDL_HapticRamp
	leftright SDL_HapticLeftRight
	custom SDL_HapticCustom
}

fn C.SDL_NumHaptics() int
fn C.SDL_HapticName(device_index int) byteptr
fn C.SDL_HapticOpen(device_index int) &SDL_Haptic
fn C.SDL_HapticOpened(device_index int) int
fn C.SDL_HapticIndex(haptic &SDL_Haptic) int
fn C.SDL_MouseIsHaptic() int
fn C.SDL_HapticOpenFromMouse() &SDL_Haptic
fn C.SDL_JoystickIsHaptic(joystick &SDL_Joystick) int
fn C.SDL_HapticOpenFromJoystick(joystick &SDL_Joystick) &SDL_Haptic
fn C.SDL_HapticClose(haptic &SDL_Haptic)
fn C.SDL_HapticNumEffects(haptic &SDL_Haptic) int
fn C.SDL_HapticNumEffectsPlaying(haptic &SDL_Haptic) int
fn C.SDL_HapticQuery(haptic &SDL_Haptic) u32
fn C.SDL_HapticNumAxes(haptic &SDL_Haptic) int
fn C.SDL_HapticEffectSupported(haptic &SDL_Haptic, effect &SDL_HapticEffect) int
fn C.SDL_HapticNewEffect(haptic &SDL_Haptic, effect &SDL_HapticEffect) int
fn C.SDL_HapticUpdateEffect(haptic &SDL_Haptic, effect int, data &SDL_HapticEffect) int
fn C.SDL_HapticRunEffect(haptic &SDL_Haptic, effect int, iterations u32) int
fn C.SDL_HapticStopEffect(haptic &SDL_Haptic, effect int) int
fn C.SDL_HapticDestroyEffect(haptic &SDL_Haptic, effect int)
fn C.SDL_HapticGetEffectStatus(haptic &SDL_Haptic, effect int) int
fn C.SDL_HapticSetGain(haptic &SDL_Haptic, gain int) int
fn C.SDL_HapticSetAutocenter(haptic &SDL_Haptic, autocenter int) int
fn C.SDL_HapticPause(haptic &SDL_Haptic) int
fn C.SDL_HapticUnpause(haptic &SDL_Haptic) int
fn C.SDL_HapticStopAll(haptic &SDL_Haptic) int
fn C.SDL_HapticRumbleSupported(haptic &SDL_Haptic) int
fn C.SDL_HapticRumbleInit(haptic &SDL_Haptic) int
fn C.SDL_HapticRumblePlay(haptic &SDL_Haptic, strength f32, length u32) int
fn C.SDL_HapticRumbleStop(haptic &SDL_Haptic) int
