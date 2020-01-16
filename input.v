module via
import via.libs.sdl2

struct Input {
	frames u32
}

fn new_input(config ViaConfig) &Input {
	return &Input{}
}

fn (i &Input) free() {
	unsafe { free(i) }
}