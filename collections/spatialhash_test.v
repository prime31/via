module collections

fn test_spatialhash() {
	// mut hash := collections.spatialhash()

	// mut h1 := collections.Collider{0, 0, 10, 35}
	// h1_id := hash.add(h1)
	// hash.debug()

	// println('\n-- updating Collider')
	// h1.w += 134
	// hash.update(h1_id, h1)
	// hash.debug()

	// println('\n-- removing Collider')
	// hash.remove(h1_id)
	// hash.debug()

	// hash.free()
}

fn test_collision() {
	println('------- test_collision ------')
	mut hash := collections.spatialhash()

	a := collections.Collider{0, 0, 64, 256}
	a_id := hash.add(a)

	b := collections.Collider{0, -100, 32, 32}
	b_id := hash.add(b)

	response := hash.check(b_id, 0, 64)
	assert(response.x == 0.0)
	assert(response.y == -32.0)

	c := collections.Collider{-26, -26, 32, 32}
	c_id := hash.add(c)
	resp := hash.check(c_id, 0, 0)
	assert resp.x == -32
	assert resp.y == -32

	d := collections.Collider{-10, 0, 32, 32}
	d_id := hash.add(d)
	respd := hash.check(d_id, 0, 0)
	assert respd.x == -32
	assert respd.y == 0

	e := collections.Collider{65, 50, 32, 32}
	e_id := hash.add(e)
	respe := hash.check(e_id, 75, 10)
	assert respe.x == 75
	assert respe.y == 10

	//hash.debug()

	hash.free()
}

fn test_inthashmap() {
	mut c := Cell{}
	c.list = [1, 2, 3]

	mut hmap := collections.inthashmap()
	hmap.put(4, c)

	mut cptr := *Cell(hmap.get(4))
	cptr.list << 4
	assert cptr.list.len == c.list.len
}
