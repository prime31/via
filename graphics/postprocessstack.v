module graphics

pub type PostProcessorFn fn(voidptr, Texture, OffScreenPass)

pub struct PostProcessStack {
	quad &FullscreenQuad
mut:
	callbacks []PostProcessorFn
	contexts []voidptr
}

fn (pp &PostProcessStack) free() {
	unsafe {
		pp.callbacks.free()
		pp.contexts.free()
		free(pp)
	}
}

fn postprocessstack() &PostProcessStack {
	return &PostProcessStack{
		quad: fullscreenquad()
	}
}

pub fn (pp mut PostProcessStack) add(ctx voidptr, callback PostProcessorFn) {
	pp.callbacks << callback
	pp.contexts << ctx
}