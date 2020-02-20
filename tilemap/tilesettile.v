module tilemap

pub struct Property {
pub:
	key string
	value string
}

pub struct TilesetTile {
pub:
	id int
pub mut:
	props []Property
	//props map[string]string
}

pub fn (t &TilesetTile) free() {
	unsafe {
		for p in t.props {
			p.key.free()
			p.value.free()
		}
		t.props.free()
	}
}

pub fn (t &TilesetTile) is_oneway() bool {
	for p in t.props {
		if p.key == 'nez:isOneWayPlatform' {
			return true
		}
	}
	return false
}