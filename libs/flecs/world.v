module flecs
import via.libs.flecs.c

const ( version = c.version )

pub struct World {
pub:
	world &C.ecs_world_t
}

pub fn (w World) str() string { return '${&w.world}' }

pub fn init_world() World {
	return World {
		world: ecs_init()
	}
}

pub fn (w &World) set_context(ctx voidptr) {
	C.ecs_set_context(w.world, ctx)
}

// should be a generic
pub fn (w &World) get_context() voidptr {
	return C.ecs_get_context(w.world)
}

pub fn (w &World) set_system_context(system u64, ctx voidptr) {
	C.ecs_set_system_context(w.world, system, ctx)
}

// should be a generic
pub fn (w &World) get_system_context(system u64) voidptr {
	return C.ecs_get_system_context(w.world, system)
}

// runs into generic bug if called with the same T twice.
pub fn (w &World) new_component<T>(id string) Entity {
	return Entity {
		id: C.ecs_new_component(w.world, id.str, sizeof(T)),
		world: w.world
	}
}

pub fn (w &World) new_component_t(id string, size int) Entity {
	return Entity {
		id: C.ecs_new_component(w.world, id.str, size),
		world: w.world
	}
}

pub fn (w &World) type_from_entity(entity Entity) C.ecs_type_t {
	return ecs_type_from_entity(w.world, entity.id)
}

pub fn (w &World) new_system(id string, kind c.EcsSystemKind, sig string, action fn(&C.ecs_rows_t)) Entity {
	return Entity {
		id: ecs_new_system(w.world, id.str, kind, sig.str, action)
		world: w.world
	}
}

pub fn (w &World) new_entity(id string, components string) Entity {
	return Entity {
		id: ecs_new_entity(w.world, id.str, components.str)
		world: w.world
	}
}

pub fn (w &World) progress(delta_time f32) bool {
	return ecs_progress(w.world, delta_time)
}