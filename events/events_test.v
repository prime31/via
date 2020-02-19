import events

pub enum WindowEvents {
	resize
	open
	close
}

// this is the struct that will house the emitter. It would normally not be public.
pub struct SomeType {
pub:
	emitter events.EventEmitter
}

// wrapper methods for subscribe/unsubscribe locked into an enum type
pub fn (t mut SomeType) subscribe(evt WindowEvents, callback events.EventHandlerFn, context voidptr, once bool) {
	t.emitter.subscribe(int(evt), callback, context, once)
}

pub fn (t mut SomeType) unsubscribe(evt WindowEvents, callback events.EventHandlerFn) {
	t.emitter.unsubscribe(int(evt), callback)
}

pub fn (t mut SomeType) publish(evt WindowEvents) {
	arg := 666
	t.emitter.publish(int(evt), t, &arg)
}


fn test_main() {
	mut t := SomeType{
		emitter: events.eventemitter()
	}

	ctx := 'context fool'
	t.subscribe(.open, on_poop_once, ctx, true)
	t.subscribe(.open, on_poop, voidptr(0), false)
	t.subscribe(.open, on_poop_arg_only, voidptr(0), false)
	t.subscribe(.open, on_poop_no_args, ctx, false)
	t.subscribe(.open, on_poop_all_data, &ctx, false)

	t.publish(.open)

	t.unsubscribe(.open, on_poop_arg_only)
	t.publish(.open)

	t.emitter.clear()
	t.publish(.open)
}

fn on_poop_once() {}

fn on_poop(arg &int, sender &events.EventEmitter) {
	val := *arg
	assert val == 666
}

fn on_poop_arg_only(arg &int) {
	val := *arg
	assert val == 666
}

fn on_poop_all_data(ctx &string, arg &int, sender &events.EventEmitter) {
	val := *arg
	str := *ctx
	assert val == 666
	assert str == 'context fool'
}

fn on_poop_no_args() {}