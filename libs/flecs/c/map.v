module c

pub struct C.ecs_map_t {}

pub struct C.ecs_map_iter_t {
pub:
	map &C.ecs_map_t
	bucket_index u32
	node u32
}

fn C.ecs_map_new(size u32, elem_size u32) &C.ecs_map_t
fn C.ecs_map_free(map &C.ecs_map_t)
fn C.ecs_map_memory(map &C.ecs_map_t, total &u32, used &u32)
fn C.ecs_map_count(map &C.ecs_map_t) u32
fn C.ecs_map_set_size(map &C.ecs_map_t, size u32) u32
fn C.ecs_map_data_size(map &C.ecs_map_t) u32
fn C.ecs_map_grow(map &C.ecs_map_t, size u32) u32
fn C.ecs_map_bucket_count(map &C.ecs_map_t) u32
fn C.ecs_map_clear(map &C.ecs_map_t)
fn C._ecs_map_set(map &C.ecs_map_t, key_hash u64, data voidptr, size u32) voidptr
fn C._ecs_map_has(map &C.ecs_map_t, key_hash u64, value_out voidptr, size u32) bool
fn C.ecs_map_get_ptr(map &C.ecs_map_t, key_hash u64) voidptr
fn C.ecs_map_remove(map &C.ecs_map_t, key_hash u64) int
fn C.ecs_map_copy(map &C.ecs_map_t) &C.ecs_map_t
fn C.ecs_map_iter(map &C.ecs_map_t) C.ecs_map_iter_t
fn C.ecs_map_hasnext(it &C.ecs_map_iter_t) bool
fn C.ecs_map_next(it &C.ecs_map_iter_t) voidptr
fn C.ecs_map_next_w_size(it &C.ecs_map_iter_t, size u32) voidptr
fn C.ecs_map_next_w_key(it &C.ecs_map_iter_t, key_out &u64) voidptr
fn C.ecs_map_next_w_key_w_size(it &C.ecs_map_iter_t, key_out &u64, size u32) voidptr
