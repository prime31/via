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

pub fn (c &Collider) get_farthest_pt(dir math.Vec2, trans math.RigidTransform) math.Vec2 {
	match c.kind {
		.aabb {
			aabb := &AabbCollider(c)
			return aabb.get_farthest_pt(dir, trans)
		} .circle {
			circle := &CircleCollider(c)
			return circle.get_farthest_pt(dir, trans)
		} else {
			panic('unknown ColliderType')
		}
	}
}

pub fn (c &Collider) collides_with(other &Collider) bool {
	return c.filter.collides_with(other.filter)
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

pub fn (c &AabbCollider) get_farthest_pt(dir math.Vec2, trans math.RigidTransform) math.Vec2 {

	return math.Vec2{}
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

pub fn (c &CircleCollider) get_farthest_pt(dir math.Vec2, trans math.RigidTransform) math.Vec2 {
	dir_norm := dir.normalize()
	center := trans.get_transformed(math.Vec2{c.x, c.y})

	// add the radius along the vector to the center to get the farthest point
	return center + dir_norm.scale(c.r)
}

//#endregion

//#region Polygon

pub struct PolygonCollider {
	collider Collider
	verts []math.Vec2
}

pub fn (c PolygonCollider) str() string {
	return 'verts:$c.verts, trigger:$c.collider.trigger'
}

pub fn polygoncollider(x, y, r f32) CircleCollider {
	return CircleCollider{
		collider: collider(.circle)
		x: x
		y: y
		r: r
	}
}

pub fn (c &PolygonCollider) get_bounds() math.RectF {
	return math.RectF{0, 0, 0, 0}
}

pub fn (c &PolygonCollider) get_farthest_pt(dir math.Vec2, trans math.RigidTransform) math.Vec2 {
	mut furthest_dist := 99999999.9
	mut furthest_vert := math.Vec2{}

	for v in c.verts {
		dist := v.dot(dir)
		if dist > furthest_dist {
			furthest_dist = dist
			furthest_vert = v
		}
	}

	return furthest_vert
}

//#endregion