module core

pub enum Result {
	ok
	err_badcommand
	err_channel_alloc
	err_channel_stolen
	err_dma
	err_dsp_connection
	err_dsp_dontprocess
	err_dsp_format
	err_dsp_inuse
	err_dsp_notfound
	err_dsp_reserved
	err_dsp_silence
	err_dsp_type
	err_file_bad
	err_file_couldnotseek
	err_file_diskejected
	err_file_eof
	err_file_endofdata
	err_file_notfound
	err_format
	err_header_mismatch
	err_http
	err_http_access
	err_http_proxy_auth
	err_http_server_error
	err_http_timeout
	err_initialization
	err_initialized
	err_internal
	err_invalid_float
	err_invalid_handle
	err_invalid_param
	err_invalid_position
	err_invalid_speaker
	err_invalid_syncpoint
	err_invalid_thread
	err_invalid_vector
	err_maxaudible
	err_memory
	err_memory_cantpoint
	err_needs3d
	err_needshardware
	err_net_connect
	err_net_socket_error
	err_net_url
	err_net_would_block
	err_notready
	err_output_allocated
	err_output_createbuffer
	err_output_drivercall
	err_output_format
	err_output_init
	err_output_nodrivers
	err_plugin
	err_plugin_missing
	err_plugin_resource
	err_plugin_version
	err_record
	err_reverb_channelgroup
	err_reverb_instance
	err_subsounds
	err_subsound_allocated
	err_subsound_cantmove
	err_tagnotfound
	err_toomanychannels
	err_truncated
	err_unimplemented
	err_uninitialized
	err_unsupported
	err_version
	err_event_already_loaded
	err_event_liveupdate_busy
	err_event_liveupdate_mismatch
	err_event_liveupdate_timeout
	err_event_notfound
	err_studio_uninitialized
	err_studio_not_loaded
	err_invalid_string
	err_already_locked
	err_not_locked
	err_record_disconnected
	err_toomanysamples
}

pub enum ChannelControlType {
	fmod_channelcontrol_channel
	fmod_channelcontrol_channelgroup
	fmod_channelcontrol_max
}

pub enum OutputType {
	autodetect
	unknown
	nosound
	wavwriter
	nosound_nrt
	wavwriter_nrt
	wasapi
	asio
	pulseaudio
	alsa
	coreaudio
	audiotrack
	opensl
	audioout
	audio3d
	webaudio
	nnaudio
	winsonic
	aaudio
	max
}

pub enum DebugMode {
	tty
	file
	callback
}

pub enum SpeakerMode {
	default
	raw
	mono
	stereo
	quad
	surround
	_5point1
	_7point1
	_7point1point4
	max
}

pub enum Channelorder {
	default
	waveformat
	protools
	allmono
	allstereo
	alsa
	max
}

pub enum PluginType {
	output
	codec
	dsp
	max
}

pub enum SoundType {
	unknown
	aiff
	asf
	dls
	flac
	fsb
	it
	midi
	mod
	mpeg
	oggvorbis
	playlist
	raw
	s3m
	user
	wav
	xm
	xma
	audioqueue
	at9
	vorbis
	media_foundation
	mediacodec
	fadpcm
	opus
	max
}

pub enum SoundFormat {
	non
	pcm8
	pcm16
	pcm24
	pcm32
	pcmfloat
	bitstream
	max
}

pub enum OpenState {
	ready
	loading
	error
	connecting
	buffering
	seeking
	playing
	setposition
	max
}

pub enum SoundGroupBehavior {
	fail
	mute
	steallowest
	max
}

pub enum ChannelControlCallbackType {
	fmod_channelcontrol_callback_end
	fmod_channelcontrol_callback_virtualvoice
	fmod_channelcontrol_callback_syncpoint
	fmod_channelcontrol_callback_occlusion
	fmod_channelcontrol_callback_max
}

pub enum ErrorCallbackInstanceType {
	non
	system
	channel
	channelgroup
	channelcontrol
	sound
	soundgroup
	dsp
	dspconnection
	geometry
	reverb3d
	studio_system
	studio_eventdescription
	studio_eventinstance
	studio_parameterinstance
	studio_bus
	studio_vca
	studio_bank
	studio_commandreplay
}

pub enum DspResampler {
	default
	nointerp
	linear
	cubic
	spline
	max
}

pub enum DspConnectionType {
	standard
	sidechain
	send
	send_sidechain
	max
}

pub enum TagType {
	unknown
	id3v1
	id3v2
	vorbiscomment
	shoutcast
	icecast
	asf
	midi
	playlist
	fmod
	user
	max
}

pub enum TagdataType {
	binary
	int
	float
	str
	string_utf16
	string_utf16be
	string_utf8
	max
}

