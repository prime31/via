module math

pub enum Edge {
	right
	left
	top
	bottom
}

pub fn (e Edge) opposing() Edge {
	return match e {
		.right { Edge.left }
		.left { Edge.right }
		.top { Edge.bottom }
		.bottom { Edge.top }
		else { e }
	}
}

pub fn (e Edge) horizontal() bool {
	return e == .right || e == .left
}

pub fn (e Edge) vertical() bool {
	return e == .top || e == .bottom
}