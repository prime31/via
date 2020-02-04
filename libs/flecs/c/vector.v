module c

pub struct C.ecs_vector_t {}

pub struct C.ecs_vector_params_t {
pub:
	move_action fn(&C.ecs_vector_t, &C.ecs_vector_params_t, voidptr, voidptr, voidptr)
	move_ctx voidptr
	ctx voidptr
	element_size u32
}

fn C.ecs_vector_new(params &C.ecs_vector_params_t, size u32) &C.ecs_vector_t
fn C.ecs_vector_new_from_buffer(params &C.ecs_vector_params_t, size u32, buffer voidptr) &C.ecs_vector_t
fn C.ecs_vector_free(array &C.ecs_vector_t)
fn C.ecs_vector_clear(array &C.ecs_vector_t)
fn C.ecs_vector_add(array_inout &voidptr /* ecs_vector_t** */, params &C.ecs_vector_params_t) voidptr
fn C.ecs_vector_addn(array_inout &voidptr /* ecs_vector_t** */, params &C.ecs_vector_params_t, count u32) voidptr
fn C.ecs_vector_get(array &C.ecs_vector_t, params &C.ecs_vector_params_t, index u32) voidptr
fn C.ecs_vector_get_index(array &C.ecs_vector_t, params &C.ecs_vector_params_t, elem voidptr) u32
fn C.ecs_vector_last(array &C.ecs_vector_t, params &C.ecs_vector_params_t) voidptr
fn C.ecs_vector_remove(array &C.ecs_vector_t, params &C.ecs_vector_params_t, elem voidptr) u32
fn C.ecs_vector_remove_last(array &C.ecs_vector_t)
fn C.ecs_vector_pop(array &C.ecs_vector_t, params &C.ecs_vector_params_t, value voidptr) bool
fn C.ecs_vector_move_index(dst_array &voidptr /* ecs_vector_t** */, src_array &C.ecs_vector_t, params &C.ecs_vector_params_t, index u32) u32
fn C.ecs_vector_remove_index(array &C.ecs_vector_t, params &C.ecs_vector_params_t, index u32) u32
fn C.ecs_vector_reclaim(array &voidptr /* ecs_vector_t** */, params &C.ecs_vector_params_t)
fn C.ecs_vector_set_size(array &voidptr /* ecs_vector_t** */, params &C.ecs_vector_params_t, size u32) u32
fn C.ecs_vector_set_count(array &voidptr /* ecs_vector_t** */, params &C.ecs_vector_params_t, size u32) u32
fn C.ecs_vector_count(array &C.ecs_vector_t) u32
fn C.ecs_vector_size(array &C.ecs_vector_t) u32
fn C.ecs_vector_first(array &C.ecs_vector_t) voidptr
fn C.ecs_vector_sort(array &C.ecs_vector_t, params &C.ecs_vector_params_t, compare_action fn(voidptr, voidptr) int)
fn C.ecs_vector_memory(array &C.ecs_vector_t, params &C.ecs_vector_params_t, allocd &u32, used &u32)
fn C.ecs_vector_copy(src &C.ecs_vector_t, params &C.ecs_vector_params_t) &C.ecs_vector_t
