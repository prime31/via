module physics
import via.math

pub enum ColliderType {
	aabb
	circle
}

//#region Collider

// all colliders must have all of these fields in this order in their struct
pub struct Collider {
	kind ColliderType
	trigger bool
	filter CollisionFilter
}

pub fn (c &Collider) get_bounds() math.RectF {
	match c.kind {
		.aabb {
			aabb := &AabbCollider(c)
			return aabb.get_bounds()
		} .circle {
			circle := &CircleCollider(c)
			return circle.get_bounds()
		} else {
			panic('unknown ColliderType')
		}
	}
}

//#endregion

//#region AABB

pub struct AabbCollider {
	kind ColliderType
	trigger bool
	filter CollisionFilter
	x f32
	y f32
	w f32
	h f32
}

pub fn (c &AabbCollider) get_bounds() math.RectF {
	return math.RectF{c.x, c.y, c.w, c.h}
}

//#endregion

//#region Circle

pub struct CircleCollider {
	kind ColliderType
	trigger bool
	filter CollisionFilter
	x f32
	y f32
	r f32
}

pub fn (c &CircleCollider) get_bounds() math.RectF {
	return math.RectF{c.x - c.r, c.y - c.r, c.r * 2.0, c.r * 2.0}
}

//#endregion