module filesystem
import os
import filepath
import via.utils
import via.libs.physfs

pub fn init_filesystem(identity string, append_identity bool) {
	if physfs.initialize() != 1 { panic('could not initialize PhysFS') }

	physfs.permit_symbolic_links(1)
	physfs.mount(filepath.dir(os.realpath(os.executable())), '', true)

	mut ident := identity
	if ident.len == 0 {
		ident = filepath.filename(os.executable())
	}

	// setup save directory and add it to search path
	pref_path_raw := SDL_GetPrefPath(C.NULL, ident.str)
	pref_path := tos2(pref_path_raw)
	physfs.set_write_dir(pref_path)

	physfs.mount(pref_path, '', append_identity)
	SDL_free(pref_path_raw)
}

pub fn free() {
	physfs.deinit()
}

pub fn mount(archive, mount_point string, append_to_path bool) bool {
	return physfs.mount(archive, mount_point, append_to_path)
}

pub fn unmount(archive string) bool {
	return physfs.unmount(archive)
}

pub fn exists(fname string) bool {
	return physfs.exists(fname)
}

pub fn read_text(fname string) string {
	return physfs.read_text_c(charptr(fname.str))
}

pub fn read_text_c(fname charptr) string {
	return physfs.read_text_c(fname)
}

pub fn read_bytes(fname string) []byte {
	return physfs.read_bytes_c(charptr(fname.str))
}

pub fn read_bytes_c(fname charptr) []byte {
	return physfs.read_bytes_c(fname)
}