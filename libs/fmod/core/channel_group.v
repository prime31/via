module core

pub struct ChannelGroup {
pub:
	group &C.FMOD_CHANNELGROUP
}

pub fn (cg &ChannelGroup) add_dsp(index int, dsp Dsp) int {
	return C.FMOD_ChannelGroup_AddDSP(cg.group, index, dsp.dsp)
}

pub fn (cg &ChannelGroup) remove_dsp(dsp Dsp) int {
	return C.FMOD_ChannelGroup_RemoveDSP(cg.group, dsp.dsp)
}