module core

// this is manually translated FMOD_TIMEUNIT, which is not an enum. it is just a #define
enum TimeUnit {
	ms = 0x00000001
	pcm = 0x00000002
	pcm_bytes = 0x00000004
	raw_bytes = 0x00000008
	pcm_fraction = 0x00000010
	mod_order = 0x00000100
	mod_row = 0x00000200
	mod_pattern = 0x00000400
}
