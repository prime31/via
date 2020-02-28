module verlet
import via.math
import via.time
import via.debug
import via.input

const (
	constraint_iters = 3
	max_step_iters = 5
	particle_color = math.color_from_bytes(220, 52, 94, 255)
	constraint_color = math.color_from_bytes(67, 62, 54, 255)
)

pub struct World {
mut:
	dragged_particle &Particle
	left_over_time f32
	fixed_dt f32 = 1.0 / 60.0
	fixed_dt_sq f32
	iter_steps int
	composites []Composite
pub mut:
	gravity math.Vec2 = math.Vec2{0, 980}
	bounds math.RectF
	constrain_to_bounds bool = true
	allow_drag bool = true
	selection_radius f32 = 20.0
}

pub fn world(bounds math.RectF) World {
	mut w := World{
		bounds: bounds
	}
	w.fixed_dt_sq = w.fixed_dt * w.fixed_dt
	return w
}

pub fn (w mut World) tick() {
	w.update_timing()

	if w.allow_drag {
		w.handle_drag()
	}

	for _ in 0..w.iter_steps {
		for i := w.composites.len - 1; i >= 0; i-- {
			mut comp := &w.composites[i]

			// solve constraints
			for _ in 0..constraint_iters {
				comp.solve_constraints()
			}

			// do the verlet integration
			comp.update_particles(w.fixed_dt_sq, w.gravity)

			// handle collisions with Colliders
			// TODO

			for j in 0..comp.particles.len {
				p := &comp.particles[j]

				// optionally constrain to bounds
				if w.constrain_to_bounds {
					w.constrain_particle_to_bounds(mut p)
				}

				// optionally handle collisions with Colliders
				// TODO
			}
		}
	}
}

fn (w mut World) update_timing() {
	w.left_over_time += time.dt()
	w.iter_steps = math.itrunc(w.left_over_time / w.fixed_dt)
	w.left_over_time -= f32(w.iter_steps) * w.fixed_dt

	w.iter_steps = math.imin(w.iter_steps, max_step_iters)
}

fn (w &World) constrain_particle_to_bounds(p mut Particle) {
	mut temp_pos := p.pos

	if p.radius == 0 {
		if temp_pos.y > w.bounds.bottom() {
			temp_pos.y = w.bounds.bottom()
		} else if temp_pos.y < w.bounds.y {
			temp_pos.y = w.bounds.y
		}

		if temp_pos.x < w.bounds.x {
			temp_pos.x = w.bounds.x
		} else if temp_pos.x > w.bounds.right() {
			temp_pos.x = w.bounds.right()
		}
	} else {
		// special care for larger particles
		if temp_pos.y < w.bounds.y + p.radius {
			temp_pos.y = 2.0 * (w.bounds.y + p.radius) - temp_pos.y
		}
		if temp_pos.y > w.bounds.bottom() - p.radius {
			temp_pos.y = 2.0 * (w.bounds.bottom() - p.radius) - temp_pos.y
		}
		if temp_pos.x > w.bounds.right() - p.radius {
			temp_pos.x = 2.0 * (w.bounds.right() - p.radius) - temp_pos.x
		}
		if temp_pos.x < w.bounds.x + p.radius {
			temp_pos.x = 2.0 * (w.bounds.x + p.radius) - temp_pos.x
		}
	}

	p.pos = temp_pos
}

fn (w mut World) handle_drag() {
	if input.mouse_pressed(.left) {
		w.dragged_particle = w.nearest_particle(input.mouse_pos_scaledv())
	} else if input.mouse_down(.left) {
		if w.dragged_particle != 0 {
			w.dragged_particle.pos = input.mouse_pos_scaledv()
		}
	} else if input.mouse_up(.left) {
		if w.dragged_particle != 0 {
			w.dragged_particle.pos = input.mouse_pos_scaledv()
		}
		w.dragged_particle = 0
	}
}

pub fn (w &World) render() {
	for c in w.composites {
		c.render()
	}

	if w.allow_drag {
		if w.dragged_particle != 0 {
			debug.draw_hollow_circlev(w.dragged_particle.pos, 8, math.white())
		} else {
			// Highlight the nearest particle within the selection radius
			p := w.nearest_particle(input.mouse_pos_scaledv())
			if p != 0 {
				debug.draw_hollow_circlev(p.pos, 8, math.white().mul(0.4))
			}
		}
	}
}

// gets the nearest Particle to the position. Uses the selectionRadiusSquared to determine if a Particle is near enough for consideration.
fn (w &World) nearest_particle(pos math.Vec2) &Particle {
	sel_rad_sq := w.selection_radius * w.selection_radius
	mut nearest_dist := sel_rad_sq
	mut particle := &Particle(0)

	for j in 0..w.composites.len {
		for i in 0..w.composites[j].particles.len {
			p := &w.composites[j].particles[i]
			dist_to_p := p.pos.sq_distance_to(pos)
			if dist_to_p <= sel_rad_sq && dist_to_p < nearest_dist {
				particle = p
				nearest_dist = sel_rad_sq
			}
		}
	}

	return particle
}
