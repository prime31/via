module via
import via.libs.sdl2

struct Timer {
mut:
	frames u32
	prev_time u32
	curr_time u32
	last_fps_update u32
pub mut:
	dt f32
	average_dt f32
	fps f32
}

fn create_timer(config ViaConfig) &Timer {
	return &Timer{}
}

fn (t &Timer) free() {
	unsafe { free(t) }
}

fn (t mut Timer) tick() {
	t.frames++
	t.prev_time = t.curr_time
	t.curr_time = SDL_GetTicks()
	t.dt = 0.001 * f32(t.curr_time - t.prev_time)

	time_since_last := t.curr_time - t.last_fps_update
	if time_since_last > 1 {
		t.fps = f32(t.frames) / f32(time_since_last) + 0.5
		t.average_dt = f32(time_since_last) / f32(t.frames)
		t.last_fps_update = t.curr_time
		t.frames = 0
	}
}

pub fn (t &Timer) sleep(seconds f32) {
	SDL_Delay(u32(seconds * 1000))
}

pub fn (t &Timer) get_time() u64 {
	return SDL_GetPerformanceCounter() / SDL_GetPerformanceFrequency()
}