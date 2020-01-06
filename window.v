module via

struct Window {
	tmp int
}

fn create_window(config ViaConfig) &Window {
	return &Window{}
}

fn (w &Window) free() {
	unsafe { free(w) }
}