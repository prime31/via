module arcade
import via.math
import via.physics as phy

pub struct Manifold {
mut:
	count int
	depth f32
	contact_pt math.Vec2
	// always points from shape A to shape B (first and second shapes passed into any of the functions)
	normal math.Vec2
}

pub fn (m mut Manifold) invert() Manifold {
	m.normal = m.normal.scale(-1)
	return m
}


pub fn collide(a, b &phy.Collider, move math.Vec2) Manifold {
	if !a.collides_with(b) {
		return Manifold{}
	}

	match a.kind {
		.aabb {
			match b.kind {
				.aabb {
					return aabb_to_aabb(&phy.AabbCollider(a), &phy.AabbCollider(b), move)
				}
				.circle {
					mut mani := circle_to_aabb(&phy.CircleCollider(b), &phy.AabbCollider(a), move.scale(-1))
					return mani.invert()
				}
				else { return Manifold{} }
			}
		}
		.circle {
			match b.kind {
				.aabb {
					return circle_to_aabb(&phy.CircleCollider(a), &phy.AabbCollider(b), move)
				}
				.circle {
					return circle_to_circle(&phy.CircleCollider(a), &phy.CircleCollider(b), move)
				}
				else { return Manifold{} }
			}
		}
		else { return Manifold{} }
	}
}


pub fn aabb_to_aabb(a, b phy.AabbCollider, move math.Vec2) Manifold {
	mut mani := Manifold{}

	amin := a.min() + move
	amax := a.max() + move
	bmin := b.min()
	bmax := b.max()

	mid_a := (amin + amax).scale(0.5)
	mid_b := (bmin + bmax).scale(0.5)

	ea := (amax - amin).scale(0.5).abs()
	eb := (bmax - bmin).scale(0.5).abs()
	d := mid_b - mid_a

	// calc overlap on x and y axes
	dx := ea.x + eb.x - math.fabs(d.x)
	if dx < 0 {
		return mani
	}

	dy := ea.y + eb.y - math.fabs(d.y)
	if dy < 0 {
		return mani
	}

	mani.count = 1
	// x axis overlap is smaller
	if dx < dy {
		mani.depth = dx
		if d.x < 0 {
			mani.normal = math.Vec2{-1, 0}
			mani.contact_pt = mid_a - math.Vec2{ea.x, 0}
		} else {
			mani.normal = math.Vec2{1, 0}
			mani.contact_pt =mid_a + math.Vec2{ea.x, 0}
		}
	} else { // y axis overlap is smaller
		mani.depth = dy
		if d.y < 0 {
			mani.normal = math.Vec2{0, -1}
			mani.contact_pt = mid_a - math.Vec2{0, ea.y}
		} else {
			mani.normal = math.Vec2{0, 1}
			mani.contact_pt = mid_a + math.Vec2{0, ea.y}
		}
	}

	return mani
}

pub fn circle_to_aabb(a phy.CircleCollider, b phy.AabbCollider, move math.Vec2) Manifold {
	mut mani := Manifold{}

	p := math.Vec2{a.x, a.y} + move
	l := math.clampv(p, b.min(), b.max())
	ab := l - p
	d2 := ab.dot(ab)
	r2 := a.r * a.r

	if d2 < r2 {
		// shallow (center of circle not inside of AABB)
		if d2 != 0 {
			d := math.sqrt(d2)
			n := ab.normalize()
			mani.count = 1
			mani.depth = a.r - d
			mani.contact_pt = p + n.scale(d)
			mani.normal = n
		} else { // deep (center of circle inside of AABB). clamp circle's center to edge of AABB, then form the manifold
			mid := (b.min() + b.max()).scale(0.5)
			e := (b.max() - b.min()).scale(0.5)
			d := p - mid
			abs_d := math.absv(d)

			x_overlap := e.x - abs_d.x
			y_overlap := e.y - abs_d.y

			mut depth := 0.0
			if x_overlap < y_overlap {
				depth = x_overlap
				n := math.Vec2{1, 0}
				mani.normal = n.scale(math.take(d.x < 0, 1, -1))
			} else {
				depth = y_overlap
				n := math.Vec2{0, 1}
				mani.normal = n.scale(math.take(d.y < 0, 1, -1))
			}

			mani.count = 1
			mani.depth = a.r + depth
			mani.contact_pt = p - mani.normal.scale(depth)
		}
	}

	return mani
}

pub fn circle_to_circle(a, b phy.CircleCollider, move math.Vec2) Manifold {
	mut mani := Manifold{}

	bpos := math.Vec2{b.x, b.y}
	apos := math.Vec2{a.x, a.y} + move
	d := bpos - apos
	d2 := d.dot(d)
	r := a.r + b.r
	if d2 < r * r {
		l := math.sqrt(d2)
		mani.normal = math.take(l != 0, d.scale(1.0 / l), math.Vec2{0, 1})
		mani.count = 1
		mani.depth = r - l
		mani.contact_pt = bpos - mani.normal.scale(b.r)
	}

	return mani
}