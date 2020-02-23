module tilemap
import via.math

pub struct MapCollisionIter {
	is_h bool
	first_primary int
	last_primary int
	prim_incr int
	first_secondary int
	last_secondary int
	secondary_incr int
mut:
	primary int
	secondary int
}

pub fn mapcollisioniter(map Map, bounds math.Rect, edge math.Edge) MapCollisionIter {
	is_h := edge.horizontal()
	prim_axis := math.take(is_h, math.Axis.x, math.Axis.y)
	op_axis := math.take(prim_axis == .x, math.Axis.y, math.Axis.x)

	op_dir := edge.opposing()
	frst_prim := world_to_tile(map, bounds.side(op_dir), prim_axis)
	lst_prim := world_to_tile(map, bounds.side(edge), prim_axis)
	prim_incr := math.take(edge.max(), 1, -1)

	min := world_to_tile(map, math.take(is_h, bounds.top(), bounds.left()), op_axis)
	mid := world_to_tile(map, math.take(is_h, bounds.centery(), bounds.centerx()), op_axis)
	max := world_to_tile(map, math.take(is_h, bounds.bottom(), bounds.right()), op_axis)

	is_pos := mid - min < max - mid
	frst_secondary := math.take(is_pos, min, max)
	lst_secondary := math.take(!is_pos, min, max)
	secondary_incr := math.take(is_pos, 1, -1)

	return MapCollisionIter{
		is_h: is_h
		first_primary: frst_prim
		last_primary: lst_prim
		prim_incr: prim_incr
		first_secondary: frst_secondary
		last_secondary: lst_secondary
		secondary_incr: secondary_incr
		primary: frst_prim
		secondary: frst_secondary - secondary_incr
	}
}

pub fn (i mut MapCollisionIter) next() bool {
	// increment the inner loop
	i.secondary += i.secondary_incr
	if i.secondary != i.last_secondary + i.secondary_incr {
		return true
	}

	// reset the inner loop
	i.secondary = i.first_secondary

	// increment the outer loop
	i.primary += i.prim_incr
	if i.primary == i.last_primary + i.prim_incr {
		return false
	}

	return true
}

pub fn (i &MapCollisionIter) current() (int, int) {
	return math.take(i.is_h, i.primary, i.secondary), math.take(!i.is_h, i.primary, i.secondary)
}

fn world_to_tile(map Map, pos int, axis math.Axis) int {
	return math.take(axis == .x, map.world_to_tilex(pos), map.world_to_tiley(pos))
}