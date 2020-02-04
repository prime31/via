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

pub fn (w &World) new_component(id string, size i64) Entity {
	return Entity {
		id: ecs_new_component(w.world, id.str, size),
		world: w.world
	}
}

pub fn (w &World) type_from_entity(entity Entity) C.ecs_type {
	return ecs_type_from_entity(w.world, entity.id)
}

pub fn (w &World) new_system(id string, system_kind int, sig string, action fn(&C.ecs_rows_t)) Entity {
	return Entity {
		id: ecs_new_system(w.world, id.str, system_kind, sig.str, action)
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