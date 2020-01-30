module collections
import via.math

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
	cell_size int = 32
	inv_cell_size f32 = 1.0 / 32.0
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
	}

	panic('')
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


pub fn (sh mut SpatialHash) debug() {
	println('---- SpatialHash ----')
	for x := sh.bounds.x; x <= sh.bounds.right(); x++ {
		for y := sh.bounds.y; y <= sh.bounds.bottom(); y++ {
			cell := sh.cell_at_position(x, y, false)
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
