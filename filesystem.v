module via
import os
import filepath
import via.utils
import via.libs.physfs

struct FileSystem {
	tmp int
}

fn create_filesystem(config ViaConfig) &FileSystem {
	if physfs.initialize() != 1 { panic('could not initialize PhysFS') }

	physfs.permit_symbolic_links(1)
	physfs.mount(filepath.dir(os.realpath(os.executable())), '', true)

	mut identity := config.identity
	if identity.len == 0 {
		identity = filepath.filename(os.executable())
	}

	// setup save directory and add it to search path
	pref_path_raw := SDL_GetPrefPath(C.NULL, identity.str)
	pref_path := tos2(pref_path_raw)
	physfs.set_write_dir(pref_path)

	physfs.mount(pref_path, '', config.append_identity)
	SDL_free(pref_path_raw)

	return &FileSystem{}
}

fn (fs &FileSystem) free() {
	physfs.deinit()
	unsafe { free(fs) }
}

pub fn (fs &FileSystem) mount(archive, mount_point string, append_to_path bool) bool {
	return physfs.mount(archive, mount_point, append_to_path)
}

pub fn (fs &FileSystem) unmount(archive string) bool {
	return physfs.unmount(archive)
}

pub fn (fs &FileSystem) exists(fname string) bool {
	return physfs.exists(fname)
}

pub fn (fs &FileSystem) read_text(fname string) string { return fs.read_text_c(charptr(fname.str)) }

pub fn (fs &FileSystem) read_text_c(fname charptr) string {
	buf := fs.read_bytes_c(fname)
	str := tos(buf.data, buf.len)
	unsafe { buf.free() }
	return str
}

pub fn (fs &FileSystem) read_bytes(fname string) []byte { return fs.read_bytes_c(charptr(fname.str)) }

pub fn (fs &FileSystem) read_bytes_c(fname charptr) []byte {
	fp := PHYSFS_openRead(fname)
	len := fp.get_length()

	buf := utils.make_array<int>(int(len), int(len))
	fp.read_bytes(buf.data, u64(len))
	fp.close()

	return buf
}