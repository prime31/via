module gjk
import via.math

struct ExpandingSimplex {
mut:
	winding int
	edge_queue []ExpandingSimplexEdge
}

struct ExpandingSimplexEdge {
mut:
	pt1 math.Vec2
	pt2 math.Vec2
	normal math.Vec2
	distance f32
}

fn (es &ExpandingSimplex) free() {
	unsafe { es.edge_queue.free() }
}

fn simplexedge(pt1, pt2 math.Vec2, winding int) ExpandingSimplexEdge {
	mut e := ExpandingSimplexEdge{
		pt1: pt1
		pt2: pt2
	}

	// depending on the winding get the edge normal. it would be better to use tripleProduct(ab, ao, ab);
	// where ab is the edge and ao is a.to(ORIGIN) but this will return an incorrect normal if the origin
	// lies on the ab segment therefore we use the winding of the simplex to determine the normal direction
	mut tmp_norm := pt2 - pt1
	if winding < 0 {
		tmp_norm = math.Vec2{-tmp_norm.y, tmp_norm.x}
	} else {
		tmp_norm = math.Vec2{tmp_norm.y, -tmp_norm.x}
	}

	e.normal = tmp_norm.normalize()

	// project the first point onto the normal (it doesnt matter which. you project since the normal is
	// perpendicular to the edge)
	e.distance = math.abs(pt1.dot(e.normal))

	return e
}

fn (es mut ExpandingSimplex) start(simplex []math.Vec2) {
	es.edge_queue.clear()
	es.winding = es.get_winding(simplex)

	// build the initial edge queue
	for i in 0..simplex.len {
		j := if i + 1 == simplex.len { 0 } else { i + 1 }

		// add the current edge to the queue
		es.edge_queue << simplexedge(simplex[i], simplex[j], es.winding)
	}
}

fn (es &ExpandingSimplex) get_winding(simplex []math.Vec2) int {
	for i in 0..simplex.len {
		j := if i + 1 == simplex.len { 0 } else { i + 1 }

		cross_ab := simplex[i].cross(simplex[j])
		if cross_ab > 0 {
			return 1
		} else if cross_ab < 0 {
			return -1
		}
	}
	return 0
}

fn (es mut ExpandingSimplex) closest_edge() ExpandingSimplexEdge {
	es.edge_queue.sort_with_compare(compare_edge)
	return es.edge_queue[0]
}

fn (es mut ExpandingSimplex) expand(pt math.Vec2) {
	// remove the edge we are splitting
	es.edge_queue.sort_with_compare(compare_edge)
	edge := es.edge_queue[0]
	es.edge_queue.delete(0)

	es.edge_queue << simplexedge(edge.pt1, pt, es.winding)
	es.edge_queue << simplexedge(pt, edge.pt2, es.winding)
}

pub fn compare_edge(a, b &ExpandingSimplexEdge) int {
	if a.distance < b.distance {
		return -1
	}
	if a.distance > b.distance {
		return 1
	}
	return 0
}