module c

pub enum EcsBlobHeaderKind {
	stream_header
	component_segment
	table_segment
	footer_segment
	component_header
	component_id
	component_size
	component_name_length
	component_name
	table_header
	table_type_size
	table_type
	table_size
	table_column
	table_column_header
	table_column_size
	table_column_data
	table_column_name_header
	table_column_name_length
	table_column_name
	stream_footer
}

pub struct C.ecs_type_filter_t {
pub:
	include &C.ecs_vector_t
	exclude &C.ecs_vector_t
	include_kind EcsMatchKind
	exclude_kind EcsMatchKind
}

pub struct C.ecs_table_t {
}

pub struct C.ecs_table_column_t {
}

pub struct C.ecs_component_reader_t {
pub:
	state EcsBlobHeaderKind
	id_column &u64
	data_column &C.EcsComponent
	name_column &byteptr
	index int
	count int
	name byteptr
	len u32
	written u32
}

pub struct C.ecs_table_reader_t {
pub:
	state EcsBlobHeaderKind
	table_index u32
	table &C.ecs_table_t
	columns &C.ecs_table_column_t
	type_written int
	@type &C.ecs_vector_t
	column &C.ecs_table_column_t
	column_index int
	total_columns int
	column_data voidptr
	column_size u32
	column_written u32
	row_index int
	row_count u32
	name byteptr
	name_len u32
	name_written u32
}

pub struct C.ecs_reader_t {
pub:
	world &C.ecs_world_t
	state EcsBlobHeaderKind
	tables &C.ecs_chunked_t
	component C.ecs_component_reader_t
	table C.ecs_table_reader_t
}

pub struct C.ecs_name_writer_t {
pub:
	name byteptr
	written int
	len int
	max_len int
}

pub struct C.ecs_component_writer_t {
pub:
	state EcsBlobHeaderKind
	id int
	size u32
	name C.ecs_name_writer_t
}

pub struct C.ecs_table_writer_t {
pub:
	state EcsBlobHeaderKind
	table &C.ecs_table_t
	column &C.ecs_table_column_t
	type_count u32
	type_max_count u32
	type_written u32
	type_array &u64
	column_index u32
	column_size u32
	column_written u32
	column_data voidptr
	row_count u32
	row_index int
	name C.ecs_name_writer_t
}

pub struct C.ecs_writer_t {
pub:
	world &C.ecs_world_t
	state EcsBlobHeaderKind
	component C.ecs_component_writer_t
	table C.ecs_table_writer_t
	error int
}

fn C.ecs_new_entity(world &C.ecs_world_t, id byteptr, components byteptr) u64
fn C.ecs_new_component(world &C.ecs_world_t, id byteptr, size u32) u64
fn C.ecs_new_system(world &C.ecs_world_t, id byteptr, kind EcsSystemKind, sig byteptr, action fn(&C.ecs_rows_t)) u64
fn C.ecs_new_type(world &C.ecs_world_t, id byteptr, components byteptr) u64
fn C.ecs_new_prefab(world &C.ecs_world_t, id byteptr, sig byteptr) u64
fn C.ecs_strerror(error_code u32) byteptr
fn C._ecs_abort(error_code u32, param byteptr, file byteptr, line u32)
fn C._ecs_assert(condition bool, error_code u32, param byteptr, condition_str byteptr, file byteptr, line u32)
fn C._ecs_parser_error(name byteptr, expr byteptr, column int, fmt byteptr)
