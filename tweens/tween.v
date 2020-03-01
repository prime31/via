module tweens

pub struct Tween {
mut:
	pos f32
	pre_delay f32
	post_delay f32
	paused bool
	done bool
	cb TweenTickFn
	ctx voidptr
pub:
	kind Kind
	start f32
	end f32
	duration f32
}

type TweenTickFn fn(ctx voidptr, tween &Tween)


pub fn tween(start, end, duration f32, kind Kind) Tween {
	return Tween{
		kind: kind
		start: start
		end: end
		duration: duration
		ctx: 0
	}
}

pub fn (t mut Tween) set_cb(ctx voidptr, cb TweenTickFn) {
	t.ctx = ctx
	t.cb = cb
}

pub fn (t mut Tween) set_delay(pre_delay, post_delay f32) {
	t.pre_delay = pre_delay
	t.post_delay = post_delay
}

pub fn (t mut Tween) tick(dt f32) {
	if t.paused || t.done { return }

	mut delta := dt
	if t.pre_delay > 0 {
		t.pre_delay -= delta
		if t.pre_delay > 0 { return }
		if t.pre_delay < 0 {
			delta = -t.pre_delay
			t.pre_delay = 0
		}
	}

	t.pos += delta
	if t.pos > t.duration {
		t.pos = t.duration
		if t.post_delay > 0 {
			t.post_delay -= delta
		}
		if t.post_delay <= 0 {
			t.done = true
			if t.cb != 0 {
				t.cb(t.ctx, t)
			}
		}
	}
}

pub fn (t &Tween) value() f32 {
	return t.start + t.kind.eval(t.pos / t.duration) * (t.end - t.start)
}