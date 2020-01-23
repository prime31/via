module via
import via.libs.sdl2

struct Clock {
mut:
	frames u32
	prev_time u32
	curr_time u32
	last_fps_update u32
pub mut:
	dt f32
	average_dt f32
	fps f32
	frame_count u32 = u32(1)
}

fn new_clock(config ViaConfig) &Clock {
	return &Clock{}
}

fn (c &Clock) free() {
	unsafe { free(c) }
}

fn (c mut Clock) tick() {
	c.frame_count++
	c.frames++
	c.prev_time = c.curr_time
	c.curr_time = SDL_GetTicks()
	c.dt = 0.001 * f32(c.curr_time - c.prev_time)

	time_since_last := c.curr_time - c.last_fps_update
	if time_since_last > 1 {
		c.fps = f32(c.frames) / f32(time_since_last) + 0.5
		c.average_dt = f32(time_since_last) / f32(c.frames)
		c.last_fps_update = c.curr_time
		c.frames = 0
	}
}

pub fn (c &Clock) sleep(seconds f32) {
	SDL_Delay(u32(seconds * 1000))
}

pub fn (c &Clock) get_time() u64 {
	return SDL_GetPerformanceCounter() / SDL_GetPerformanceFrequency()
}

pub fn (c &Clock) get_frame_count() u32 {
	return c.frame_count
}

pub fn (c &Clock) get_ticks() u32 {
	return SDL_GetTicks()
}

pub fn (c &Clock) get_seconds() f32 {
	return f32(SDL_GetTicks()) / 1000.0
}