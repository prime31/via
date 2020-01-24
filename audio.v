module via
import via.libs.fmod.core as fmod
import via.libs.fmod.physfs as fmod_physfs

struct Audio {
	sys fmod.System
}

fn new_audio(config ViaConfig) &Audio {
	sys := fmod.create(32, C.FMOD_INIT_NORMAL)
	fmod_physfs.set_physfs_file_system(sys)

	return &Audio{
		sys: sys
	}
}

fn (a &Audio) free() {
	a.sys.free()
	unsafe { free(a) }
}

pub fn (a &Audio) new_sound(fname string) fmod.Sound {
	res, snd := a.sys.create_sound(fname.str, C.FMOD_DEFAULT)
	if res != 0 {
		println('new_sound error. Result enum value: $res')
	}
	return snd
}

pub fn (a &Audio) new_stream(fname string) fmod.Sound {
	res, snd := a.sys.create_sound(fname.str, C.FMOD_CREATESTREAM)
	if res != 0 {
		println('new_stream error. Result enum value: $res')
	}
	return snd
}