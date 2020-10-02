module verlet
import via.math
import via.debug

interface IConstrainter {
	set_parent(parent Composite)
	solve()
	render()
}

pub struct Composite {
mut:
	friction math.Vec2 = math.Vec2{0.98, 1.0}
	particles []Particle
	constraints []DistanceConstraint // TODO: should be IConstrainter
}

pub fn composite() Composite {
	return Composite{}
}

//#region Particle/Constraint management

pub fn (mut c Composite) add_particle(p Particle) int {
	c.particles << p
	return c.particles.len - 1
}

pub fn (mut c Composite) remove_particle(p Particle) {
	panic('not implemented')
}

pub fn (mut c Composite) clear_particles() {
	c.particles.clear()
}

// TODO: should be IConstrainter
pub fn (mut c mut Composite) add_constraint(constraint DistanceConstraint) {
	constraint.set_parent(c)
	c.constraints << *constraint
}

// TODO: should be IConstrainter
pub fn (mut c Composite) remove_constraint(constraint DistanceConstraint) {
	//panic('not implemented')
}

pub fn (mut c Composite) clear_constraints() {
	c.constraints.clear()
}

//#endregion

pub fn (mut c Composite) apply_force(force math.Vec2) {
	for i in 0..c.particles.len {
		c.particles[i].apply_force(force)
	}
}

pub fn (mut c Composite) solve_constraints() {
	// loop backwards in case any Constraints break and are removed
	for i := c.constraints.len - 1; i >= 0; i-- {
		mut cons := &c.constraints[i]
		cons.solve()
	}
}

pub fn (c &Composite) update_particles(dt_sq f32, gravity math.Vec2) {
	for i in 0..c.particles.len {
		mut p := &c.particles[i]
		if p.pinned {
			p.pos = p.pin_pos
			continue
		}

		p.apply_force(gravity.mul(p.mass))

		// calculate velocity and dampen it with friction
		vel := (p.pos - p.last_pos) * c.friction

		// calculate the next position using Verlet Integration
		next_pos := p.pos + vel + p.accel.mul(0.5 * dt_sq)

		// reset variables
		p.last_pos = p.pos
		p.pos = next_pos
		p.accel.x = 0
		p.accel.y = 0
	}
}

pub fn (c &Composite) render() {
	for i in 0..c.constraints.len {
		c.constraints[i].render()
	}

	for p in c.particles {
		if p.radius == 0 {
			debug.draw_point(p.pos.x, p.pos.y, 4, particle_color)
		} else {
			debug.draw_hollow_circle(p.pos.x, p.pos.y, p.radius, particle_color)
		}
	}
}