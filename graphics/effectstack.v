module graphics

pub struct EffectStack {
mut:
	callbacks []EffectStackProcessFn
	contexts []voidptr
}

pub type EffectStackProcessFn fn(voidptr, voidptr /* &Texture */, &EffectStack)

fn effectstack() &EffectStack {
	return &EffectStack{}
}

fn (pp &EffectStack) free() {
	unsafe {
		pp.callbacks.free()
		pp.contexts.free()
		free(pp)
	}
}

pub fn (pp mut EffectStack) add(ctx voidptr, callback EffectStackProcessFn) {
	pp.callbacks << callback
	pp.contexts << ctx
}

pub fn (pp &EffectStack) remove(ctx voidptr) {
	panic('implement remove')
}

fn (pp &EffectStack) process(pass OffScreenPass) {
	for i in 0..pp.callbacks.len {
		cb := pp.callbacks[i]
		ctx := pp.contexts[i]
		texture := pass.color_tex
		cb(ctx, &texture, pp)
	}
}

// helper method for taking the final texture from a postprocessor and blitting it. Simple postprocessors
// can get away with just calling this method directly.
pub fn (pp &EffectStack) blit(tex Texture, pip mut Pipeline) {
	begin_pass({color_action:.dontcare pipeline:pip trans_mat:0 pass:0})
	spritebatch().draw(tex, {x:0 y:0})
	end_pass()
}