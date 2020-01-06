module via

struct Audio {
	tmp int
}

fn create_audio(config ViaConfig) &Audio {
	return &Audio{}
}

fn (a &Audio) free() {
	unsafe { free(a) }
}