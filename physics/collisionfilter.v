module physics

pub struct CollisionFilter {
pub mut:
	category u32 = u32(0xffffffff) 	// A bit mask describing which layers this object belongs to
	mask u32 = u32(0xffffffff)		// A bit mask describing which layers this object can collide with
}

pub fn (cf &CollisionFilter) is_valid() bool {
	return cf.category > 0 && cf.mask > 0
}

pub fn (a &CollisionFilter) collides_with(b &CollisionFilter) bool {
	return a.category & b.mask != 0 && b.category & a.mask != 0
}