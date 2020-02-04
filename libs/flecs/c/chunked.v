module c

pub struct C.ecs_chunked_t {}

fn C._ecs_chunked_new(element_size u32, chunk_size u32, chunk_count u32) &C.ecs_chunked_t
fn C.ecs_chunked_free(chunked &C.ecs_chunked_t)
fn C.ecs_chunked_clear(chunked &C.ecs_chunked_t)
fn C._ecs_chunked_add(chunked &C.ecs_chunked_t, size u32) voidptr
fn C._ecs_chunked_remove(chunked &C.ecs_chunked_t, size u32, index u32) voidptr
fn C._ecs_chunked_get(chunked &C.ecs_chunked_t, size u32, index u32) voidptr
fn C.ecs_chunked_count(chunked &C.ecs_chunked_t) u32
fn C._ecs_chunked_get_sparse(chunked &C.ecs_chunked_t, size u32, index u32) voidptr
fn C.ecs_chunked_indices(chunked &C.ecs_chunked_t) &u32
fn C.ecs_chunked_copy(src &C.ecs_chunked_t) &C.ecs_chunked_t
fn C.ecs_chunked_memory(chunked &C.ecs_chunked_t, allocd &u32, used &u32)
