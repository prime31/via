module core

pub struct Channel {
pub:
	ch &C.FMOD_CHANNEL
}

pub fn (c &Channel) set_pitch(pitch f32) int {
	return C.FMOD_Channel_SetPitch(c.ch, pitch)
}

pub fn (c &Channel) set_volume(volume f32) int {
	return C.FMOD_Channel_SetVolume(c.ch, volume)
}

pub fn (c &Channel) add_dsp(index int, dsp Dsp) int {
	return C.FMOD_Channel_AddDSP(c.ch, index, dsp.dsp)
}

pub fn (c &Channel) remove_dsp(dsp Dsp) int {
	return C.FMOD_Channel_RemoveDSP(c.ch, dsp.dsp)
}

pub fn (c &Channel) set_user_data(userdata voidptr) int {
	return C.FMOD_Channel_SetUserData(c.ch, userdata)
}

pub fn (c &Channel) get_user_data(userdata voidptr) int {
	return C.FMOD_Channel_GetUserData(c.ch, userdata)
}

pub fn (c &Channel) stop() int {
	return C.FMOD_Channel_Stop(c.ch)
}

pub fn (c &Channel) set_paused(paused int) int {
	return C.FMOD_Channel_SetPaused(c.ch, paused)
}

pub fn (c &Channel) get_paused(paused &int) int {
	return C.FMOD_Channel_GetPaused(c.ch, paused)
}