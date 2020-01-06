module core

struct Sound {
pub:
	sound &FMOD_SOUND
mut:
	sys &System
}

pub fn create_sound(s &System, name_or_data byteptr, mode int /* exinfo &FMOD_CREATESOUNDEXINFO */) (int, Sound) {
	snd := Sound{&FMOD_SOUND(0), s}
	res := FMOD_System_CreateSound(s.sys, name_or_data, mode, C.NULL, &snd.sound)
	return res, snd
}

pub fn (s &Sound) get_length(unit TimeUnit) u32 {
	len := u32(0)
	FMOD_Sound_GetLength(s.sound, &len, u32(unit))
	return len
}

pub fn (s &Sound) release() int {
	return FMOD_Sound_Release(s.sound)
}

pub fn (s &Sound) play(paused int) (int, Channel) {
	return s.sys.play_sound(s.sound, ChannelGroup{&FMOD_CHANNELGROUP(0)}, paused)
}

pub fn (s &Sound) play_in_group(channelgroup ChannelGroup, paused int) (int, Channel) {
	return s.sys.play_sound(s.sound, channelgroup, paused)
}

pub fn (s &Sound) get_open_state() (int, OpenState, u32, int, int) {
	openstate := 0
	percent_buffered := u32(0)
	starving := 0
	diskbusy := 0
	res := FMOD_Sound_GetOpenState(s.sound, &openstate, &percent_buffered, &starving, &diskbusy)
	return res, OpenState(openstate), percent_buffered, starving, diskbusy
}

pub fn (s &Sound) get_name() (int, string) {
	name := [200]byte
	res := FMOD_Sound_GetName(s.sound, &name, 200)
	return res, tos2(name)
}