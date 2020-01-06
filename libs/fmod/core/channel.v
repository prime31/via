module core

pub struct Channel {
pub:
	ch &FMOD_CHANNEL
}

pub fn (c &Channel) set_pitch(pitch f32) int {
	return FMOD_Channel_SetPitch(c.ch, pitch)
}

pub fn (c &Channel) add_dsp(index int, dsp Dsp) int {
	return FMOD_Channel_AddDSP(c.ch, index, dsp.dsp)
}

pub fn (c &Channel) remove_dsp(dsp Dsp) int {
	return FMOD_Channel_RemoveDSP(c.ch, dsp.dsp)
}