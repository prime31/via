module c

type ecs_type &ecs_vector_t

pub enum EcsSystemKind {
	on_load
	post_load
	pre_update
	on_update
	on_validate
	post_update
	pre_store
	on_store
	manual
	on_add
	on_remove
	on_set
}

pub enum EcsMatchKind {
	default = 0
	all = 1
	any = 2
	exact = 3
}

pub enum EcsSystemStatus {
	status_none = 0
	enabled = 1
	disabled = 2
	activated = 3
	deactivated = 4
}

pub struct C.ecs_world_t {
}

pub struct C.ecs_rows_t {
pub:
	world &C.ecs_world_t
	system u64
	columns &int
	column_count u16
	table voidptr
	table_columns voidptr
	system_data voidptr
	references &C.ecs_reference_t
	components &u64
	entities &u64
	param voidptr
	delta_time f32
	world_time f32
	frame_offset u32
	table_offset u32
	offset u32
	count u32
	interrupted_by u64
}

pub fn (r &C.ecs_rows_t) column<T>(column u32) &T {
    return *T(C._ecs_column(r, sizeof(T), column))
}

pub struct C.ecs_reference_t {}

pub struct C.ecs_snapshot_t {}

pub struct C.EcsComponent {
pub:
	size u32
}

pub struct C.EcsTypeComponent {
pub:
	@type &C.ecs_vector_t
	resolved &C.ecs_vector_t
}

pub struct C.EcsPrefab {
pub:
	parent u64
}

pub struct C.ecs_table_data_t {
pub:
	row_count u32
	column_count u32
	entities &u64
	components &u64
	columns &voidptr
}

pub struct C.ecs_filter_iter_t {
pub:
	filter ecs_type_filter_t
	tables &C.ecs_chunked_t
	index u32
	rows C.ecs_rows_t
}

fn C.ecs_init() &C.ecs_world_t
fn C.ecs_init_w_args(argc int, argv []byteptr) &C.ecs_world_t
fn C.ecs_fini(world &C.ecs_world_t) int
fn C.ecs_quit(world &C.ecs_world_t)
fn C.ecs_progress(world &C.ecs_world_t, delta_time f32) bool
fn C.ecs_set_target_fps(world &C.ecs_world_t, fps f32)
fn C.ecs_get_target_fps(world &C.ecs_world_t) f32
fn C.ecs_get_delta_time(world &C.ecs_world_t) f32
fn C.ecs_set_context(world &C.ecs_world_t, ctx voidptr)
fn C.ecs_get_context(world &C.ecs_world_t) voidptr
fn C.ecs_get_tick(world &C.ecs_world_t) u32
fn C.ecs_dim(world &C.ecs_world_t, entity_count u32)
fn C._ecs_dim_type(world &C.ecs_world_t, typ &C.ecs_vector_t, entity_count u32)
fn C.ecs_set_entity_range(world &C.ecs_world_t, id_start u64, id_end u64)
fn C.ecs_enable_range_check(world &C.ecs_world_t, enable bool) bool
fn C._ecs_new(world &C.ecs_world_t, typ &C.ecs_vector_t) u64
fn C._ecs_new_w_count(world &C.ecs_world_t, typ &C.ecs_vector_t, count u32) u64
fn C.ecs_set_w_data(world &C.ecs_world_t, data &C.ecs_table_data_t) u64
fn C._ecs_new_child(world &C.ecs_world_t, parent u64, typ &C.ecs_vector_t) u64
fn C._ecs_new_child_w_count(world &C.ecs_world_t, parent u64, typ &C.ecs_vector_t, count u32) u64
fn C._ecs_new_instance(world &C.ecs_world_t, base u64, typ &C.ecs_vector_t) u64
fn C._ecs_new_instance_w_count(world &C.ecs_world_t, base u64, typ &C.ecs_vector_t, count u32) u64
fn C.ecs_clone(world &C.ecs_world_t, entity u64, copy_value bool) u64
fn C.ecs_delete(world &C.ecs_world_t, entity u64)
fn C.ecs_delete_w_filter(world &C.ecs_world_t, filter &ecs_type_filter_t)
fn C._ecs_add(world &C.ecs_world_t, entity u64, typ &C.ecs_vector_t)
fn C.ecs_add_entity(world &C.ecs_world_t, entity u64, to_add u64)
fn C._ecs_remove(world &C.ecs_world_t, entity u64, typ &C.ecs_vector_t)
fn C.ecs_remove_entity(world &C.ecs_world_t, entity u64, to_remove u64)
fn C._ecs_add_remove(world &C.ecs_world_t, entity u64, to_add &C.ecs_vector_t, to_remove &C.ecs_vector_t)
fn C.ecs_adopt(world &C.ecs_world_t, entity u64, parent u64)
fn C.ecs_orphan(world &C.ecs_world_t, entity u64, parent u64)
fn C.ecs_inherit(world &C.ecs_world_t, entity u64, base u64)
fn C.ecs_disinherit(world &C.ecs_world_t, entity u64, base u64)
fn C._ecs_add_remove_w_filter(world &C.ecs_world_t, to_add &C.ecs_vector_t, to_remove &C.ecs_vector_t, filter &ecs_type_filter_t)
fn C._ecs_get_ptr(world &C.ecs_world_t, entity u64, typ &C.ecs_vector_t) voidptr
fn C._ecs_set_ptr(world &C.ecs_world_t, entity u64, component u64, size u32, ptr voidptr) u64
fn C._ecs_has(world &C.ecs_world_t, entity u64, typ &C.ecs_vector_t) bool
fn C._ecs_has_owned(world &C.ecs_world_t, entity u64, typ &C.ecs_vector_t) bool
fn C._ecs_has_any(world &C.ecs_world_t, entity u64, typ &C.ecs_vector_t) bool
fn C._ecs_has_any_owned(world &C.ecs_world_t, entity u64, typ &C.ecs_vector_t) bool
fn C.ecs_has_entity(world &C.ecs_world_t, entity u64, component u64) bool
fn C.ecs_has_entity_owned(world &C.ecs_world_t, entity u64, component u64) bool
fn C.ecs_contains(world &C.ecs_world_t, parent u64, child u64) bool
fn C._ecs_get_parent(world &C.ecs_world_t, entity u64, component u64) u64
fn C.ecs_get_type(world &C.ecs_world_t, entity u64) &C.ecs_vector_t
fn C.ecs_get_id(world &C.ecs_world_t, entity u64) byteptr
fn C._ecs_count(world &C.ecs_world_t, typ &C.ecs_vector_t) u32
fn C.ecs_count_w_filter(world &C.ecs_world_t, filter &ecs_type_filter_t) u32
fn C.ecs_lookup(world &C.ecs_world_t, id byteptr) u64
fn C.ecs_lookup_child(world &C.ecs_world_t, parent u64, id byteptr) u64
fn C._ecs_column(rows &C.ecs_rows_t, size u32, column u32) voidptr
fn C.ecs_is_shared(rows &C.ecs_rows_t, column u32) bool
fn C._ecs_field(rows &C.ecs_rows_t, size u32, column u32, row u32) voidptr
fn C.ecs_column_source(rows &C.ecs_rows_t, column u32) u64
fn C.ecs_column_entity(rows &C.ecs_rows_t, column u32) u64
fn C.ecs_column_type(rows &C.ecs_rows_t, column u32) &C.ecs_vector_t
fn C.ecs_is_readonly(rows &C.ecs_rows_t, column u32) bool
fn C.ecs_table_type(rows &C.ecs_rows_t) &C.ecs_vector_t
fn C.ecs_table_column(rows &C.ecs_rows_t, column u32) voidptr
fn C.ecs_filter_iter(world &C.ecs_world_t, filter &ecs_type_filter_t) C.ecs_filter_iter_t
fn C.ecs_snapshot_filter_iter(world &C.ecs_world_t, snapshot &C.ecs_snapshot_t, filter &ecs_type_filter_t) C.ecs_filter_iter_t
fn C.ecs_filter_next(iter &C.ecs_filter_iter_t) bool
fn C.ecs_enable(world &C.ecs_world_t, system u64, enabled bool)
fn C.ecs_set_period(world &C.ecs_world_t, system u64, period f32)
fn C.ecs_is_enabled(world &C.ecs_world_t, system u64) bool
fn C.ecs_run(world &C.ecs_world_t, system u64, delta_time f32, param voidptr) u64
fn C._ecs_run_w_filter(world &C.ecs_world_t, system u64, delta_time f32, offset u32, limit u32, filter &C.ecs_vector_t, param voidptr) u64
fn C.ecs_set_system_context(world &C.ecs_world_t, system u64, ctx voidptr)
fn C.ecs_get_system_context(world &C.ecs_world_t, system u64) voidptr
fn C.ecs_set_system_status_action(world &C.ecs_world_t, system u64, action fn(&C.ecs_world_t, u64, EcsSystemStatus, voidptr), ctx voidptr)
fn C.ecs_snapshot_take(world &C.ecs_world_t, filter &ecs_type_filter_t) &C.ecs_snapshot_t
fn C.ecs_snapshot_restore(world &C.ecs_world_t, snapshot &C.ecs_snapshot_t)
fn C.ecs_snapshot_copy(world &C.ecs_world_t, snapshot &C.ecs_snapshot_t, filter &ecs_type_filter_t) &C.ecs_snapshot_t
fn C.ecs_snapshot_free(world &C.ecs_world_t, snapshot &C.ecs_snapshot_t)
fn C.ecs_reader_init(world &C.ecs_world_t) C.ecs_reader_t
fn C.ecs_snapshot_reader_init(world &C.ecs_world_t, snapshot &C.ecs_snapshot_t) C.ecs_reader_t
fn C.ecs_reader_read(buffer byteptr, size u32, reader &C.ecs_reader_t) u32
fn C.ecs_writer_init(world &C.ecs_world_t) C.ecs_writer_t
fn C.ecs_writer_write(buffer byteptr, size u32, writer &C.ecs_writer_t) int
fn C._ecs_import(world &C.ecs_world_t, mod fn(&C.ecs_world_t, int), module_name byteptr, flags int, handles_out voidptr, handles_size u32) u64
fn C.ecs_import_from_library(world &C.ecs_world_t, library_name byteptr, module_name byteptr, flags int) u64
fn C.ecs_type_from_entity(world &C.ecs_world_t, entity u64) &C.ecs_vector_t
fn C.ecs_type_to_entity(world &C.ecs_world_t, typ &C.ecs_vector_t) u64
fn C.ecs_type_add(world &C.ecs_world_t, typ &C.ecs_vector_t, entity u64) &C.ecs_vector_t
fn C.ecs_type_remove(world &C.ecs_world_t, typ &C.ecs_vector_t, entity u64) &C.ecs_vector_t
fn C.ecs_type_merge(world &C.ecs_world_t, typ &C.ecs_vector_t, type_add &C.ecs_vector_t, type_remove &C.ecs_vector_t) &C.ecs_vector_t
fn C.ecs_type_find(world &C.ecs_world_t, array &u64, count u32) &C.ecs_vector_t
fn C.ecs_type_get_entity(world &C.ecs_world_t, typ &C.ecs_vector_t, index u32) u64
fn C.ecs_type_has_entity(world &C.ecs_world_t, typ &C.ecs_vector_t, entity u64) bool
fn C.ecs_expr_to_type(world &C.ecs_world_t, expr byteptr) &C.ecs_vector_t
fn C.ecs_type_to_expr(world &C.ecs_world_t, typ &C.ecs_vector_t) byteptr
fn C.ecs_type_match_w_filter(world &C.ecs_world_t, typ &C.ecs_vector_t, filter &ecs_type_filter_t) bool
fn C.ecs_type_index_of(typ &C.ecs_vector_t, entity u64) i16
fn C.ecs_set_threads(world &C.ecs_world_t, threads u32)
fn C.ecs_get_threads(world &C.ecs_world_t) u32
fn C.ecs_get_thread_index(world &C.ecs_world_t) u16
fn C.ecs_merge(world &C.ecs_world_t)
fn C.ecs_set_automerge(world &C.ecs_world_t, auto_merge bool)
fn C.ecs_enable_admin(world &C.ecs_world_t, port u16) int
fn C.ecs_enable_console(world &C.ecs_world_t) int
