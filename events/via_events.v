module events

// global via events in a separate module to assist with passing data between modules
pub enum ViaEvents {
	nothing_yet
}

/*
struct ViaEventEmitter {
	emitter EventEmitter
}

pub const (
	via = &ViaEventEmitter{
		emitter: eventemitter()
	}
)

pub fn subscribe(evt ViaEvents, callback EventHandlerFn, context voidptr, once bool) {
	mut v := via
	v.emitter.subscribe(int(evt), callback, context, once)
}

pub fn unsubscribe(evt ViaEvents, callback EventHandlerFn) {
	mut v := via
	v.emitter.unsubscribe(int(evt), callback)
}

pub fn publish(evt ViaEvents) {
	arg := 666
	mut v := via
	v.emitter.publish(int(evt), v, &arg)
}
*/