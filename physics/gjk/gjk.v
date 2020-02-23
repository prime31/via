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

pub fn (g mut Gjk) intersects(shape1, shape2 &physics.Collider, trans1, trans2 math.RigidTransform) &Penetration {
	if g.overlaps(shape1, shape2, trans1, trans2) {
		p := g.get_penetration(shape1, shape2, trans1, trans2)
		return &p
	}
	return &Penetration(0)
}

pub fn (g mut Gjk) overlaps(shape1, shape2 &physics.Collider, trans1, trans2 math.RigidTransform) bool {
	g.simplex.clear()

	// choose an initial search direction
	mut dir := math.Vec2{1, 0}

	// add the first point
	g.simplex << get_support_point(dir, shape1, shape2, trans1, trans2)

	// is the support point past the origin along d?
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

		// make sure the last point we added was past teh origin
		if sup_pt.dot(dir) <= detect_epsilon {
			// pt is not past the origin so therefore the shapes do not intersect. here we treat the origin
			// on the line as no intersection and immediately return with indicating no penetration
			return false
		} else {
			// if it is past the origin, then test whether the simplex contains the origin
			if g.check_simplex(mut dir) {
				// if the simplex contains the origin then we know that there is an intersection.
				return true
			}
			// if the simplex does not contain the origin then we need to loop using the new
			// search direction and simplex
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
	// this method should never be supplied anything other than 2 or 3 points for the simplex
	assert g.simplex.len >= 2

	// get the last point added (a)
	a := g.simplex.last()

	// this is the same as a.to(ORIGIN)
	ao := a.scale(-1)

	// check to see what type of simplex we have
	if g.simplex.len == 3 {
		// we have a triangle
		b := g.simplex[1]
		c := g.simplex[2]

		// get the edges
		ab := b - a
		ac := c - a

		// get the edge normal

		// inline triple_project so we can use the intermediate calcs for the second triple_product calc
		dot := ab.x * ac.y - ac.x * ab.y
		ac_perp := math.Vec2{-ac.y * dot, ac.x * dot}

		// see where the origin is
		ac_loc := ac_perp.dot(ao)
		if ac_loc >= 0 {
			// the origin lies on the right side of A->C
			// because of the condition for the gjk loop to continue the origin
			// must lie between A and C so remove B and set the
			// new search direction to A->C perpendicular vector
			g.simplex.delete(1)

			// this used to be direction.set(triple_product(ac, ao, ac));
			// but was changed since the origin may lie on the segment created
			// by a -> c in which case would produce a zero vector normal
			// calculating ac's normal using b is more robust
			*dir = ac_perp
		} else {
			// inline triple_project so we can use the intermediate calcs again
			ab_perp := math.Vec2{ab.y * dot, -ab.x * dot}
			ab_loc := ab_perp.dot(ao)

			// the origin lies on the left side of A->C
			if ab_loc < 0 {
				// the origin lies on the right side of A->B and therefore is in the
				// triangle, we have an intersection
				return true
			} else{
				// the origin lies between A and B so remove C and set the search direction to A->B perpendicular vector
				g.simplex.delete(0)

				// this used to be direction.set(triple_product(ab, ao, ab)) but was changed since the origin may
				// lie on the segment created by a -> b in which case would produce a zero vector normal
				// calculating ab's normal using c is more robust
				*dir = ab_perp
			}
		}
	} else {
		// get the b point
		b := g.simplex[0]
		ab := b - a

		// otherwise we have 2 points (line segment) because of the condition for the gjk loop to continue the origin
		// must lie in between A and B, so keep both points in the simplex and
		// set the direction to the perp of the line segment towards the origin
		*dir = triple_prod(ab, ao, ab)

		// check for degenerate cases where the origin lies on the segment created by a -> b which will yield a
		// zero edge normal
		if dir.square_magnitude() <= distance_epsilon
		{
			// in this case just choose either normal (left or right)
			*dir = math.Vec2{ab.y, -ab.x}
		}
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
        if projection - edge.distance < distance_epsilon
        {
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