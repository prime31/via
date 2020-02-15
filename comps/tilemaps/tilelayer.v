module tilemaps

pub struct TileLayer {
	name string
	visible bool
	width int
	height int
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


pub fn (l &TileLayer) has_tile(x, y int) bool {
	return l.tiles[x + y * l.width] >= 0
}

//GetTile(int x, int y) => Tiles[x + y * Width];
pub fn (l &TileLayer) get_tile(x, y int) &Tile {
	id := l.tiles[x + y * l.width]
	if id < 0 {
		t := &Tile(0)
		return t
	}

	t := tile(id, -1)
	return &t
}
