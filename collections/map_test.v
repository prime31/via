module collections
import via
import via.debug
import via.time

struct Tester {
mut:
	keys []int
	vals []voidptr
	old_map &IntHashMap
	new_map &IntVoidptrMap
}

fn test_main() {
/*	mut map := intvoidptrmap()

	one := 1
	two := 2
	three := 3

	map.put(1, &one)
	map.put(2, &two)
	map.put(3, &three)

	one_b := *(&int(map.get(1)))
	two_b := *(&int(map.get(2)))
	three_b := *(&int(map.get(3)))

	println('one_b: $one_b')
	println('two_b: $two_b')
	println('three_b: $three_b')

	map.free()*/

	mut tester := &Tester{
		old_map: inthashmap()
		new_map: intvoidptrmap()
	}

	mut start := time.now()
	for i in 0..500 {
		tester.keys << i * 23980
		tester.vals << voidptr(&i)
	}

	debug.warn('-------------------------------')
	arr_fill_t := time.now() - start
	debug.warn('-- fill arrays ${f32(arr_fill_t) / 1000} --')

	start = time.now()
	tst_old(tester)
	old_t := time.now() - start

	start = time.now()
	tst_new(tester)
	new_t := time.now() - start

	debug.warn('------ test put 1000 items -------')
	debug.warn('-- old: ${f32(old_t) / 1000} --')
	debug.warn('-- new: ${f32(new_t) / 1000} --')

	start = time.now()
	tst_old_get(tester)
	old_t_get := time.now() - start

	start = time.now()
	tst_new_get(tester)
	new_t_get := time.now() - start

	debug.warn('------ test get 1000 items -------')
	debug.warn('-- old: ${f32(old_t_get) / 1000} --')
	debug.warn('-- new: ${f32(new_t_get) / 1000} --')

	println('------- old before put: $tester.old_map.size()')
	start = time.now()
	tst_old_rem(tester)
	old_t_rem := time.now() - start

	start = time.now()
	tst_new_rem(tester)
	new_t_rem := time.now() - start

	debug.warn('------ test remove 1000 items -------')
	debug.warn('-- old: ${f32(old_t_rem) / 1000} --')
	debug.warn('-- new: ${f32(new_t_rem) / 1000} --')
}

fn tst_old(t &Tester) {
	mut hmap := t.old_map
	for i in 0..t.keys.len {
		hmap.put(t.keys[i], t.vals[i])
	}
}

fn tst_new(t &Tester) {
	mut hmap := t.new_map
	for i in 0..t.keys.len {
		hmap.put(t.keys[i], t.vals[i])
	}
}

fn tst_old_rem(t &Tester) {
	mut hmap := t.old_map
	for i in 0..t.keys.len {
		if hmap.has(t.keys[i]) {
			hmap.remove(t.keys[i])
		}
	}
}

fn tst_new_rem(t &Tester) {
	mut hmap := t.new_map
	for i in 0..t.keys.len {
		if hmap.has(t.keys[i]) {
			hmap.remove(t.keys[i])
		}
	}
}

fn tst_old_get(t &Tester) {
	mut hmap := t.old_map
	for i in 0..t.keys.len {
		hmap.get(t.keys[i])
	}
}

fn tst_new_get(t &Tester) {
	mut hmap := t.new_map
	for i in 0..t.keys.len {
		hmap.get(t.keys[i])
	}
}






fn test_intmap() {
	mut map := collections.intintmap()

	for i in 0..20 {
		for j in 0..10 {
			put_get(mut map, i * j + 1, j)
		}
	}

	//println('------------------------')

	for i in 0..20 {
		for j in 0..10 {
			del(mut map, i * j + 1)
		}
	}

	map.free()
}

fn put_get(map mut collections.IntIntMap, key, val int) {
	map.put(key, val)
	val_b := map.get(key)
	assert val_b == val
	//println('put: $key => $val, got: $val_b  -- size: ${map.size}')
}

fn del(map mut collections.IntIntMap, key int) {
	map.remove(key)
	//println('remove: $key,  -- size: ${map.size}')
}