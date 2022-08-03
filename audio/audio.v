module audio
import via.libs.fmod as ffsmod
import via.libs.fmod.core as fmod
import via.libs.fmod.physfs as fmod_physfs

struct Audio {
mut:
	sys fmod.System
}

pub const (
	m_audio = &Audio{}
)

pub fn create() {
	mut a := m_audio
	a.sys = fmod.create(32, C.FMOD_INIT_NORMAL)
	fmod_physfs.set_physfs_file_system(a.sys)
}

pub fn free() {
	m_audio.sys.free()
	unsafe { C.free(m_audio) }
}

pub fn new_sound(fname string) fmod.Sound {
	res, snd := m_audio.sys.create_sound(fname.str, C.FMOD_DEFAULT)
	if res != 0 {
		println('new_sound error. Result enum value: $res string: "${ffsmod.error_string(res)}"')
	}
	return snd
}

pub fn new_stream(fname string) fmod.Sound {
	res, snd := m_audio.sys.create_sound(fname.str, C.FMOD_CREATESTREAM)
	if res != 0 {
		println('new_stream error. Result enum value: $res')
	}
	return snd
}