module c

pub struct C.ecs_memory_stat_t {
pub:
	allocd_bytes u32
	used_bytes u32
}

pub struct C.EcsAllocStats {
pub:
	malloc_count_total u64
	realloc_count_total u64
	calloc_count_total u64
	free_count_total u64
}

pub struct C.EcsRowSystemMemoryStats {
pub:
	base_memory_bytes u32
	columns_memory C.ecs_memory_stat_t
	components_memory C.ecs_memory_stat_t
}

pub struct C.EcsColSystemMemoryStats {
pub:
	base_memory_bytes u32
	columns_memory C.ecs_memory_stat_t
	active_tables_memory C.ecs_memory_stat_t
	inactive_tables_memory C.ecs_memory_stat_t
	jobs_memory C.ecs_memory_stat_t
	other_memory_bytes u32
}

pub struct C.EcsMemoryStats {
pub:
	__dummy u32
	total_memory C.ecs_memory_stat_t
	entities_memory C.ecs_memory_stat_t
	components_memory C.ecs_memory_stat_t
	systems_memory C.ecs_memory_stat_t
	types_memory C.ecs_memory_stat_t
	tables_memory C.ecs_memory_stat_t
	stages_memory C.ecs_memory_stat_t
	world_memory C.ecs_memory_stat_t
}

pub struct C.EcsComponentStats {
pub:
	entity u64
	name byteptr
	size_bytes u16
	memory C.ecs_memory_stat_t
	entities_count u32
	tables_count u32
}

pub struct C.EcsSystemStats {
pub:
	entity u64
	name byteptr
	signature byteptr
	kind EcsSystemKind
	period_seconds f32
	tables_matched_count u32
	entities_matched_count u32
	invoke_count_total u64
	seconds_total f32
	is_enabled bool
	is_active bool
	is_hidden bool
}

pub struct C.EcsTypeStats {
pub:
	entity u64
	name byteptr
	@type &C.ecs_vector_t
	normalized_type &C.ecs_vector_t
	entities_count u32
	entities_childof_count u32
	entities_instanceof_count u32
	components_count u32
	col_systems_count u32
	row_systems_count u32
	enabled_systems_count u32
	active_systems_count u32
	instance_count u32
	is_hidden bool
}

pub struct C.EcsTableStats {
pub:
	@type &C.ecs_vector_t
	columns_count u32
	rows_count u32
	systems_matched_count u32
	entity_memory C.ecs_memory_stat_t
	component_memory C.ecs_memory_stat_t
	other_memory_bytes u32
}

pub struct C.EcsWorldStats {
pub:
	target_fps_hz f64
	tables_count u32
	components_count u32
	col_systems_count u32
	row_systems_count u32
	inactive_systems_count u32
	entities_count u32
	threads_count u32
	frame_count_total u32
	frame_seconds_total f64
	system_seconds_total f64
	merge_seconds_total f64
	world_seconds_total f64
	fps_hz f64
}

pub struct C.FlecsStats {
pub:
	EEcsAllocStats u64
	TEcsAllocStats &C.ecs_vector_t
	EEcsWorldStats u64
	TEcsWorldStats &C.ecs_vector_t
	EEcsMemoryStats u64
	TEcsMemoryStats &C.ecs_vector_t
	EEcsSystemStats u64
	TEcsSystemStats &C.ecs_vector_t
	EEcsColSystemMemoryStats u64
	TEcsColSystemMemoryStats &C.ecs_vector_t
	EEcsRowSystemMemoryStats u64
	TEcsRowSystemMemoryStats &C.ecs_vector_t
	EEcsComponentStats u64
	TEcsComponentStats &C.ecs_vector_t
	EEcsTableStats u64
	TEcsTableStats &C.ecs_vector_t
	EEcsTablePtr u64
	TEcsTablePtr &C.ecs_vector_t
	EEcsTypeStats u64
	TEcsTypeStats &C.ecs_vector_t
}

fn C.FlecsStatsImport(world &C.ecs_world_t, flags int)
