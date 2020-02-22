module collections
import via.math

// converted from: https://github.com/mikvor/hashmapTest/blob/master/src/main/java/map/intint/IntIntMap1.java

[inline]
fn hm_get_pot_array_size(expected int, factor f32) int {
    return math.imax(2, int(math.ceilpow2_i64(i64(math.ceil(f32(expected) / factor)))))
}

[inline]
fn hm_phi_mix(x int) int {
    h := x * 0x9e3779b9
    return h ^ (h >> 16)
}


pub struct IntHashMap {
mut:
    fill_factor f32
    threshold int
    _size int
    mask u32

    _keys []int
    _values []voidptr
    _used []bool
}

pub fn inthashmap() IntHashMap {
    return inthashmap_options(16, 0.75)
}

pub fn inthashmap_options(size int, fill_factor f32) IntHashMap {
    assert fill_factor > 0 && fill_factor < 1

    mut hashmap := IntHashMap{}
    capacity := hm_get_pot_array_size(size, fill_factor)
    hashmap.mask = u32(capacity - 1)
    hashmap.fill_factor = fill_factor

    hashmap._keys = [0].repeat(capacity)
    hashmap._values = [voidptr(0)].repeat(capacity)
    hashmap._used = [false].repeat(capacity)
    hashmap.threshold = int(f32(capacity) * fill_factor)

    return hashmap
}

pub fn (hm &IntHashMap) free() {
	unsafe {
		hm._keys.free()
		hm._values.free()
		hm._used.free()
	}
}

pub fn (hashmap &IntHashMap) get(key int) voidptr {
    idx := hashmap.read_index(key)
    if idx != -1 { // unsafe!
        return hashmap._values[idx]
    } else {
        return 0
    }
}

[inline]
pub fn (hashmap &IntHashMap) has(key int) bool {
    return hashmap.read_index(key) != -1
}

pub fn (hashmap mut IntHashMap) put(key int, value voidptr) {
    mut idx := hashmap.put_index(key)
    for idx < 0 {
        println('put() key: $key, idx: $idx, no space, rehashing')
        hashmap.rehash()
        idx = hashmap.put_index(key)
        if idx < 0 {
            println('put() idx still invalid after rehash!')
        }
    }

    if !hashmap._used[idx] {
        hashmap._keys[idx] = key
        hashmap._values[idx] = value
        hashmap._used[idx] = true
        hashmap._size++

        if hashmap._size >= hashmap.threshold {
            println('hit hashmap threshold, rehashing')
            hashmap.rehash()
        }
    } else {
        hashmap._values[idx] = value
    }
}

[inline]
pub fn (hashmap &IntHashMap) size() int {
    return hashmap._size
}

pub fn (hashmap &IntHashMap) keys() []int {
    mut keys := [0].repeat(hashmap._size)
    mut kidx := 0

    for idx := 0; idx < hashmap._keys.len; idx++ {
        if hashmap._used[idx] {
            keys[kidx] = hashmap._keys[idx]
            kidx++
        }
    }

    return keys
}

// unsafe
pub fn (hashmap mut IntHashMap) remove(key int) voidptr {
    idx := hashmap.read_index(key)
    if idx == -1 {
        return 0
    }

    res := hashmap._values[idx]
    hashmap._size--
    hashmap.shift_keys(idx)
    return res
}

pub fn (hashmap mut IntHashMap) clear() {
    for idx := 0; idx < hashmap._keys.len; idx++ {
        if hashmap._used[idx] {
            hashmap._size--
            hashmap.shift_keys(idx)
        }
    }
}

[inline]
fn (hashmap &IntHashMap) start_index(key int) int {
    return int(u32(hm_phi_mix(key)) & hashmap.mask)
}

[inline]
fn (hashmap &IntHashMap) next_index(key int) int {
    return int(u32(key + 1) & hashmap.mask)
}

[inline]
fn (hashmap &IntHashMap) read_index(key int) int {
    mut idx := hashmap.start_index(key)
    if !hashmap._used[idx] {
        return -1
    }

    if hashmap._keys[idx] == key {
        return idx
    }

    start_idx := idx
    mut keyx := key
    for {
        idx = hashmap.next_index(keyx)
        if idx == start_idx || !hashmap._used[idx] {
            return -1
        }

        if hashmap._keys[idx] == key && hashmap._used[idx] {
            return idx
        }
        // TODO: is bumping the key the right solution?
        keyx++
    }

    return -1
}

[inline]
fn (hashmap &IntHashMap) put_index(key int) int {
    read_idx := hashmap.read_index(key)
    if read_idx >= 0 {
        return read_idx
    }

    start_idx := hashmap.start_index(key)
    mut idx := start_idx
    mut keyx := key
    for {
        if !hashmap._used[idx] {
            break
        }

        idx = hashmap.next_index(keyx)
        if idx == start_idx {
            return -1
        }
        // TODO: is bumping the key the right solution?
        keyx++
    }

    return idx
}

fn (hashmap mut IntHashMap) rehash() {
    new_capacity := hashmap._keys.len * 2
    hashmap.threshold = int(f32(new_capacity) * hashmap.fill_factor)
    hashmap.mask = u32(new_capacity - 1)

    old_capacity := hashmap._keys.len - 1
    old_keys := hashmap._keys
    old_values := hashmap._values
    old_used := hashmap._used
    // println('rehash $old_capacity -> $new_capacity')

    hashmap._keys = [0].repeat(new_capacity)
    hashmap._values = [voidptr(0)].repeat(new_capacity)
    hashmap._used = [false].repeat(new_capacity)
    hashmap._size = 0

    for i := old_capacity; i >= 0; i-- {
        if old_used[i] {
            hashmap.put(old_keys[i], old_values[i])
        }
    }

    unsafe {
        old_keys.free()
        old_values.free()
        old_used.free()
    }
}

fn (hashmap mut IntHashMap) shift_keys(_pos int) int {
    mut last := 0
    mut k := 0
    mut pos := _pos

    for {
        last = pos
        pos = hashmap.next_index(pos)

        for {
            k = hashmap._keys[pos]
            if !hashmap._used[pos] {
                hashmap._keys[last] = 0
                hashmap._values[last] = voidptr(0)
                hashmap._used[last] = false

                return last
            }

            slot := hashmap.start_index(k)
			break_chk := if last <= pos { last >= slot || slot > pos } else { last >= slot && slot > pos }
			if break_chk {
				break
			}

            pos = hashmap.next_index(pos)
        }

        hashmap._keys[last] = k
        hashmap._values[last] = hashmap._values[pos]
        hashmap._used[last] = hashmap._used[pos]
    }

    return -1

    //panic('should not happen!')
}