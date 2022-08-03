module events

pub type EventHandlerFn = fn(voidptr, voidptr, voidptr)

pub struct EventEmitter {
mut:
	handlers []EventHandler
}

struct EventHandler {
	name int
	callback EventHandlerFn
	context voidptr
	once bool
}


pub fn eventemitter() EventEmitter {
	return EventEmitter{}
}

pub fn (mut em EventEmitter) subscribe(name int, callback EventHandlerFn, context voidptr, once bool) {
	em.handlers << EventHandler {
		name: name
		callback: callback
		context: context
		once: once
	}
}

pub fn (mut em EventEmitter) unsubscribe(name int, callback EventHandlerFn) {
	for i := em.handlers.len - 1; i >= 0; i-- {
		event := em.handlers[i]
		if event.name == name && event.callback == callback {
			em.handlers.delete(i)
		}
	}
}

pub fn (em &EventEmitter) is_subscribed(name int, callback EventHandlerFn) bool {
	for event in em.handlers {
		if event.name == name {
			return true
		}
	}
	return false
}

pub fn (mut em EventEmitter) publish(name int, sender voidptr, args voidptr) {
	for i := em.handlers.len - 1; i >= 0; i-- {
		event := em.handlers[i]
		if event.name == name {
			if event.context != voidptr(0) {
				event.callback(event.context, args, sender)
			} else {
				event.callback(args, sender, voidptr(0))
			}

			if event.once {
				em.handlers.delete(i)
			}
		}
	}
}

pub fn (mut em EventEmitter) clear() {
	em.handlers.clear()
}
