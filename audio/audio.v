module audio
import via.libs.fmod.core as fmod
import via.libs.fmod.physfs as fmod_physfs

struct Audio {
mut:
	sys fmod.System
}

pub const (
	audio = &Audio{}
)

pub fn create() {
	mut a := audio
	a.sys = fmod.create(32, C.FMOD_INIT_NORMAL)
	fmod_physfs.set_physfs_file_system(a.sys)
}

pub fn free() {
	audio.sys.free()
	unsafe { free(audio) }
}

pub fn new_sound(fname string) fmod.Sound {
	res, snd := audio.sys.create_sound(fname.str, C.FMOD_DEFAULT)
	if res != 0 {
		println('new_sound error. Result enum value: $res')
	}
	return snd
}

pub fn new_stream(fname string) fmod.Sound {
	res, snd := audio.sys.create_sound(fname.str, C.FMOD_CREATESTREAM)
	if res != 0 {
		println('new_stream error. Result enum value: $res')
	}
	return snd
}