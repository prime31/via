module tilemap

type TileId int

pub fn (t TileId) id() int { return int(t) & ~(flipped_h | flipped_v | flipped_d) }

pub fn (t TileId) transformed() bool { return int(t) > flipped_d }

pub fn (t TileId) empty() bool { return t < 0 }

pub fn (t TileId) flipped_h() bool { return (int(t) & flipped_h) != 0 }

pub fn (t TileId) flipped_v() bool { return (int(t) & flipped_v) != 0 }

pub fn (t TileId) flipped_d() bool { return (int(t) & flipped_d) != 0 }
