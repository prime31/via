module tilemaps

const (
	flipped_h = 0x80000000
	flipped_v = 0x40000000
	flipped_d = 0x20000000
)

[flags]
pub enum Flipped {
	no
	horizontal
	vertical
	diagonally
}

	
pub struct Tile {
	id int
	flipped Flipped
}

fn tile(id int) Tile {
	mut flipped = Flipped.no
	
	return Tile{
		id: id & ~(flipped_h | flipped_v | flipped_d)
		flipped: flipped
	}
}