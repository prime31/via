module physics
import via.math

pub enum ColliderType {
	aabb
	circle
}

//#region Collider

// common base data for all Collider sub-types
pub struct Collider {
	kind ColliderType
	trigger bool
	filter CollisionFilter
}

fn collider(kind ColliderType) Collider {
	return Collider{
		kind: kind
		filter: CollisionFilter{}
	}
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
	collider Collider
	x f32
	y f32
	w f32
	h f32
}

pub fn (b AabbCollider) str() string {
	return 'x:$b.x, y:$b.y, w:$b.w, h:$b.h, trigger:$b.collider.trigger'
}

pub fn aabbcollider(x, y, w, h f32) AabbCollider {
	return AabbCollider{
		collider: collider(.aabb)
		x: x
		y: y
		w: w
		h: h
	}
}

pub fn (c &AabbCollider) get_bounds() math.RectF {
	return math.RectF{c.x, c.y, c.w, c.h}
}

//#endregion

//#region Circle

pub struct CircleCollider {
	collider Collider
	x f32
	y f32
	r f32
}

pub fn (c CircleCollider) str() string {
	return 'x:$c.x, y:$c.y, r:$c.r, trigger:$c.collider.trigger'
}

pub fn circlecollider(x, y, r f32) CircleCollider {
	return CircleCollider{
		collider: collider(.circle)
		x: x
		y: y
		r: r
	}
}

pub fn (c &CircleCollider) get_bounds() math.RectF {
	return math.RectF{c.x - c.r, c.y - c.r, c.r * 2.0, c.r * 2.0}
}

//#endregion