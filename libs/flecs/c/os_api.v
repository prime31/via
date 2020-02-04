module c

pub struct C.ecs_time_t {
pub:
	sec int
	nanosec u32
}

pub type ThreadNewFn fn(voidptr) voidptr

pub struct C.ecs_os_api_t {
pub:
	malloc fn(u32) voidptr
	realloc fn(voidptr, u32) voidptr
	calloc fn(u32, u32) voidptr
	free fn(voidptr)
	strdup fn(byteptr) byteptr
	thread_new fn(ThreadNewFn, voidptr) u32
	thread_join fn(u32) voidptr
	mutex_new fn() u32
	mutex_free fn(u32)
	mutex_lock fn(u32)
	mutex_unlock fn(u32)
	cond_new fn() u32
	cond_free fn(u32)
	cond_signal fn(u32)
	cond_broadcast fn(u32)
	cond_wait fn(u32, u32)
	sleep fn(u32, u32)
	get_time fn(&C.ecs_time_t)
	log fn(byteptr, voidptr /* ...voidptr */)
	log_error fn(byteptr, voidptr /* ...voidptr */)
	log_debug fn(byteptr, voidptr /* ...voidptr */)
	log_warning fn(byteptr, voidptr /* ...voidptr */)
	abort fn()
	dlopen fn(byteptr) u32
	dlproc voidptr /* fn(u32, byteptr) fn() */
	dlclose fn(u32)
	module_to_dl fn(byteptr) byteptr
}

fn C.ecs_os_set_api(os_api &C.ecs_os_api_t)
fn C.ecs_os_set_api_defaults()
fn C.ecs_os_log(fmt byteptr)
fn C.ecs_os_warn(fmt byteptr)
fn C.ecs_os_err(fmt byteptr)
fn C.ecs_os_dbg(fmt byteptr)
fn C.ecs_os_enable_dbg(enable bool)
fn C.ecs_os_dbg_enabled() bool
fn C.ecs_sleepf(t f64)
fn C.ecs_time_measure(start &C.ecs_time_t) f64
fn C.ecs_time_sub(t1 C.ecs_time_t, t2 C.ecs_time_t) C.ecs_time_t
fn C.ecs_time_to_double(t C.ecs_time_t) f64
fn C.ecs_os_memdup(src voidptr, size u32) voidptr
