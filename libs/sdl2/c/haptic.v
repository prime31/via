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
	direction C.SDL_HapticDirection
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
	direction C.SDL_HapticDirection
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
	direction C.SDL_HapticDirection
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
	direction C.SDL_HapticDirection
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
	direction C.SDL_HapticDirection
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
	constant C.SDL_HapticConstant
	periodic C.SDL_HapticPeriodic
	condition C.SDL_HapticCondition
	ramp C.SDL_HapticRamp
	leftright C.SDL_HapticLeftRight
	custom C.SDL_HapticCustom
}

fn C.SDL_NumHaptics() int
fn C.SDL_HapticName(device_index int) byteptr
fn C.SDL_HapticOpen(device_index int) &C.SDL_Haptic
fn C.SDL_HapticOpened(device_index int) int
fn C.SDL_HapticIndex(haptic &C.SDL_Haptic) int
fn C.SDL_MouseIsHaptic() int
fn C.SDL_HapticOpenFromMouse() &C.SDL_Haptic
fn C.SDL_JoystickIsHaptic(joystick &C.SDL_Joystick) int
fn C.SDL_HapticOpenFromJoystick(joystick &C.SDL_Joystick) &C.SDL_Haptic
fn C.SDL_HapticClose(haptic &C.SDL_Haptic)
fn C.SDL_HapticNumEffects(haptic &C.SDL_Haptic) int
fn C.SDL_HapticNumEffectsPlaying(haptic &C.SDL_Haptic) int
fn C.SDL_HapticQuery(haptic &C.SDL_Haptic) u32
fn C.SDL_HapticNumAxes(haptic &C.SDL_Haptic) int
fn C.SDL_HapticEffectSupported(haptic &C.SDL_Haptic, effect &C.SDL_HapticEffect) int
fn C.SDL_HapticNewEffect(haptic &C.SDL_Haptic, effect &C.SDL_HapticEffect) int
fn C.SDL_HapticUpdateEffect(haptic &C.SDL_Haptic, effect int, data &C.SDL_HapticEffect) int
fn C.SDL_HapticRunEffect(haptic &C.SDL_Haptic, effect int, iterations u32) int
fn C.SDL_HapticStopEffect(haptic &C.SDL_Haptic, effect int) int
fn C.SDL_HapticDestroyEffect(haptic &C.SDL_Haptic, effect int)
fn C.SDL_HapticGetEffectStatus(haptic &C.SDL_Haptic, effect int) int
fn C.SDL_HapticSetGain(haptic &C.SDL_Haptic, gain int) int
fn C.SDL_HapticSetAutocenter(haptic &C.SDL_Haptic, autocenter int) int
fn C.SDL_HapticPause(haptic &C.SDL_Haptic) int
fn C.SDL_HapticUnpause(haptic &C.SDL_Haptic) int
fn C.SDL_HapticStopAll(haptic &C.SDL_Haptic) int
fn C.SDL_HapticRumbleSupported(haptic &C.SDL_Haptic) int
fn C.SDL_HapticRumbleInit(haptic &C.SDL_Haptic) int
fn C.SDL_HapticRumblePlay(haptic &C.SDL_Haptic, strength f32, length u32) int
fn C.SDL_HapticRumbleStop(haptic &C.SDL_Haptic) int
