module collections

fn test_spatialhash() {
	mut hash := collections.spatialhash()

	mut h1 := collections.Collider{0, 0, 10, 35}
	h1_id := hash.add(h1)
	hash.debug()

	println('\n-- updating Collider')
	h1.w += 134
	hash.update(h1_id, h1)
	hash.debug()

	println('\n-- removing Collider')
	hash.remove(h1_id)
	hash.debug()

	hash.free()
}

fn test_inthashmap() {
	mut c := Cell{}
	c.list = [1, 2, 3]
	println('eles=${c.list}')

	mut hmap := collections.inthashmap()
	hmap.put(4, c)
	mut cptr := *Cell(hmap.get(4))
	cptr.list << 4
	println('len=${cptr.list.len}, eles=${cptr.list}')
	println('eles=${c.list}')
}