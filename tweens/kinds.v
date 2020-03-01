module tweens

pub enum Kind {
	linear
	quadratic_in
	quadratic_out
	quadratic_in_out
	cubic_in
	cubic_out
	cubic_in_out
	quartic_in
	quartic_out
	quartic_in_out
	quintic_in
	quintic_out
	quintic_in_out
	sin_in
	sin_out
	sin_in_out
	circular_in
	circular_out
	circular_in_out
	exponential_in
	exponential_out
	exponential_in_out
	elastic_in
	elastic_out
	elastic_in_out
	back_in
	back_out
	back_in_out
	bounce_in
	bounce_out
	bounce_in_out
}

pub fn (k Kind) eval(val f32) f32 {
	return match k {
		.linear { linear(val) }
		.quadratic_in { quadratic_in(val) }
		.quadratic_out { quadratic_out(val) }
		.quadratic_in_out { quadratic_in_out(val) }
		.cubic_in { cubic_in(val) }
		.cubic_out { cubic_out(val) }
		.cubic_in_out { cubic_in_out(val) }
		.quartic_in { quartic_in(val) }
		.quartic_out { quartic_out(val) }
		.quartic_in_out { quartic_in_out(val) }
		.quintic_in { quintic_in(val) }
		.quintic_out { quintic_out(val) }
		.quintic_in_out { quintic_in_out(val) }
		.sin_in { sin_in(val) }
		.sin_out { sin_out(val) }
		.sin_in_out { sin_in_out(val) }
		.circular_in { circular_in(val) }
		.circular_out { circular_out(val) }
		.circular_in_out { circular_in_out(val) }
		.exponential_in { exponential_in(val) }
		.exponential_out { exponential_out(val) }
		.exponential_in_out { exponential_in_out(val) }
		.elastic_in { elastic_in(val) }
		.elastic_out { elastic_out(val) }
		.elastic_in_out { elastic_in_out(val) }
		.back_in { back_in(val) }
		.back_out { back_out(val) }
		.back_in_out { back_in_out(val) }
		.bounce_in { bounce_in(val) }
		.bounce_out { bounce_out(val) }
		.bounce_in_out { bounce_in_out(val) }
		else { -1 }
	}
}