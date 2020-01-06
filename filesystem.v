module via
import os
import filepath
import prime31.physfs

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