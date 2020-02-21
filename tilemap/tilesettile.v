module tilemap

pub struct TilesetTile {
pub:
	id int
pub mut:
	oneway bool
	slope bool
	slope_tl int
	slope_tr int
	props map[string]string
}

pub fn (t mut TilesetTile) free() {
	unsafe {
		t.props.free()
	}
}
