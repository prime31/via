module tilemap

pub struct TileLayer {
	name string
	visible bool
	width int
	height int
pub mut:
	tiles []int
}

pub fn (t TileLayer) str() string {
	return 'n:$t.name, v:$t.visible, w:$t.width, h:$t.height, tiles:$t.tiles.len'
}

pub fn (t &TileLayer) free() {
	unsafe {
		t.name.free()
		t.tiles.free()
	}
}

pub fn (l &TileLayer) total_non_empty_tiles() int {
	mut cnt := 0

	for t in l.tiles {
		if t >= 0 {
			cnt++
		}
	}

	return cnt
}

pub fn (l &TileLayer) has_tile(x, y int) bool {
	return l.tiles[x + y * l.width] >= 0
}

pub fn (l &TileLayer) get_tile(x, y int) &Tile {
	id := l.tiles[x + y * l.width]
	if id < 0 {
		t := &Tile(0)
		return t
	}

	t := tile(id, -1)
	return &t
}
