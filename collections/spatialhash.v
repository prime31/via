module collections
import via.math

pub struct SpatialHash {
	cells map[string][]int
	cell_size int
	inv_cell_size f32
}

fn (sh &SpatialHash) get_hashed_key(x, y f32) u64 {
	return u64(x) << 32 | u32(y)
}

// gets the cell x,y values for a world-space x,y value
fn (sh &SpatialHash) cell_coords(x, y f32) (int, int) {
	return math.ifloor(x * sh.inv_cell_size), math.ifloor(y * sh.inv_cell_size)
}

fn (sh &SpatialHash) cell_coordsi(x, y int) (int, int) {
	return math.ifloor(f32(x) * sh.inv_cell_size), math.ifloor(f32(y) * sh.inv_cell_size)
}

fn (sh &SpatialHash) cell_at_position(x, y int) {
	key := sh.get_hashed_key(x, y)
}