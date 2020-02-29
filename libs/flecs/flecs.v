module flecs

// this should be a method on ecs_rows_t, but there is a V bug preventing that from working
pub fn column<T>(rows &C.ecs_rows_t, column u32) &T {
    return *T(C._ecs_column(rows, sizeof(T), column))
}

// this should be a method on World but the generic on struct method bug prevents it
pub fn new_component<T>(w &World, id string) Entity {
	return Entity {
		id: ecs_new_component(w.world, id.str, sizeof(T)),
		world: w.world
	}
}

pub fn new_comp<T>(w &World) Entity {
	return Entity {
		id: ecs_new_component(w.world, nameof(T).str, sizeof(T)),
		world: w.world
	}
}

pub fn get_context<T>(world &World) &T {
	return &T(C.ecs_get_context(world.world))
}

pub fn get_system_context<T>(world &C.ecs_world_t, system u64) &T {
	return &T(C.ecs_get_system_context(world, system))
}