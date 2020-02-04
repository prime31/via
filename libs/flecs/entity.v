module flecs

pub struct Entity {
pub:
	id u64
	world &C.ecs_world_t
}

pub fn (e Entity) str() string { return 'id=$e.id, world=$e.world' }

pub fn (e &Entity) set_ptr(comp_entity Entity, size i64, ptr voidptr) Entity {
	return Entity {
		id: _ecs_set_ptr(e.world, e.id, comp_entity.id, size, ptr),
		world: e.world
	}
}

pub fn (e &Entity) set_ptr_t<T>(comp_entity Entity, ptr &T) Entity {
	return Entity {
		id: _ecs_set_ptr(e.world, e.id, comp_entity.id, sizeof(T), ptr),
		world: e.world
	}
}

pub fn (e &Entity) type_from_entity() C.ecs_type_t {
	return ecs_type_from_entity(e.world, e.id)
}
