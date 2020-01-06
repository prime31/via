module via

struct Graphics {
	filesystem &FileSystem
}

fn create_graphics(config &ViaConfig, filesystem &FileSystem) &Graphics {
	return &Graphics{
		filesystem: filesystem
	}
}

fn (g &Graphics) free() {
	unsafe { free(g) }
}