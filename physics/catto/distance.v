module catto
import via.math

const (
	max_iters = 20
)

struct SimplexVert {
pub mut:
	point1 math.Vec2	// support point in polygon1
	point2 math.Vec2	// support point in polygon2
	point math.Vec2		// point2 - point1
	u f32				// unnormalized barycentric coordinate for closest point
	index1 int			// point1 index
	index2 int			// point2 index
}

pub struct Simplex {
pub mut:
	vert_a SimplexVert
	vert_b SimplexVert
	vert_c SimplexVert
	divisor f32			// denominator to normalize barycentric coordinates
	count int
}

pub fn (s &Simplex) get_search_dir() math.Vec2 {
	match s.count {
		1 { return s.vert_a.point.scale(-1) }
		2 {
			edge_ab := s.vert_b.point - s.vert_a.point
			sgn := edge_ab.cross(s.vert_a.point.scale(-1))
			if sgn > 0 {
				// origin is left of edge_ab
				return math.Vec2{-edge_ab.y, edge_ab.x}
			} else {
				// origin is right of edge_ab
				return math.Vec2{edge_ab.y, -edge_ab.x}
			}
		}
		else { assert false }
	}
	panic('')
}

pub fn (s &Simplex) get_closest_pt() math.Vec2 {
	match s.count {
		1 { return s.vert_a.point }
		2 {
			ss := 1.0 / s.divisor
			return s.vert_a.point.scale(ss * s.vert_a.u) + s.vert_b.point.scale(ss * s.vert_b.u)
		}
		3 { return math.Vec2{} }
		else { assert false }
	}
	panic('')
}

pub fn (s &Simplex) get_witness_pts() (math.Vec2, math.Vec2) {
	match s.count {
		1 {
			return s.vert_a.point1, s.vert_a.point1
		}
		2 {
			ss := 1.0 / s.divisor
			pt1 := s.vert_a.point1.scale(ss * s.vert_a.u) + s.vert_b.point1.scale(ss * s.vert_b.u)
			pt2 := s.vert_a.point2.scale(ss * s.vert_a.u) + s.vert_b.point2.scale(ss * s.vert_b.u)
			return pt1, pt2
		}
		3 {
			ss := 1.0 / s.divisor
			pt := s.vert_a.point1.scale(ss * s.vert_a.u) + s.vert_b.point1.scale(ss * s.vert_b.u) + s.vert_c.point1.scale(ss * s.vert_c.u)
			return pt, pt
		}
		else { assert false }
	}
	panic('')
}

// Closest point on line segment to Q. Voronoi regions: A, B, AB
pub fn (s mut Simplex) solve2(q math.Vec2) {
	a := s.vert_a.point
	b := s.vert_b.point

	// Compute barycentric coordinates (pre-division)
	u := (q - b).dot(a - b)
	v := (q - a).dot(b - a)

	// region a
	if v <= 0 {
		// Simplex is reduced to just vert 1
		s.vert_a.u = 1
		s.divisor = 1
		s.count = 1
		return
	}

	// region b
	if u <= 0 {
		// Simplex is reduced to just vert b. We move vert b into vert a and reduce the count
		s.vert_a = s.vert_b
		s.vert_a.u = 1
		s.divisor = 1
		s.count = 1
		return
	}

	// region ab. Due to the conditions above, we are guaranteed the edge has non-zero length
	// so division is safe
	s.vert_a.u = u
	s.vert_b.u = v
	e := b - a
	s.divisor = e.dot(e)
	s.count = 2
}

// Closest point on triangle to Q. Voronoi regions: A, B, C, AB, BC, CA, ABC
pub fn (s mut Simplex) solve3(q math.Vec2) {
	a := s.vert_a.point
	b := s.vert_b.point
	c := s.vert_c.point

	// Compute barycentric coordinates (pre-division)
	u_ab := (q - b).dot(a - b)
	v_ab := (q - a).dot(b - a)

	u_bc := (q - c).dot(b - c)
	v_bc := (q - b).dot(c - b)

	u_ca := (q - a).dot(c - a)
	v_ca := (q - c).dot(a - c)

	// region a
	if v_ab <= 0 && u_ca <= 0 {
		s.vert_a.u = 1
		s.divisor = 1
		s.count = 1
		return
	}

	// region b
	if u_ab <= 0 && v_bc <= 0 {
		s.vert_a = s.vert_b
		s.vert_a.u = 1
		s.divisor = 1
		s.count = 1
		return
	}

	// region c
	if u_bc <= 0 && v_ca <= 0 {
		s.vert_a = s.vert_c
		s.vert_a.u = 1
		s.divisor = 1
		s.count = 1
		return
	}

	// compute signed trangle area
	area := (b - a).cross(c - a)

	// Compute triangle barycentric coordinates (pre-division)
	u_abc := (b - q).cross(c - q)
	v_abc := (c - q).cross(a - q)
	w_abc := (a - q).cross(b - q)

	// region ab
	if u_ab > 0 && v_ab > 0 && w_abc * area <= 0 {
		s.vert_a.u = u_ab
		s.vert_b.u = v_ab
		e := b - a
		s.divisor = e.dot(e)
		s.count = 2
		return
	}

	// region bc
	if u_bc > 0 && v_bc > 0 && u_abc * area <= 0 {
		s.vert_a = s.vert_b
		s.vert_b = s.vert_c

		s.vert_a.u = u_ca
		s.vert_b.u = v_ca
		e := a - c
		s.divisor = e.dot(e)
		s.count = 2
		return
	}

	// region abc, the triangle area is guaranteed to be non-zero
	assert u_abc > 0 && v_abc > 0 && w_abc > 0
	s.vert_a.u = u_abc
	s.vert_b.u = v_abc
	s.vert_c.u = w_abc
	s.divisor = area
	s.count = 3
}

// Compute the distance between two polygons using the GJK algorithm
pub fn distance(input Input) Output {
	mut output := Output{}

	poly1 := input.polygon1
	poly2 := input.polygon2

	trans1 := input.trans1
	trans2 := input.trans2

	// init the Simplex
	mut simplex := Simplex{}
	local_pt1 := poly1.points[0]
	local_pt2 := poly2.points[0]
	simplex.vert_a.point1 = trans1.mul(local_pt1)
	simplex.vert_a.point2 = trans2.mul(local_pt2)
	simplex.vert_a.u = 1
	simplex.count = 1

	// Get simplex vertices as an array.
	vertices := &simplex.vert_a

	// These store the vertices of the last simplex so that we can check for duplicates and prevent cycling
	mut save1 := [0,0,0]!!
	mut save2 := [0,0,0]!!
	mut save_ct := 0

	// main loop
	mut iter := 0
	for iter < max_iters {
		// Copy simplex so we can identify duplicates
		save_ct = simplex.count
		for i in 0..save_ct {
			save1[i] = vertices[i].index1
			save2[i] = vertices[i].index2
		}

		// determine the closest point on the simplex and remove unused verts
		match simplex.count {
			1 { break }
			2 { simplex.solve2(math.Vec2{}) }
			3 { simplex.solve3(math.Vec2{}) }
			else { assert false }
		}

		// record for visualization
		output.simplices << simplex

		// if we have 3 points, then the origin in in the corresponding triangle
		if simplex.count == 3 { break }

		// get search direction and ensure it is non-zero
		d := simplex.get_search_dir()
		if d.dot(d) == 0 { break }

		// compute a tentative new simplex vert using support points
		mut vertex := vertices + simplex.count
		vertex.index1 = poly1.get_support(trans1.r.mul_t(d.scale(-1)))
		vertex.point1 = trans1.mul(poly1.points[vertex.index1])
		vertex.index2 = poly2.get_support(trans2.r.mul_t(d))
		vertex.point2 = trans2.mul(poly2.points[vertex.index2])
		vertex.point = vertex.point2 - vertex.point1

		iter++

		// Check for duplicate support points. This is the main termination criteria.
		mut dupe := false
		for i in 0..save_ct {
			if (vertex.index1 == save1[i] && vertex.index2 == save2[i]) {
				dupe = true
				break
			}
		}

		// If we found a duplicate support point we must exit to avoid cycling.
		if dupe { break }

		// new vertex is ok and needed
		simplex.count++
	}

	p1, p2 := simplex.get_witness_pts()
	output.point1 = p1
	output.point2 = p2
	output.distance = output.point1.distance_to(output.point2)
	output.iterations = iter

	return output
}



//#region Input/Output structs

pub struct Polygon {
pub mut:
	points []math.Vec2
}

pub fn (p &Polygon) get_support(d math.Vec2) int {
	mut best_index := 0
	mut best_value := p.points[0].dot(d)

	for i in 1..p.points.len {
		val := p.points[i].dot(d)
		if val > best_value {
			best_index = i
			best_value = val
		}
	}

	return best_index
}

pub struct Transform {
pub mut:
	r Mat22
	p math.Vec2
}

pub fn (t &Transform) mul(v math.Vec2) math.Vec2 {
	return t.r.mul(v) + t.p
}

pub struct Mat22 {
pub mut:
	col1 math.Vec2
	col2 math.Vec2
}

pub fn mat22(angle f32) Mat22 {
	mut m := Mat22{}
	m.set_angle(angle)
	return m
}

pub fn (m &Mat22) mul(v math.Vec2) math.Vec2 {
	return math.Vec2 {
		x: m.col1.x * v.x + m.col2.x * v.y
		y: m.col1.y * v.x + m.col2.y * v.y
	}
}

// result = Transpose(A) * v
pub fn (m &Mat22) mul_t(v math.Vec2) math.Vec2 {
	return math.Vec2 {
		x: m.col1.dot(v)
		y: m.col2.dot(v)
	}
}

pub fn (m mut Mat22) set_angle(angle f32) {
	sin, cos := math.sincos(angle)
	m.col1.x = cos
	m.col1.y = sin
	m.col2.x = -sin
	m.col2.y = cos
}

pub struct Input {
pub mut:
	polygon1 Polygon
	polygon2 Polygon
	trans1 Transform
	trans2 Transform
}

pub struct Output {
pub mut:
	point1 math.Vec2
	point2 math.Vec2
	distance f32
	iterations int

	simplices []Simplex
}

//#endregion