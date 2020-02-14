module tilemaps

pub struct TileLayer {
	name string
	visible bool
	width int
	height int
	tiles []int
}

//GetTile(int x, int y) => Tiles[x + y * Width];
pub fn (l &TileLayer) get_tile(x, y int) &Tile {
	mut t := &Tile(0)
	
	id := l.tiles[x + y * l.width]
	if id < 0 {
		return t
	}
	return tile(id)
}
