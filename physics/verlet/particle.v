module verlet
import via.math

pub struct Particle {
pub mut:
	pos math.Vec2
	last_pos math.Vec2
	mass f32 = 1.0
	radius f32
	accel math.Vec2
	pinned bool
	pin_pos math.Vec2
}

pub fn particle(pos math.Vec2) Particle {
	return Particle{
		pos: pos
		last_pos: pos
	}
}

pub fn (mut p Particle) apply_force(force math.Vec2) {
	assert p.mass != 0
	p.accel = p.accel + force.scale(1.0 / p.mass)
}

pub fn (mut p Particle) pin() {
	p.pinned = true
	p.pin_pos = p.last_pos
}

pub fn (mut p Particle) pin_to(pos math.Vec2) {
	p.pinned = true
	p.pin_pos = pos
}

pub fn (mut p Particle) unpin() {
	p.pinned = false
}