module c

fn C.SDL_GetTicks() u32
fn C.SDL_GetPerformanceCounter() u64
fn C.SDL_GetPerformanceFrequency() u64
fn C.SDL_Delay(ms u32)
fn C.SDL_AddTimer(interval u32, callback fn(u32, voidptr) u32, param voidptr) int
fn C.SDL_RemoveTimer(id int) Bool