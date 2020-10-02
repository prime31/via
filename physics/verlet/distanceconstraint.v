module verlet
import via.debug

pub struct DistanceConstraint {
mut:
	parent &Composite
pub mut:
	stiffness f32 = 0.5
	rest_dist f32
	tear_sensitivity f32 = 9999999.0
	particle1 &Particle
	particle2 &Particle
}

pub fn distanceconstraint(a, b &Particle, stiffness, distance f32) DistanceConstraint {
	mut resting_dist := distance
	if distance < 0 {
		resting_dist = a.pos.distance_to(b.pos)
	}

	return DistanceConstraint{
		parent: 0
		particle1: a
		particle2: b
		stiffness: stiffness
		rest_dist: resting_dist
	}
}

pub fn (mut c DistanceConstraint) set_parent(parent &Composite) {
	c.parent = parent
}

pub fn (mut c DistanceConstraint) solve() {
	// calculate the distance between the two Particles
	diff := c.particle1.pos - c.particle2.pos
	d := diff.magnitude()

	// find the difference, or the ratio of how far along the rest_distance the actual distance is
	difference := (c.rest_dist - d) / d

	// if the distance is more than tear_sensitivity we remove the Constraint
	if d / c.rest_dist > c.tear_sensitivity {
		c.parent.remove_constraint(c)
		return
	}

	// inverse the mass quantities
	im1 := 1.0 / c.particle1.mass
	im2 := 1.0 / c.particle2.mass
	scaler_p1 := (im1 / (im1 + im2)) * c.stiffness
	scaler_p2 := c.stiffness - scaler_p1

	// push/pull based on mass
	// heavier objects will be pushed/pulled less than attached light objects
	c.particle1.pos = c.particle1.pos + diff.mul(scaler_p1 * difference)
	c.particle2.pos = c.particle2.pos - diff.mul(scaler_p2 * difference)
}

pub fn (c &DistanceConstraint) render() {
	debug.draw_linev(c.particle1.pos, c.particle2.pos, 1, constraint_color)
}