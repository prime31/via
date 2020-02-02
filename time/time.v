module time
import via.libs.sdl2.c

pub struct Time {
mut:
	frames u32
	prev_time u32
	curr_time u32
	last_fps_update u32
pub mut:
	dt f32
	fps int
	frame_count u32 = u32(1)
}

const (
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
	t.curr_time = C.SDL_GetTicks()
	t.dt = 0.001 * f32(t.curr_time - t.prev_time)

	time_since_last := t.curr_time - t.last_fps_update
	if time_since_last > 1 {
		fps := f32(t.frames) / f32(time_since_last) + 0.5
		t.fps = int(fps * 100.0)
		t.last_fps_update = t.curr_time
		t.frames = 0
	}
}

[inline]
pub fn sleep(seconds f32) { SDL_Delay(u32(seconds * 1000)) }

[inline]
pub fn dt() f32 { return time.dt }

[inline]
pub fn frame_count() u32 { return time.frame_count }

[inline]
pub fn ticks() u32 { return SDL_GetTicks() }

[inline]
pub fn seconds() f32 { return f32(SDL_GetTicks()) / 1000.0 }

[inline]
pub fn fps() f32 { return time.fps }

[inline]
pub fn now() u64 { return SDL_GetPerformanceCounter() }

// returns the time in milliseconds since the last call
pub fn laptime(last_time &u64) u64 {
	mut tmp := last_time
	mut dt := u64(0)
	now := now()
	if *tmp != 0 {
		dt = ((now - *tmp) * 1000) / C.SDL_GetPerformanceFrequency()
	}
	*tmp = now
	return dt
}