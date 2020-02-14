module tilemaps

const (
	flipped_h = 0x80000000
	flipped_v = 0x40000000
	flipped_d = 0x20000000
)

[flag]
pub enum Flipped {
	no
	horizontal
	vertical
	diagonally
}


pub struct Tile {
	id int
mut:
	flipped Flipped
}

fn tile(id int) Tile {
	mut t := Tile{
		id: id & ~(flipped_h | flipped_v | flipped_d)
	}

	if (id & flipped_h) != 0 {
		t.flipped.set(.horizontal)
	}

	if (id & flipped_v) != 0 {
		t.flipped.set(.vertical)
	}

	if (id & flipped_d) != 0 {
		t.flipped.set(.diagonally)
	}

	return t
}