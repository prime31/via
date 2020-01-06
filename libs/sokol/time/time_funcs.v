module time

fn C.stm_setup()
fn C.stm_now() u64
fn C.stm_diff(new_ticks u64, old_ticks u64) u64
fn C.stm_since(start_ticks u64) u64
fn C.stm_laptime(last_time &u64) u64
fn C.stm_sec(ticks u64) f64
fn C.stm_ms(ticks u64) f64
fn C.stm_us(ticks u64) f64
fn C.stm_ns(ticks u64) f64