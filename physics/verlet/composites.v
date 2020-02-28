module verlet
import via.math

pub fn ball(pos math.Vec2, radius f32) Composite {
	mut c := composite()

	c.add_particle(Particle{
		pos: pos
		last_pos: pos
		radius: radius
		mass: 1.0
	})

	return c
}

pub fn box(center math.Vec2, w, h, border_stiffness, diag_stiffness f32) Composite {
	mut c := composite()

	tli := c.add_particle(particle(center + math.Vec2{-w / 2, -h / 2}))
	tri := c.add_particle(particle(center + math.Vec2{w / 2, -h / 2}))
	bri := c.add_particle(particle(center + math.Vec2{w / 2, h / 2}))
	bli := c.add_particle(particle(center + math.Vec2{-w / 2, h / 2}))

	tl := &c.particles[tli]
	tr := &c.particles[tri]
	br := &c.particles[bri]
	bl := &c.particles[bli]

	// outside edges
	mut constraint := distanceconstraint(tl, tr, border_stiffness, -1)
	c.add_constraint(mut constraint)
	constraint = distanceconstraint(tr, br, border_stiffness, -1)
	c.add_constraint(mut constraint)
	constraint = distanceconstraint(br, bl, border_stiffness, -1)
	c.add_constraint(mut constraint)
	constraint = distanceconstraint(bl, tl, border_stiffness, -1)
	c.add_constraint(mut constraint)

	// inside diagonals
	constraint = distanceconstraint(tl, br, diag_stiffness, -1)
	c.add_constraint(mut constraint)
	constraint = distanceconstraint(bl, tr, diag_stiffness, -1)
	c.add_constraint(mut constraint)

	return c
}

pub fn cloth(top_left math.Vec2, w, h f32, segments int, stiffness, tear_sensitivity f32) Composite {
	mut c := composite()
	stride_x := w / f32(segments)
	stride_y := h / f32(segments)

	for y in 0..segments {
		for x in 0..segments {
			px := top_left.x + f32(x) * stride_x
			py := top_left.y + f32(y) * stride_y
			particle_index := c.add_particle(particle(math.Vec2{px, py}))

			if y == 0 {
				c.particles[particle_index].pin()
			}
		}
	}

	// TODO: properly fix this. we do a second loop here to get the proper addresses for the particles from the array
	// since they can change if the array reallocs
	for y in 0..segments {
		for x in 0..segments {
			// remove this constraint to make only vertical constaints for a hair-like cloth
			if x > 0 {
				p1 := &c.particles[y * segments + x]
				p2 := &c.particles[y * segments + x - 1]

				mut constraint := distanceconstraint(p1, p2, stiffness, -1)
				constraint.tear_sensitivity = tear_sensitivity
				c.add_constraint(mut constraint)
			}

			if y > 0 {
				p1 := &c.particles[y * segments + x]
				p2 := &c.particles[(y - 1) * segments + x]

				mut constraint := distanceconstraint(p1, p2, stiffness, -1)
				constraint.tear_sensitivity = tear_sensitivity
				c.add_constraint(mut constraint)
			}
		}
	}

	return c
}

pub fn rope(pos math.Vec2, length f32, segments int, stiffness f32) Composite {
	mut c := composite()

	stride_y := length / f32(segments)
	for i in 0..segments {
		index := c.add_particle(particle(math.Vec2{pos.x, pos.y + f32(i) * stride_y}))
		if i == 0 {
			c.particles[index].pin()
		}
	}

	for i in 1..c.particles.len {
		particle1 := &c.particles[i - 1]
		particle2 := &c.particles[i]

		constraint := distanceconstraint(particle1, particle2, stiffness, -1)
		c.add_constraint(mut constraint)
	}

	return c
}