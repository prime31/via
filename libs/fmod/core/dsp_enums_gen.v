module core

pub enum DspType {
	unknown
	mixer
	oscillator
	lowpass
	itlowpass
	highpass
	echo
	fader
	flange
	distortion
	normalize
	limiter
	parameq
	pitchshift
	chorus
	vstplugin
	winampplugin
	itecho
	compressor
	sfxreverb
	lowpass_simple
	delay
	tremolo
	ladspaplugin
	send
	returned
	highpass_simple
	pan
	three_eq
	fft
	loudness_meter
	envelopefollower
	convolutionreverb
	channelmix
	transceiver
	objectpan
	multiband_eq
	max
}

pub enum DspOscillator {
	typ
	rate
}

pub enum DspLowpass {
	cutoff
	resonance
}

pub enum DspItlowpass {
	cutoff
	resonance
}

pub enum DspHighpass {
	cutoff
	resonance
}

pub enum DspEcho {
	delay
	feedback
	drylevel
	wetlevel
}

pub enum DspFader {
	gain
	overall_gain
}

pub enum DspFlange {
	mix
	depth
	rate
}

pub enum DspDistortion {
	level
}

pub enum DspNormalize {
	fadetime
	threshhold
	maxamp
}

pub enum DspLimiter {
	releasetime
	ceiling
	maximizergain
	mode
}

pub enum DspParameq {
	center
	bandwidth
	gain
}

pub enum DspMultibandEq {
	a_filter
	a_frequency
	a_q
	a_gain
	b_filter
	b_frequency
	b_q
	b_gain
	c_filter
	c_frequency
	c_q
	c_gain
	d_filter
	d_frequency
	d_q
	d_gain
	e_filter
	e_frequency
	e_q
	e_gain
}

pub enum DspMultibandEqFilterType {
	fmod_dsp_multiband_eq_filter_disabled
	fmod_dsp_multiband_eq_filter_lowpass_12db
	fmod_dsp_multiband_eq_filter_lowpass_24db
	fmod_dsp_multiband_eq_filter_lowpass_48db
	fmod_dsp_multiband_eq_filter_highpass_12db
	fmod_dsp_multiband_eq_filter_highpass_24db
	fmod_dsp_multiband_eq_filter_highpass_48db
	fmod_dsp_multiband_eq_filter_lowshelf
	fmod_dsp_multiband_eq_filter_highshelf
	fmod_dsp_multiband_eq_filter_peaking
	fmod_dsp_multiband_eq_filter_bandpass
	fmod_dsp_multiband_eq_filter_notch
	fmod_dsp_multiband_eq_filter_allpass
}

pub enum DspPitchshift {
	pitch
	fftsize
	overlap
	maxchannels
}

pub enum DspChorus {
	mix
	rate
	depth
}

pub enum DspItecho {
	wetdrymix
	feedback
	leftdelay
	rightdelay
	pandelay
}

pub enum DspCompressor {
	threshold
	ratio
	attack
	release
	gainmakeup
	usesidechain
	linked
}

pub enum DspSfxReverb {
	decaytime
	earlydelay
	latedelay
	hfreference
	hfdecayratio
	diffusion
	density
	lowshelffrequency
	lowshelfgain
	highcut
	earlylatemix
	wetlevel
	drylevel
}

pub enum DspLowpassSimple {
	cutoff
}

pub enum DspDelay {
	ch0
	ch1
	ch2
	ch3
	ch4
	ch5
	ch6
	ch7
	ch8
	ch9
	ch10
	ch11
	ch12
	ch13
	ch14
	ch15
	maxdelay
}

pub enum DspTremolo {
	frequency
	depth
	shape
	skew
	duty
	square
	phase
	spread
}

pub enum DspSend {
	returnid
	level
}

pub enum DspReturn {
	id
	input_speaker_mode
}

pub enum DspHighpassSimple {
	cutoff
}

pub enum DspPan2dStereoModeType {
	fmod_dsp_pan_2d_stereo_mode_distributed
	fmod_dsp_pan_2d_stereo_mode_discrete
}

pub enum DspPanModeType {
	fmod_dsp_pan_mode_mono
	fmod_dsp_pan_mode_stereo
	fmod_dsp_pan_mode_surround
}

pub enum DspPan3dRolloffType {
	fmod_dsp_pan_3d_rolloff_linearsquared
	fmod_dsp_pan_3d_rolloff_linear
	fmod_dsp_pan_3d_rolloff_inverse
	fmod_dsp_pan_3d_rolloff_inversetapered
	fmod_dsp_pan_3d_rolloff_custom
}

pub enum DspPan3dExtentModeType {
	fmod_dsp_pan_3d_extent_mode_auto
	fmod_dsp_pan_3d_extent_mode_user
	fmod_dsp_pan_3d_extent_mode_off
}

pub enum DspPan {
	mode
	_2d_stereo_position
	_2d_direction
	_2d_extent
	_2d_rotation
	_2d_lfe_level
	_2d_stereo_mode
	_2d_stereo_separation
	_2d_stereo_axis
	enabled_speakers
	_3d_position
	_3d_rolloff
	_3d_min_distance
	_3d_max_distance
	_3d_extent_mode
	_3d_sound_size
	_3d_min_extent
	_3d_pan_blend
	lfe_upmix_enabled
	overall_gain
	surround_speaker_mode
	_2d_height_blend
}

pub enum DspThreeEqCrossoverslopeType {
	fmod_dsp_three_eq_crossoverslope_12db
	fmod_dsp_three_eq_crossoverslope_24db
	fmod_dsp_three_eq_crossoverslope_48db
}

pub enum DspThreeEq {
	lowgain
	midgain
	highgain
	lowcrossover
	highcrossover
	crossoverslope
}

pub enum DspFftWindow {
	rect
	triangle
	hamming
	hanning
	blackman
	blackmanharris
}

pub enum DspFft {
	windowsize
	windowtype
	spectrumdata
	dominant_freq
}

pub enum DspEnvelopefollower {
	attack
	release
	envelope
	usesidechain
}

pub enum DspConvolutionReverb {
	param_ir
	param_wet
	param_dry
	param_linked
}

pub enum DspChannelmixOutput {
	default
	allmono
	allstereo
	allquad
	all5point1
	all7point1
	alllfe
	all7point1point4
}

pub enum DspChannelmix {
	outputgrouping
	gain_ch0
	gain_ch1
	gain_ch2
	gain_ch3
	gain_ch4
	gain_ch5
	gain_ch6
	gain_ch7
	gain_ch8
	gain_ch9
	gain_ch10
	gain_ch11
	gain_ch12
	gain_ch13
	gain_ch14
	gain_ch15
	gain_ch16
	gain_ch17
	gain_ch18
	gain_ch19
	gain_ch20
	gain_ch21
	gain_ch22
	gain_ch23
	gain_ch24
	gain_ch25
	gain_ch26
	gain_ch27
	gain_ch28
	gain_ch29
	gain_ch30
	gain_ch31
	output_ch0
	output_ch1
	output_ch2
	output_ch3
	output_ch4
	output_ch5
	output_ch6
	output_ch7
	output_ch8
	output_ch9
	output_ch10
	output_ch11
	output_ch12
	output_ch13
	output_ch14
	output_ch15
	output_ch16
	output_ch17
	output_ch18
	output_ch19
	output_ch20
	output_ch21
	output_ch22
	output_ch23
	output_ch24
	output_ch25
	output_ch26
	output_ch27
	output_ch28
	output_ch29
	output_ch30
	output_ch31
}

pub enum DspTransceiver {
	transmit
	gain
	channel
	transmitspeakermode
}

pub enum DspObjectpan {
	_3d_position
	_3d_rolloff
	_3d_min_distance
	_3d_max_distance
	_3d_extent_mode
	_3d_sound_size
	_3d_min_extent
	overall_gain
	outputgain
}

