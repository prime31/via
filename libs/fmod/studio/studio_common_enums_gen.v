module studio

pub enum StudioLoadingState {
	unloading
	unloaded
	loading
	loaded
	error
}

pub enum StudioLoadMemoryMode {
	fmod_studio_load_memory
	fmod_studio_load_memory_point
}

pub enum StudioParameterType {
	fmod_studio_parameter_game_controlled
	fmod_studio_parameter_automatic_distance
	fmod_studio_parameter_automatic_event_cone_angle
	fmod_studio_parameter_automatic_event_orientation
	fmod_studio_parameter_automatic_direction
	fmod_studio_parameter_automatic_elevation
	fmod_studio_parameter_automatic_listener_orientation
	fmod_studio_parameter_automatic_speed
	fmod_studio_parameter_max
}

pub enum StudioUserPropertyType {
	integer
	boolean
	float
	str
}

pub enum StudioEventProperty {
	channelpriority
	schedule_delay
	schedule_lookahead
	minimum_distance
	maximum_distance
	max
}

pub enum StudioPlaybackState {
	fmod_studio_playback_playing
	fmod_studio_playback_sustaining
	fmod_studio_playback_stopped
	fmod_studio_playback_starting
	fmod_studio_playback_stopping
}

pub enum StudioStopMode {
	fmod_studio_stop_allowfadeout
	fmod_studio_stop_immediate
}

pub enum StudioInstanceType {
	non
	system
	eventdescription
	eventinstance
	parameterinstance
	bus
	vca
	bank
	commandreplay
}

