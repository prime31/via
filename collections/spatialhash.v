module collections
import via.math

const (
	delta = 1e-10
)

// TODO: should be an interface
pub struct Collider {
pub mut:
	x f32
	y f32
	w f32
	h f32
}

pub fn (h1 &Collider) eq(h2 &Collider) bool {
	return h1.x == h2.x && h1.y == h2.y && h1.w == h2.w && h1.h == h2.h
}

pub fn (i &Collider) get_bounds() math.Rect {
	return math.Rect{i.x as int, i.y as int, i.w as int, i.h as int}
}




pub struct SpatialHash {
	cells IntHashMap
	items IntHashMap
	cell_size int = 50
	inv_cell_size f32 = 1.0 / 50.0
mut:
	id_counter int
	bounds math.Rect
}

struct HashItem {
mut:
	collider Collider
	bounds math.Rect
}
pub fn (i &HashItem) str() string { return 'i' }

struct Cell {
mut:
	list []int
}

fn (c &Cell) free() {
	unsafe {
		//c.list.free()
		free(c)
	}
}

pub fn spatialhash() SpatialHash {
	return &SpatialHash{
		cells: inthashmap()
		items: inthashmap()
	}
}

pub fn (sh mut SpatialHash) free() {
	for x := sh.bounds.x; x <= sh.bounds.right(); x++ {
		for y := sh.bounds.y; y <= sh.bounds.bottom(); y++ {
			cell := sh.cell_at_position(x, y, false)
			cell.free()
		}
	}

	keys := sh.items.keys()
	for key in keys {
		item := *HashItem(sh.items.remove(key))
		unsafe { free(item) }
	}

	unsafe {
		keys.free()
		sh.cells.free()
		sh.items.free()
		// free(sh) // TODO: why does this SIGABRT
	}
}

[inline]
fn get_hashed_key(x, y f32) u32 {
	xi := math.ifloor(x)
	yi := math.ifloor(y)

	tx := u32(xi) * 2209710647
	ty := u32(yi) * 2209710648
	return tx + ty + 2849577407
}

// gets the cell x,y values for a world-space x,y value
fn (sh &SpatialHash) cell_coords(x, y f32) (int, int) {
	return math.ifloor(x * sh.inv_cell_size), math.ifloor(y * sh.inv_cell_size)
}

fn (sh &SpatialHash) cell_coordsi(x, y int) (int, int) {
	return math.ifloor(f32(x) * sh.inv_cell_size), math.ifloor(f32(y) * sh.inv_cell_size)
}

fn (sh mut SpatialHash) cell_at_position(x, y int, create_if_absent bool) &Cell {
	key := get_hashed_key(x, y) as int

	if sh.cells.has(key) {
		return *Cell(sh.cells.get(key))
	} else {
		if create_if_absent {
			cell := &Cell{}
			sh.cells.put(key, cell)
			return cell
		}

		return &Cell(0)
	}
}

fn (sh mut SpatialHash) expand_bounds(x, y, x1, y1 int) {
	// expand our bounds to encompass the new collider
	if !sh.bounds.contains(x, y) {
		sh.bounds = sh.bounds.union_pt(x, y)
	}
	if !sh.bounds.contains(x1, y1) {
		sh.bounds = sh.bounds.union_pt(x1, y1)
	}
}

//#region Collider management

pub fn (sh mut SpatialHash) add(collider Collider) int {
	id := sh.id_counter++

	bounds := collider.get_bounds()
	p1x, p1y := sh.cell_coords(bounds.x, bounds.y)
	p2x, p2y := sh.cell_coords(bounds.right(), bounds.bottom())

	// expand our bounds to encompass the new collider
	sh.expand_bounds(p1x, p1y, p2x, p2y)

	for x := p1x; x <= p2x; x++ {
		for y := p1y; y <= p2y; y++ {
			mut cell := sh.cell_at_position(x, y, true)
			cell.list << id
		}
	}

	sh.items.put(id, &HashItem{collider, bounds})
	return id
}

pub fn (sh mut SpatialHash) remove(id int) {
	item := *HashItem(sh.items.remove(id))
	p1x, p1y := sh.cell_coords(item.bounds.x, item.bounds.y)
	p2x, p2y := sh.cell_coords(item.bounds.right(), item.bounds.bottom())

	for x := p1x; x <= p2x; x++ {
		for y := p1y; y <= p2y; y++ {
			mut cell := sh.cell_at_position(x, y, false)
			cell.list.delete(id)
		}
	}

	unsafe { free(item) }
}

pub fn (sh mut SpatialHash) update(id int, collider Collider) {
	// fetch the item and its new bounds
	mut item := *HashItem(sh.items.get(id))
	bounds := collider.get_bounds()

	// remove from all occupied cells
	p1x, p1y := sh.cell_coords(item.bounds.x, item.bounds.y)
	p2x, p2y := sh.cell_coords(item.bounds.right(), item.bounds.bottom())

	// add to new cells
	np1x, np1y := sh.cell_coords(bounds.x, bounds.y)
	np2x, np2y := sh.cell_coords(bounds.right(), bounds.bottom())

	item.bounds = bounds

	// early out for no change
	if p1x == np1x && p1y == np1y && p2x == np2x && p2y == np2y {
		return
	}

	for x := p1x; x <= p2x; x++ {
		for y := p1y; y <= p2y; y++ {
			mut cell := sh.cell_at_position(x, y, false)
			cell.list.delete(cell.list.index(id))
		}
	}

	sh.expand_bounds(np1x, np1y, np2x, np2y)

	for x := np1x; x <= np2x; x++ {
		for y := np1y; y <= np2y; y++ {
			mut cell := sh.cell_at_position(x, y, true)
			cell.list << id
		}
	}
}

//#endregion

//#region Bump narrow phase

struct SegmentIntersectionResult {
	collision bool
	ti1 f32
	ti2 f32
	nx1 f32
	ny1 f32
	nx2 f32
	ny2 f32
}

pub struct CollisionResult {
	collision bool
	overlaps bool
	ti f32
	move_x f32
	move_y f32
	normal_x f32
	normal_y f32
	touch_x f32
	touch_y f32
	other &Collider
}
pub fn (c CollisionResult) str() string {
	return 'col: $c.collision, overlaps: $c.overlaps, ti: $c.ti, move: ($c.move_x,$c.move_y), normal: ($c.normal_x,$c.normal_y), touch: ($c.touch_x,$c.touch_y)'
}

fn sort_collisions(a, b &CollisionResult) int {
	if a.ti == b.ti {
		println('sort_collisions got simultaneous ti. potentially add rect_getSquareDistance to sort')
	}
	return if a.ti < b.ti { -1 } else { 1 }
}

// from Bump.lua: This is a generalized implementation of the liang-barsky algorithm, which also returns
// the normals of the sides where the segment intersects. Returns collision = false if the segment never touches the rect
// Notice that normals are only guaranteed to be accurate when initially ti1, ti2 == -math.huge, math.huge
fn (sh &SpatialHash) get_segment_intersection_indices(bounds &math.Rect, x1, y1, x2, y2 f32) SegmentIntersectionResult {
	mut ti1 := -1000000.0
	mut ti2 := 1000000.0
	dx := x2 - x1
	dy := y2 - y1
	mut nx := 0
	mut ny := 0
	mut nx1 := 0.0
	mut ny1 := 0.0
	mut nx2 := 0.0
	mut ny2 := 0.0
	mut p := 0.0
	mut q := 0.0
	mut r := 0.0

	for side in 1..5 {
		match side {
			1 {
				nx = -1
				ny = 0
				p = -dx
				q = x1 - bounds.x
			}
			2 {
				nx = 1
				ny = 0
				p = dx
				q = f32(bounds.x + bounds.w) - x1
			}
			3 {
				nx = 0
				ny = -1
				p = -dy
				q = y1 - bounds.y
			}
			4 {
				nx = 0
				ny = 1
				p = dy
				q = f32(bounds.y + bounds.h) - y1
			}
			else {}
		}

		if p == 0 {
			if q <= 0 {
				return SegmentIntersectionResult{}
			}
		} else {
			r = q / p
			if p < 0 {
				if r > ti2 {
					return SegmentIntersectionResult{}
				}
				if r > ti1 {
					ti1 = r
					nx1 = nx
					ny1 = ny
				}
			} else { // p > 0
				if r < ti1 {
					return SegmentIntersectionResult{}
				}
				if r < ti2 {
					ti2 = r
					nx2 = nx
					ny2 = ny
				}
			}
		}
	}

	return SegmentIntersectionResult{true, ti1, ti2, nx1, ny1, nx2, ny2}
}

fn (sh &SpatialHash) detect_collision(bounds &math.Rect, other_id int, goal_x, goal_y f32) CollisionResult {
	dx := goal_x - bounds.x
	dy := goal_y - bounds.y

	item := *HashItem(sh.items.get(other_id))
	diff := math.minkowski_diff(bounds, item.bounds)

	mut overlaps := false
	mut ti := 0.0
	mut nx := 0.0
	mut ny := 0.0

	if diff.contains(0, 0) || diff.contains_pt(0, 0) {
		println('already overlapping before movement')
		overlaps = true
	} else {
		col := sh.get_segment_intersection_indices(diff, 0, 0, dx, dy)

		// item tunnels into another
		if col.ti1 < 1 && math.abs(col.ti1 - col.ti2) >= delta {
			if 0.0 < col.ti1 + delta || ((col.ti1 == 0.0) && (col.ti2 > 0.0)) {
				ti = col.ti1
				nx = col.nx1
				ny = col.ny1
				println('tunnnels: $ti, $nx, $ny')
				overlaps = false
			}
		}
	}

	if ti == 0 {
		println('-------- da fuk? this right?')
		return CollisionResult{}
	}

	mut tx := 0.0
	mut ty := 0.0

	if overlaps {
		println('----- implement overlaps')
		if dx == 0 && dy == 0 {
			// intersecting and not moving - use minimum displacement vector
		} else {
			// intersecting and moving - move in the opposite direction
		}
	} else { // tunnel
		tx = f32(bounds.x) + dx * ti
		ty = f32(bounds.y) + dy * ti
		println('------- bottom tunnel')
	}

	return CollisionResult{
		collision: true
		overlaps: overlaps
		ti: ti
		move_x: dx
		move_y: dy
		normal_x: nx
		normal_y: ny
		touch_x: tx
		touch_y: ty
	}
}

fn (sh mut SpatialHash) project(id int, bounds &math.Rect, goal_x, goal_y f32) []CollisionResult {
	tl := math.min(goal_x, bounds.x)
	tt := math.min(goal_y, bounds.y)
	tr := math.max(goal_x + bounds.w, bounds.right())
	tb := math.max(goal_y + bounds.h, bounds.bottom())
	tw := tr - tl
	th := tb - tt

	cl, ct := sh.cell_coords(tl, tt)
	cw, ch := sh.cell_coords(tw, th)

	mut visited := []int
	mut collisions := []CollisionResult

	for x := cl; x <= cw; x++ {
		for y := ct; y <= ch; y++ {
			mut cell := sh.cell_at_position(x, y, false)
			if cell != C.NULL {
				for item_id in cell.list {
					if item_id == id || item_id in visited {
						continue
					}
					
					visited << item_id
					col := sh.detect_collision(bounds, item_id, goal_x, goal_y)
					collisions << col
				}
			}
		}
	}

	if collisions.len > 0 {
		collisions.sort_with_compare(sort_collisions)
	}

	unsafe { visited.free() }

	return collisions
}

// gets all the potential overlaps. Note that the array must be freed.
pub fn (sh mut SpatialHash) broadphase(id int, goal_x, goal_y f32) []CollisionResult {
	mut item := *HashItem(sh.items.get(id))
	return sh.project(id, item.bounds, goal_x, goal_y)
}

pub fn (sh mut SpatialHash) check(id int, goal_x, goal_y f32) {
	mut item := *HashItem(sh.items.get(id))

	collisions := sh.project(id, item.bounds, goal_x, goal_y)
	unsafe { collisions.free() }
}

pub fn (sh mut SpatialHash) move(id int, goal_x, goal_y f32) {
	// sh.check(id, goal_x, goal_y)
}

//#endregion

//#region Bump collision response

pub fn cross(sh &SpatialHash, col &CollisionResult) {

}

//#endregion

pub fn (sh mut SpatialHash) debug() {
	println('---- SpatialHash ----')
	for x := sh.bounds.x; x <= sh.bounds.right(); x++ {
		for y := sh.bounds.y; y <= sh.bounds.bottom(); y++ {
			cell := sh.cell_at_position(x, y, false)
			if cell == C.NULL { continue }
			
			if cell.list.len > 0 {
				l := cell.list.len
				println('Cell ($x, $y) - $l')
				for i in cell.list {
					item := *HashItem(sh.items.get(i))
					println('	$i: $item.bounds.x, $item.bounds.y, $item.bounds.w, $item.bounds.h')
				}
			}
		}
	}
}
