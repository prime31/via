module tilemap

// TODO: this file is a hack. these should all be in tilesettile.v but V farts unless this is here

pub fn (t &TilesetTile) slope_tl(tid TileId) int {
	// TODO: deal with vertical/diagonal flipped tiles
	return if tid.flipped_h() { t.slope_tr } else { t.slope_tl }
}

pub fn (t &TilesetTile) slope_tr(tid TileId) int {
	// TODO: deal with vertical/diagonal flipped tiles
	return if tid.flipped_h() { t.slope_tl } else { t.slope_tr }
}

pub fn (t &TilesetTile) slope(tid TileId, tile_size int) f32 {
	mut ts := tile_size
	if tid.flipped_h() {
		ts *= -1
	}

	// rise over run
	s_tr := if tid.flipped_h() { t.slope_tr } else { t.slope_tl }
	s_tl := if tid.flipped_h() { t.slope_tl } else { t.slope_tr }
	return f32(s_tr - s_tl) / ts
}

pub fn (t &TilesetTile) wtf(tid TileId, tile_size, perp_pos, tile_worldx, tile_worldy int) int {
	mut ts := tile_size
	if tid.flipped_h() {
		ts *= -1
	}

	// rise over run
	s_tr := if tid.flipped_h() { t.slope_tr } else { t.slope_tl }
	s_tl := if tid.flipped_h() { t.slope_tl } else { t.slope_tr }
	s := f32(s_tr - s_tl) / ts

	// s_tl is the slope position on the left side of the tile. b in the y = mx + b equation
	return int(s * (perp_pos - tile_worldx) + s_tl + tile_worldy)
	//s := t.slope(tid, tile_size)
	//slope * (perpindicularPosition - tileWorldX) + offset + tileWorldY
}