module gjk
import via.math
import via.physics

// https://github.com/hamaluik/headbutt
// https://blog.hamaluik.ca/posts/building-a-collision-engine-part-1-2d-gjk-collision-detection/
// https://blog.hamaluik.ca/posts/building-a-collision-engine-part-2-2d-penetration-vectors/

const (
	max_gjk_iters = 30
	max_epa_iters = 30
	detect_epsilon = 0.0
	distance_epsilon = 0.001
)

pub struct Gjk {
	expanding_simplex ExpandingSimplex = ExpandingSimplex{}
mut:
	simplex []math.Vec2
}

pub struct Penetration {
pub mut:
	normal math.Vec2	// normalized axis of projection
	depth f32			// penetration amount on this axis
}

pub fn (p Penetration) str() string {
	return 'depth: $p.depth, norm: $p.normal'
}


pub fn (g mut Gjk) intersects(shape1, shape2 &physics.Collider, trans1, trans2 math.RigidTransform) (bool, Penetration) {
	if g.overlaps(shape1, shape2, trans1, trans2) {
		p := g.get_penetration(shape1, shape2, trans1, trans2)
		return true, p
	}
	return false, Penetration{}
}

pub fn (g mut Gjk) overlaps(shape1, shape2 &physics.Collider, trans1, trans2 math.RigidTransform) bool {
	g.simplex.clear()

	// choose an initial search direction
	mut dir := math.Vec2{1, 0}

	// add the first point
	g.simplex << get_support_point(dir, shape1, shape2, trans1, trans2)

	// is the support point past the origin along dir?
	if g.simplex[0].dot(dir) <= 0 {
		return false
	}

	// negate the direction
	dir = dir.scale(-1)

	// start the loop
	for _ in 0..max_gjk_iters {
		// always add another point to the simplex at the beginning of the loop
		sup_pt := get_support_point(dir, shape1, shape2, trans1, trans2)
		g.simplex << sup_pt

		// make sure the last point we added was past the origin
		if sup_pt.dot(dir) >= 0 {
			if g.check_simplex(mut dir) {
				// if the simplex contains the origin then we know that there is an intersection.
				return true
			}
		}
	}

	return false
}

fn triple_prod(a, b, c math.Vec2) math.Vec2 {
	dot := a.x * b.y - b.x * a.y
	return math.Vec2{-c.y * dot, c.x * dot}
}

fn get_support_point(dir math.Vec2, shape1, shape2 &physics.Collider, trans1, trans2 math.RigidTransform) math.Vec2 {
	return shape1.get_farthest_pt(dir, trans1) - shape2.get_farthest_pt(dir.scale(-1), trans2)
}

fn (g mut Gjk) check_simplex(dir mut math.Vec2) bool {
	if g.simplex.len == 3 {
		c0 := g.simplex[2].scale(-1)
		bc := g.simplex[1] - g.simplex[2]
		ca := g.simplex[0] - g.simplex[2]

		bc_norm := triple_prod(ca, bc, bc)
		ca_norm := triple_prod(bc, ca, ca)

		if bc_norm.dot(c0) > 0 {
			g.simplex.delete(0)
			*dir = bc_norm
		} else if ca_norm.dot(c0) > 0 {
			g.simplex.delete(1)
			*dir = ca_norm
		} else {
			return true
		}
	} else if g.simplex.len == 2 {
		// get the b point
		ab := g.simplex[1] - g.simplex[0]
		a0 := g.simplex[0].scale(-1)

		*dir = triple_prod(ab, a0, ab)

		// check for degenerate cases where the origin lies on the segment created by a -> b which will yield a
		// zero edge normal
		if dir.square_magnitude() <= distance_epsilon
		{
			// in this case just choose either normal (left or right)
			*dir = math.Vec2{ab.y, -ab.x}
		}
	} else if g.simplex.len == 1 {
		*dir = dir.scale(-1)
	}

	return false
}

fn (g mut Gjk) get_penetration(shape1, shape2 &physics.Collider, trans1, trans2 math.RigidTransform) Penetration {
	mut penetration := Penetration{}
	g.expanding_simplex.start(g.simplex)

	for i in 0..max_epa_iters {
        // get the closest edge to the origin
        edge := g.expanding_simplex.closest_edge()

        // get a new support point in the direction of the edge normal
        point := get_support_point(edge.normal, shape1, shape2, trans1, trans2)

        // see if the new point is significantly past the edge
        projection := point.dot(edge.normal)
        if projection - edge.distance < distance_epsilon {
            // then the new point we just made is not far enough in the direction of n so we can stop now and
            // return n as the direction and the projection as the depth since this is the closest found
            // edge and it cannot increase any more
            penetration.normal = edge.normal
            penetration.depth = projection
            return penetration
        }

        // lastly add the point to the simplex. this breaks the edge we just found to be closest into two edges
        // from a -> b to a -> newPoint -> b
        g.expanding_simplex.expand(point)

        if i == max_epa_iters - 1 {
            // if we made it here then we know that we hit the maximum number of iterations. this is really a catch
			// all termination case. set the normal and depth equal to the last edge we created
            penetration.normal = edge.normal
            penetration.depth = point.dot(edge.normal)
        }
	}

	return penetration
}