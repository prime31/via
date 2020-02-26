module physics
import via.math
import via.debug

pub enum ColliderKind {
	aabb
	circle
	polygon
}

//#region Collider

// common base data for all Collider sub-types
pub struct Collider {
pub:
	kind ColliderKind
	trigger bool
	filter CollisionFilter
}

fn collider(kind ColliderKind) Collider {
	return Collider{
		kind: kind
		filter: collisionfilter()
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
		} .polygon {
			poly := &PolygonCollider(c)
			return poly.get_bounds()
		} else {
			panic('unknown ColliderKind')
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
		} .polygon {
			poly := &PolygonCollider(c)
			return poly.get_farthest_pt(dir, trans)
		} else {
			panic('unknown ColliderKind')
		}
	}
}

pub fn (c &Collider) collides_with(other &Collider) bool {
	return c.filter.collides_with(other.filter)
}

//#endregion

//#region AABB

pub struct AabbCollider {
pub:
	collider Collider
mut:
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
	// transform the direction into local space
	mut direction := dir
	trans.inverse_transform_rot(mut direction)

	verts := [math.Vec2{c.x, c.y}, math.Vec2{c.x + c.w, c.y}, math.Vec2{c.x + c.w, c.y + c.h}, math.Vec2{c.x, c.y + c.h}]!
	mut furthest_dist := (verts[0] + trans.pos).dot(direction)
	mut furthest_vert := verts[0]

	for i in 1..verts.len {
		tmp_v := verts[i] + trans.pos
		dist := tmp_v.dot(direction)
		if dist > furthest_dist {
			furthest_dist = dist
			furthest_vert = verts[i]
		}
	}

	// println('-------- Box dist: $furthest_dist, vrt: $furthest_vert')
	debug.draw_point(furthest_vert.x, furthest_vert.y, 4, math.white())

	return furthest_vert
}

pub fn (c &AabbCollider) min() math.Vec2 {
	return math.Vec2{c.x, c.y}
}

pub fn (c &AabbCollider) max() math.Vec2 {
	return math.Vec2{c.x + c.w, c.y + c.h}
}

//#endregion

//#region Circle

pub struct CircleCollider {
pub:
	collider Collider
mut:
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
	center := math.Vec2{c.x, c.y} + trans.pos

	ret := center + dir_norm.scale(c.r)
	debug.draw_point(ret.x, ret.y, 4, math.blue())
	// println('------ dir: $dir, dir_norm: $dir_norm,  rad scaled: ${dir_norm.scale(c.r)}')

	// add the radius along the vector to the center to get the farthest point
	return center + dir_norm.scale(c.r)
}

//#endregion

//#region Polygon

pub struct PolygonCollider {
pub:
	collider Collider
mut:
	x f32
	y f32
	verts []math.Vec2
}

pub fn (c PolygonCollider) str() string {
	return 'verts:$c.verts, trigger:$c.collider.trigger'
}

pub fn polygoncollider(x, y f32, verts []math.Vec2) PolygonCollider {
	return PolygonCollider{
		collider: collider(.polygon)
		x: x
		y: y
		verts: verts.clone()
	}
}

pub fn (c &PolygonCollider) get_bounds() math.RectF {
	return math.RectF{0, 0, 0, 0}
}

pub fn (c &PolygonCollider) get_farthest_pt(dir math.Vec2, trans math.RigidTransform) math.Vec2 {
	// transform the direction into local space
	mut direction := dir
	trans.inverse_transform_rot(mut direction)

	pos := math.Vec2{c.x, c.y}
	//v1 := trans.get_transformed(c.verts[0]) + pos // TODO: add rotation support
	v1 := c.verts[0] + trans.pos + pos
	mut furthest_dist := v1.dot(direction)
	mut furthest_vert := v1

	for i in 1..c.verts.len {
		tmp_v := c.verts[i] + trans.pos + pos
		dist := tmp_v.dot(direction)
		if dist > furthest_dist {
			furthest_dist = dist
			furthest_vert = tmp_v
		}
	}

	// println('-------- Box dist: $furthest_dist, vrt: $furthest_vert')
	debug.draw_point(furthest_vert.x, furthest_vert.y, 4, math.red())

	return furthest_vert
}

//#endregion