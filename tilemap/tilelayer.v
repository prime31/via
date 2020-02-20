module tilemap

const (
	flipped_h = 0x08000000
	flipped_v = 0x04000000
	flipped_d = 0x02000000
)

pub struct TileLayer {
	name string
	visible bool
	width int
	height int
pub mut:
	tiles []TileId
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

// used by the MapRenderer to optimize the AtlasBatch size
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

pub fn (l &TileLayer) get_tileid(x, y int) int {
	id := l.tiles[x + y * l.width]
	if id < 0 {
		return id
	}

	// TODO: should be return id.id() but V bug
	return int(id) & ~(flipped_h | flipped_v | flipped_d)
}
