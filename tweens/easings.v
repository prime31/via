module tweens
import via.math

// sourced from: https://github.com/vlang/vsl/blob/master/easings/easings.v

// linear is a method of curve fitting using linear polynomials to construct new data points within the range of a discrete set of known data points
[inline]
pub fn linear(p f32) f32 {
  	return p
}

// quadratic_in eases in with a power of 2
[inline]
pub fn quadratic_in(p f32) f32 {
  	return p * p
}

// quadratic_easing_eases out with a power of 2
[inline]
pub fn quadratic_out(p f32) f32 {
  	return -(p * (p - 2))
}

// quadratic_easing_in_out speeds up function's growth in a power of 2, then slows down after a half at the same rate
[inline]
pub fn quadratic_in_out(p f32) f32 {
  	if (p < 0.5) {
  	  	return 2.0 * p * p
  	} else {
  	  	return (-2.0 * p * p) + (4.0 * p) - 1
  	}
}

// cubic_in eases in with a power of 3
[inline]
pub fn cubic_in(p f32) f32 {
  	return p * p * p
}

// cubic_out eases out with a power of 3
[inline]
pub fn cubic_out(p f32) f32 {
  	f := p - 1.0
  	return f * f * f + 1.0
}

// cubic_in_out speeds up function's growth in a power of 3, then slows down after a half at the same rate
[inline]
pub fn cubic_in_out(p f32) f32 {
  	if (p < 0.5) {
  	  	return 4.0 * p * p * p
  	} else {
  	  	f := ((2.0 * p) - 2.0)
  	  	return 0.5 * f * f * f + 1.0
  	}
}

// quartic_in eases in with a power of 4
[inline]
pub fn quartic_in(p f32) f32 {
  	return p * p * p * p
}

// quartic_out eases out with a power of 4
[inline]
pub fn quartic_out(p f32) f32 {
  	f := (p - 1.0)
  	return f * f * f * (1.0 - p) + 1.0
}

// quartic_in_out speeds up function's growth in a power of 4, then slows down after a half at the same rate
[inline]
pub fn quartic_in_out(p f32) f32 {
  	if (p < 0.5) {
  	  	return 8.0 * p * p * p * p
  	} else {
  	  	f := (p - 1.0)
  	  	return -8.0 * f * f * f * f + 1.0
  	}
}

// quintic_in eases in with a power of 5
[inline]
pub fn quintic_in(p f32) f32 {
  	return p * p * p * p * p
}

// quintic_out eases out with a power of 5
[inline]
pub fn quintic_out(p f32) f32 {
  	f := (p - 1.0)
  	return f * f * f * f * f + 1
}

// quintic_in_out speeds up function's growth in a power of 5, then slows down after a half at the same rate
[inline]
pub fn quintic_in_out(p f32) f32 {
  	if (p < 0.5) {
  	  	return 16.0 * p * p * p * p * p
  	} else {
  	  	f := ((2.0 * p) - 2.0)
  	  	return  	0.5 * f * f * f * f * f + 1.0
  	}
}

// sin_in accelerates using a sine formula
[inline]
pub fn sin_in(p f32) f32 {
  	return math.sin((p - 1.0) * math.tau) + 1.0
}

// sin_out decelerates using a sine formula
[inline]
pub fn sin_out(p f32) f32 {
  	return math.sin(p * math.tau)
}

// sin_in_out accelerates and decelerates using a sine formula
[inline]
pub fn sin_in_out(p f32) f32 {
  	return 0.5 * (1.0 - math.cos(p * math.pi))
}

// circular_in accelerates using a circular function
[inline]
pub fn circular_in(p f32) f32 {
  	return 1.0 - math.sqrt(1.0 - (p * p))
}

// circular_out decelerates using a circular function
[inline]
pub fn circular_out(p f32) f32 {
  	return math.sqrt((2.0 - p) * p)
}

// circular_in_out accelerates and decelerates using a circular function
[inline]
pub fn circular_in_out(p f32) f32 {
  	if (p < 0.5) {
  	  	return 0.5 * (1.0 - math.sqrt(1.0 - 4.0 * (p * p)))
  	} else {
  	  	return 0.5 * (math.sqrt(-((2.0 * p) - 3.0) * ((2.0 * p) - 1.0)) + 1.0)
  	}
}

// exponential_in accelerates using an exponential formula
[inline]
pub fn exponential_in(p f32) f32 {
  	return if p == 0.0 { p } else { math.pow(2, 10.0 * (p - 1.0)) }
}

// exponential_out decelerates using an exponential formula
[inline]
pub fn exponential_out(p f32) f32 {
  	return if p == 1.0 { p } else { 1.0 - math.pow(2, -10.0 * p) }
}

// exponential_in_out accelerates and decelerates using an exponential formula
[inline]
pub fn exponential_in_out(p f32) f32 {
  	if (p == 0.0 || p == 1.0) {
  	  	return p
  	}

  	if (p < 0.5) {
  	  	return 0.5 * math.pow(2, (20.0 * p) - 10.0)
  	} else {
  	  	return -0.5 * math.pow(2, (-20.0 * p) + 10.0) + 1
  	}
}

// elastic_in resembles a spring oscillating back and forth, then accelerates
[inline]
pub fn elastic_in(p f32) f32 {
  	return math.sin(13.0 * math.tau * p) * math.pow(2, 10.0 * (p - 1.0))
}

// elastic_out resembles a spring oscillating back and forth, then decelerates
[inline]
pub fn elastic_out(p f32) f32 {
  	return math.sin(-13.0 * math.tau * (p + 1.0)) * math.pow(2, -10.0 * p) + 1.0
}

// elastic_in_out resembles a spring oscillating back and forth before it begins to accelerate, then resembles a spring oscillating back and forth before it begins to decelerate afer a half
[inline]
pub fn elastic_in_out(p f32) f32 {
  	if (p < 0.5) {
  	  	return 0.5 * math.sin(13.0 * math.tau * (2.0 * p)) * math.pow(2, 10.0 * ((2.0 * p) - 1.0))
  	} else {
  	  	return 0.5 * (math.sin(-13.0 * math.tau * ((2.0 * p - 1.0) + 1.0)) * math.pow(2, -10.0 * (2.0 * p - 1.0)) + 2.0)
  	}
}

// back_in retracts the motion slightly before it begins to accelerate
[inline]
pub fn back_in(p f32) f32 {
  	return p * p * p - p * math.sin(p * math.pi)
}

// back_out retracts the motion slightly before it begins to decelerate
[inline]
pub fn back_out(p f32) f32 {
  	f := (1.0 - p)
  	return 1.0 - (f * f * f - f * math.sin(f * math.pi))
}

// back_in_out retracts the motion slightly before it begins to accelerate, then retracts the motion slightly before it begins to decelerate afer a half
[inline]
pub fn back_in_out(p f32) f32 {
  	if (p < 0.5) {
  	  	f := 2.0 * p
  	  	return 0.5 * (f * f * f - f * math.sin(f * math.pi))
  	} else {
  	  	f := (1.0 - (2.0 * p - 1.0 ))
  	  	return 0.5 * (1.0 - (f * f * f - f * math.sin(f * math.pi))) + 0.5
  	}
}

// bounce_in creates a bouncing effect, then accelerates
[inline]
pub fn bounce_in(p f32) f32 {
  	return 1.0 - bounce_out(1.0 - p)
}

// bounce_out creates a bouncing effect, then decelerates
[inline]
pub fn bounce_out(p f32) f32 {
  	if (p < 4.0 / 11.0) {
  	  	return (121.0 * p * p) / 16.0
  	} else if (p < 8.0 / 11.0) {
  	  	return (363.0 / 40.0 * p * p) - (99.0 / 10.0 * p) + 17.0 / 5.0
  	} else if (p < 9.0 / 10.0) {
  	  	return (4356.0 / 361.0 * p * p) - (35442.0 / 1805.0 * p) + 16061.0 / 1805.0
  	} else {
  	  	return (54.0 / 5.0 * p * p) - (513.0 / 25.0 * p) + 268.0 / 25.0
  	}
}

// bounce_in_out creates a bouncing effect before it begins to accelerate, then it creates a bouncing effects again before it begins to decelerate
[inline]
pub fn bounce_in_out(p f32) f32 {
  	if (p < 0.5) {
  	  	return 0.5 * bounce_in(p * 2.0)
  	} else {
  	  	return 0.5 * bounce_out(p * 2.0 - 1.0) + 0.5
  	}
}