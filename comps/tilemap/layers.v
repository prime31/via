module tilemaps

pub struct ObjectLayer {
	name string
	visible bool
	objects []Object
}

pub struct ObjectGroupLayer {
	name string
	visible bool	
}

pub struct GroupLayer {
	name string
	visible bool
}
