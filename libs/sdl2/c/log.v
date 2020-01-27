module c

pub enum LogPriority {
	log_priority_verbose = 1
	log_priority_debug = 2
	log_priority_info = 3
	log_priority_warn = 4
	log_priority_error = 5
	log_priority_critical = 6
	num_log_priorities = 7
}

fn C.SDL_LogSetAllPriority(priority LogPriority)
fn C.SDL_LogSetPriority(category int, priority LogPriority)
fn C.SDL_LogGetPriority(category int) LogPriority
fn C.SDL_LogResetPriorities()
fn C.SDL_Log(fmt byteptr)
fn C.SDL_LogVerbose(category int, fmt byteptr)
fn C.SDL_LogDebug(category int, fmt byteptr)
fn C.SDL_LogInfo(category int, fmt byteptr)
fn C.SDL_LogWarn(category int, fmt byteptr)
fn C.SDL_LogError(category int, fmt byteptr)
fn C.SDL_LogCritical(category int, fmt byteptr)
fn C.SDL_LogMessage(category int, priority LogPriority, fmt byteptr)
fn C.SDL_LogMessageV(category int, priority LogPriority, fmt byteptr, ap voidptr /* ...voidptr */)
fn C.SDL_LogGetOutputFunction(callback fn(voidptr, int, LogPriority, byteptr), userdata &voidptr /* void** */)
fn C.SDL_LogSetOutputFunction(callback fn(voidptr, int, LogPriority, byteptr), userdata voidptr)