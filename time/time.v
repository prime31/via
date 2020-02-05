module time
import via.libs.sdl2.c

pub struct Time {
mut:
	fps_frames u32
	prev_time u32
	curr_time u32
	fps_last_update u32
pub mut:
	dt f32
	fps u32
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
	t.fps_frames++
	t.prev_time = t.curr_time
	t.curr_time = C.SDL_GetTicks()
	t.dt = 0.001 * f32(t.curr_time - t.prev_time)

	time_since_last := t.curr_time - t.fps_last_update
	if t.curr_time > t.fps_last_update + 1000 {
		t.fps = t.fps_frames * 1000 / time_since_last
		t.fps_last_update = t.curr_time
		t.fps_frames = 0
	}
}

[inline]
pub fn sleep(seconds f32) { SDL_Delay(u32(seconds * 1000)) }

[inline]
pub fn dt() f32 { return time.dt }

[inline]
pub fn frame_count() u32 { return time.frame_count }

// number of milliseconds since the SDL library initialization
[inline]
pub fn ticks() u32 { return SDL_GetTicks() }

[inline]
pub fn seconds() f32 { return f32(SDL_GetTicks()) / 1000.0 }

[inline]
pub fn fps() u32 { return time.fps }

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