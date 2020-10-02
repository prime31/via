module collections
import via.math

// port of https://github.com/mikvor/hashmapTest

const (
	FREE_KEY_NO_VALUE = 0
)

[inline]
fn iim_phi_mix(x int) int {
    h := x * 0x9E3779B9
    return h ^ (h >> 16)
}

pub struct IntIntMap {
mut:
	data []int			// keys and values
	has_free_key bool	// do we have 'free' key in the map
	free_value int		// value of 'free' key
	fill_factor f32		// must be between 0 - 1
	threshold int		// we resize a map once it reaches this size
	size int			// current map size
	mask int			// masks to calculate the original position
	mask2 int
}

pub fn intintmap() &IntIntMap {
	return intintmap_opts(16, 0.75)
}

pub fn intintmap_opts(size int, fill_factor f32) &IntIntMap {
	assert fill_factor > 0 && fill_factor < 1

	// calculates the least power of two smaller than or equal to 2^30 and larger than or equal to
	cap := math.imax(2, int(math.ceilpow2_i64(i64(math.ceil(f32(size) / fill_factor)))))

	return &IntIntMap{
		data: make(cap * 2, cap * 2, sizeof(int))
		fill_factor: fill_factor
		threshold: int(f32(cap) * fill_factor)
		mask: cap - 1
		mask2: cap * 2 - 1
	}
}

pub fn (m &IntIntMap) free() {
	unsafe {
		m.data.free()
		free(m)
	}
}

[inline]
pub fn (m &IntIntMap) try_get(key int, value &int) bool {
	mut mvalue := value

	// we basically duplicate get() here
	if key == FREE_KEY_NO_VALUE {
		if m.has_free_key {
			*mvalue = m.free_value
		}
		return m.has_free_key
	}

	mut ptr := (iim_phi_mix(key) & m.mask) << 1
	mut k := m.data[ptr]
	if k == FREE_KEY_NO_VALUE {
		return false
	}

	if k == key { // we check FREE prior to this call
		*mvalue = m.data[ptr + 1]
		return true
	}

	for {
		ptr = (ptr + 2) & m.mask2 // next index
		k = m.data[ptr]
		if k == FREE_KEY_NO_VALUE {
			return false
		} else if k == key {
			*mvalue = m.data[ptr + 1]
			return true
		}
	}

	return false
}

pub fn (m &IntIntMap) get(key int) int {
	if key == FREE_KEY_NO_VALUE {
		return math.take(m.has_free_key, m.free_value, FREE_KEY_NO_VALUE)
	}

	mut ptr := (iim_phi_mix(key) & m.mask) << 1
	mut k := m.data[ptr]
	if k == FREE_KEY_NO_VALUE {
		return FREE_KEY_NO_VALUE // end of chain already
	}

	if k == key { // we check FREE prior to this call
		return m.data[ptr + 1]
	}

	for {
		ptr = (ptr + 2) & m.mask2 // next index
		k = m.data[ptr]
		if k == FREE_KEY_NO_VALUE {
			return FREE_KEY_NO_VALUE
		} else if k == key {
			return m.data[ptr + 1]
		}
	}

	panic('unreachable')
}

pub fn (mut m IntIntMap) put(key, value int) int {
	if key == FREE_KEY_NO_VALUE {
		ret := m.free_value
		if !m.has_free_key {
			m.size++
		}
		m.has_free_key = true
		m.free_value = value
		return ret
	}

	mut ptr := (iim_phi_mix(key) & m.mask) << 1
	mut k := m.data[ptr]
	if k == FREE_KEY_NO_VALUE { // end of chain already
		m.data[ptr] = key
		m.data[ptr + 1] = value
		if m.size >= m.threshold {
			m.rehash()
		} else {
			m.size++
		}
		return FREE_KEY_NO_VALUE
	} else if k == key { // we check FREE prior to this call
		ret := m.data[ptr + 1]
		m.data[ptr + 1] = value
		return ret
	}

	for {
		ptr = (ptr + 2) & m.mask2 // next index
		k = m.data[ptr]
		if k == FREE_KEY_NO_VALUE {
			m.data[ptr] = key
			m.data[ptr + 1] = value
			if m.size >= m.threshold {
				m.rehash()
			} else {
				m.size++
			}
			return FREE_KEY_NO_VALUE
		} else if k == key {
			ret := m.data[ptr + 1]
			m.data[ptr + 1] = value
			return ret
		}
	}

	panic('unreachable')
}

pub fn (mut m IntIntMap) remove(key int) int {
	if key == FREE_KEY_NO_VALUE {
		if !m.has_free_key {
			return FREE_KEY_NO_VALUE
		}
		m.has_free_key = false
		m.size--
		return m.free_value
	}

	mut ptr := (iim_phi_mix(key) & m.mask) << 1
	mut k := m.data[ptr]
	if k == key { // we check FREE prior to this call
		res := m.data[ptr + 1]
		m.shift_keys(ptr)
		m.size--
		return res
	} else if k == FREE_KEY_NO_VALUE { // end of chain already
		return FREE_KEY_NO_VALUE
	}

	for {
		ptr = (ptr + 2) & m.mask2 // next index
		k = m.data[ptr]
		if k == key {
			res := m.data[ptr + 1]
			m.shift_keys(ptr)
			m.size--
			return res
		} else if k == FREE_KEY_NO_VALUE {
			return FREE_KEY_NO_VALUE
		}
	}

	panic('unreachable')
}

fn (m &IntIntMap) shift_keys(ptr int) int {
	// shift entries with the same hash
	mut pos := ptr
	mut last := 0
	mut slot := 0
	mut k := 0
	mut data := m.data

	for {
		last = pos
		pos = (last + 2) & m.mask2
		for {
			k = data[pos]
			if k == FREE_KEY_NO_VALUE {
				data[last] = FREE_KEY_NO_VALUE
				return last
			}

			// calculate the starting slot for the current key
			slot = (iim_phi_mix(k) & m.mask) << 1
			break_chk := if last <= pos { last >= slot || slot > pos } else { last >= slot && slot > pos }
			if break_chk {
				break
			}
			pos = (pos + 2) & m.mask2
		}
	}

	panic('unreachable')
}

fn (mut m IntIntMap) rehash() {
	new_cap := m.data.len * 2
	m.threshold = int(f32(new_cap) / 2.0 * m.fill_factor)
	m.mask = new_cap / 2 - 1
	m.mask2 = new_cap - 1

	old_cap := m.data.len
	old_data := m.data

	m.data = make(new_cap, new_cap, sizeof(int))
	m.size = if m.has_free_key { 1 } else { 0 }

	for i := 0; i < old_cap; i += 2 {
		old_key := old_data[i]
		if old_key != FREE_KEY_NO_VALUE {
			m.put(old_key, old_data[i + 1])
		}
	}

	unsafe { old_data.free() }
}