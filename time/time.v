module time

pub struct Time {
mut:
	frames u32
	prev_time u32
	curr_time u32
	last_fps_update u32
pub mut:
	dt f32
	average_dt f32
	fps int
	frame_count u32 = u32(1)
}

pub const (
	time = &Time{}
)

pub fn free() {
	unsafe { free(time) }
}

pub fn tick() {
	mut t := time

	t.frame_count++
	t.frames++
	t.prev_time = t.curr_time
	t.curr_time = SDL_GetTicks()
	t.dt = 0.001 * f32(t.curr_time - t.prev_time)

	time_since_last := t.curr_time - t.last_fps_update
	if time_since_last > 1 {
		fps := f32(t.frames) / f32(time_since_last) + 0.5
		t.fps = int(fps * 100.0)
		t.average_dt = f32(time_since_last) / f32(t.frames)
		t.last_fps_update = t.curr_time
		t.frames = 0
	}
}

pub fn sleep(seconds f32) {
	SDL_Delay(u32(seconds * 1000))
}

pub fn get_dt() f32 {
	return time.dt
}

pub fn get_time() u64 {
	return SDL_GetPerformanceCounter() / SDL_GetPerformanceFrequency()
}

pub fn get_frame_count() u32 {
	return time.frame_count
}

pub fn get_ticks() u32 {
	return SDL_GetTicks()
}

pub fn get_seconds() f32 {
	return f32(SDL_GetTicks()) / 1000.0
}

pub fn fps() f32 { return time.fps }