module tilemap

type TileId int

pub fn (t TileId) id() int { return int(t) & ~(flipped_h | flipped_v | flipped_d) }

pub fn (t TileId) transformed() bool { return int(t) > flipped_d }

pub fn (t TileId) empty() bool { return t < 0 }

pub fn (t TileId) flipped_h() bool { return (int(t) & flipped_h) != 0 }

pub fn (t TileId) flipped_v() bool { return (int(t) & flipped_v) != 0 }

pub fn (t TileId) flipped_d() bool { return (int(t) & flipped_d) != 0 }






// POSSIBLY JUNK

pub struct TileInfo {
	id int
	flip_h bool
	flip_v bool
	flip_d bool
}

fn tileinfo(id int) TileInfo {
	mut t := TileInfo{
		id: id & ~(flipped_h | flipped_v | flipped_d)
		flip_h: (id & flipped_h) != 0
		flip_v: (id & flipped_v) != 0
		flip_d: (id & flipped_d) != 0
	}

	return t
}
