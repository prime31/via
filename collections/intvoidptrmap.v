module collections
import via.math

// port of https://github.com/mikvor/hashmapTest

const (
	free_key = 0
	null_value = voidptr(0)
)

pub struct IntVoidptrMap {
mut:
	keys []int
	values []voidptr
	has_free_key bool	// do we have 'free' key in the map
	free_value voidptr	// value of 'free' key
	fill_factor f32		// must be between 0 - 1
	threshold int		// we resize a map once it reaches this size
	size int			// current map size
	mask int			// masks to calculate the original position
}

pub fn intvoidptrmap() &IntVoidptrMap {
	return intvoidptrmap_opts(16, 0.75)
}

pub fn intvoidptrmap_opts(size int, fill_factor f32) &IntVoidptrMap {
	assert fill_factor > 0 && fill_factor < 1
	
	// calculates the least power of two smaller than or equal to 2^30 and larger than or equal to
	cap := math.imax(2, int(math.ceilpow2_i64(i64(math.ceil(f32(size) / fill_factor)))))
	
	return &IntVoidptrMap{
		keys: make(cap, cap, sizeof(int))
		values: make(cap, cap, sizeof(voidptr))
		free_value: null_value
		fill_factor: fill_factor
		threshold: int(f32(cap) * fill_factor)
		mask: cap - 1
	}
}

pub fn (m &IntVoidptrMap) free() {
	unsafe {
		m.keys.free()
		m.values.free()
		free(m)
	}
}

[inline]
pub fn (m mut IntVoidptrMap) get(key int) voidptr {
	if key == free_key {
		return if m.has_free_key { m.free_value } else { null_value }
	}
	
	idx := m.read_index(key)
	return if idx != -1 { m.values[idx] } else { null_value }
}

pub fn (m mut IntVoidptrMap) put(key int, value voidptr) voidptr {
	if key == free_key {
		ret := m.free_value
		if !m.has_free_key {
			m.size++
		}
		m.has_free_key = true
		m.free_value = value
		return ret
	}
	
	mut idx := m.put_index(key)
	if idx < 0 {
		println('----- this shouldnt happen...')
		// no insertion point? shouldnt happen...
		m.rehash()
		idx = m.put_index(key)
	}
	
	prev := m.values[idx]
	if m.keys[idx] != key {
		m.keys[idx] = key
		m.values[idx] = value
		m.size++
		if m.size >= m.threshold {
			m.rehash()
		}
	} else { // means used cell with our key
		assert m.keys[idx] == key
		m.values[idx] = value
	}
	
	return prev
}

pub fn (m mut IntVoidptrMap) remove(key int) voidptr {
	if key == free_key {
		if !m.has_free_key {
			return free_key
		}
		m.has_free_key = false
		ret := m.free_value
		m.free_value = free_key
		m.size--
		return ret
	}
	
	idx := m.read_index(key)
	if idx == -1 {
		return null_value
	}
	
	res := m.values[idx]
	m.values[idx] = null_value
	m.shift_keys(idx)
	m.size--

	return res
}

// Find key position in the map
[inline]
fn (m mut IntVoidptrMap) read_index(key int) int {
	mut idx := iim_phi_mix(key) & m.mask
	if m.keys[idx] == key {
		return idx
	}
	if m.keys[idx] == free_key {
		return -1
	}
	
	start_idx := idx
	for {
		idx = (idx + 1) & m.mask
		if idx == start_idx {
			break
		}
		if m.keys[idx] == free_key {
			return -1
		}
		if m.keys[idx] == key {
			return idx
		}
	}
	return -1
}

// Find an index of a cell which should be updated by 'put' operation
fn (m mut IntVoidptrMap) put_index(key int) int {
	read_idx := m.read_index(key)
	if read_idx >= 0 {
		return read_idx
	}
	
	// key not found, find insertion point
	start_idx := iim_phi_mix(key) & m.mask
	if m.keys[start_idx] == free_key {
		return start_idx
	}
	
	mut idx := start_idx
	for m.keys[idx] != free_key {
		idx = (idx + 1) & m.mask
		if idx == start_idx {
			return -1
		}
	}
	return idx
}

fn (m mut IntVoidptrMap) shift_keys(ptr int) int {
	// shift entries with the same hash
	mut pos := ptr
	mut last := 0
	mut slot := 0
	mut k := 0
	mut keys := m.keys
	
	for {
		last = pos
		pos = (pos + 1) & m.mask
		for {
			k = m.keys[pos]
			if k == free_key {
				keys[last] = free_key
				return last
			}
			
			// calculate the starting slot for the current key
			slot = iim_phi_mix(k) & m.mask
			break_chk := if last <= pos { last >= slot || slot > pos } else { last >= slot && slot > pos }
			if break_chk {
				break
			}
			pos = (pos + 1) & m.mask
		}
		keys[last] = k
		m.values[last] = m.values[pos]
	}
	
	panic('unreachable')
}

fn (m mut IntVoidptrMap) rehash() {
	new_cap := m.keys.len * 2
	m.threshold = int(f32(new_cap) * m.fill_factor)
	m.mask = new_cap - 1
	
	old_cap := m.keys.len
	old_keys := m.keys
	old_values := m.values
	
	m.keys = make(new_cap, new_cap, sizeof(int))
	m.values = make(new_cap, new_cap, sizeof(voidptr))
	m.size = if m.has_free_key { 1 } else { 0 }
	
	for i := old_cap - 1; i >= 0; i-- {
		if old_keys[i] != free_key {
			m.put(old_keys[i], old_values[i])
		}
	}

	unsafe {
		old_keys.free()
		old_values.free()
	}
}