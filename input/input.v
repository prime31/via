module input
import via.libs.sdl2

struct Input {
	dummy u32
}

const (
	input = &Input{}
)

pub fn free() {
	unsafe { free(time) }
}
