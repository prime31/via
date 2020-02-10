module graphics

pub struct PostProcessStack {
mut:
	callbacks []PostProcessorFn
	contexts []voidptr
}

pub type PostProcessorFn fn(voidptr, voidptr /* &Texture */, &PostProcessStack)

pub fn postprocessstack() &PostProcessStack {
	return &PostProcessStack{}
}

fn (pp &PostProcessStack) free() {
	unsafe {
		pp.callbacks.free()
		pp.contexts.free()
		free(pp)
	}
}

pub fn (pp mut PostProcessStack) add(ctx voidptr, callback PostProcessorFn) {
	pp.callbacks << callback
	pp.contexts << ctx
}

pub fn (pp &PostProcessStack) remove(ctx voidptr) {
	panic('implement remove')
}

fn (pp &PostProcessStack) process(pass OffScreenPass) {
	for i in 0..pp.callbacks.len {
		cb := pp.callbacks[i]
		ctx := pp.contexts[i]
		texture := pass.color_tex
		cb(ctx, &texture, pp)
	}
}

// helper method for taking the final texture from a postprocessor and blitting it. Simple postprocessors
// can get away with just calling this method directly.
pub fn (pp &PostProcessStack) blit(tex Texture, pip mut Pipeline) {
	begin_offscreen_pass(g.def_pass.offscreen_pass, {color_action:.dontcare}, {pipeline:pip})
	spritebatch().draw(tex, {x:0 y:0})
	end_pass()
}