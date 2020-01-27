module c

pub enum EventType {
	firstevent = 0
	quit = 256
	app_terminating = 257
	app_lowmemory = 258
	app_willenterbackground = 259
	app_didenterbackground = 260
	app_willenterforeground = 261
	app_didenterforeground = 262
	displayevent = 336
	windowevent = 512
	syswmevent = 513
	keydown = 768
	keyup = 769
	textediting = 770
	textinput = 771
	keymapchanged = 772
	mousemotion = 1024
	mousebuttondown = 1025
	mousebuttonup = 1026
	mousewheel = 1027
	joyaxismotion = 1536
	joyballmotion = 1537
	joyhatmotion = 1538
	joybuttondown = 1539
	joybuttonup = 1540
	joydeviceadded = 1541
	joydeviceremoved = 1542
	controlleraxismotion = 1616
	controllerbuttondown = 1617
	controllerbuttonup = 1618
	controllerdeviceadded = 1619
	controllerdeviceremoved = 1620
	controllerdeviceremapped = 1621
	fingerdown = 1792
	fingerup = 1793
	fingermotion = 1794
	dollargesture = 2048
	dollarrecord = 2049
	multigesture = 2050
	clipboardupdate = 2304
	dropfile = 4096
	droptext = 4097
	dropbegin = 4098
	dropcomplete = 4099
	audiodeviceadded = 4352
	audiodeviceremoved = 4353
	sensorupdate = 4608
	render_targets_reset = 8192
	render_device_reset = 8193
	userevent = 32768
	lastevent = 65535
}

pub enum Eventaction {
	addevent
	peekevent
	getevent
}

pub struct C.SDL_CommonEvent {
pub:
	@type u32
	timestamp u32
}

pub struct C.SDL_DisplayEvent {
pub:
    @type u32        /**< ::SDL_DISPLAYEVENT */
    timestamp u32   /**< In milliseconds, populated using SDL_GetTicks() */
    display u32     /**< The associated display index */
    event byte        /**< ::SDL_DisplayEventID */
    padding1 byte
    padding2 byte
    padding3 byte
    data1 int       /**< event dependent data */
}

pub struct C.SDL_WindowEvent {
pub:
	@type EventType   	/**< ::SDL_WINDOWEVENT */
	timestamp u32       /**< In milliseconds, populated using SDL_GetTicks() */
	windowID u32        /**< The associated window */
	event byte          /**< ::SDL_WindowEventID */
	padding1 byte
	padding2 byte
	padding3 byte
	data1 int
	data2 int
}

pub struct C.SDL_KeyboardEvent {
pub:
	@type u32   	/**< ::SDL_KEYDOWN or ::SDL_KEYUP */
	timestamp u32   /**< In milliseconds, populated using SDL_GetTicks() */
	windowID u32   /**< The window with keyboard focus, if any */
	state byte  	/**< ::SDL_PRESSED or ::SDL_RELEASED */
	repeat byte     /**< Non-zero if this is a key repeat */
	padding2 byte
	padding3 byte
	keysym C.SDL_Keysym
}

pub struct C.SDL_TextEditingEvent {
pub:
    @type u32                                /**< ::SDL_TEXTEDITING */
    timestamp u32                           /**< In milliseconds, populated using SDL_GetTicks() */
    windowID u32                            /**< The window with keyboard focus, if any */
    text [32]byte  /**< The editing text */
    start int                               /**< The start cursor of selected editing text */
    length int                              /**< The length of selected editing text */
}

pub struct C.SDL_TextInputEvent {
pub:
    @type u32    	/**< ::SDL_TEXTINPUT */
    timestamp u32	/**< In milliseconds, populated using SDL_GetTicks() */
    windowID u32 	/**< The window with keyboard focus, if any */
    text [32]byte  	/**< The input text */
}

pub struct C.SDL_MouseMotionEvent {
pub:
    @type u32        /**< ::SDL_MOUSEMOTION */
    timestamp u32   /**< In milliseconds, populated using SDL_GetTicks() */
    windowID u32    /**< The window with mouse focus, if any */
    which u32       /**< The mouse instance id, or SDL_TOUCH_MOUSEID */
    state u32       /**< The current button state */
    x int           /**< X coordinate, relative to window */
    y int           /**< Y coordinate, relative to window */
    xrel int        /**< The relative motion in the X direction */
    yrel int        /**< The relative motion in the Y direction */
}

pub struct C.SDL_MouseButtonEvent {
pub:
    @type u32        /**< ::SDL_MOUSEBUTTONDOWN or ::SDL_MOUSEBUTTONUP */
    timestamp u32   /**< In milliseconds, populated using SDL_GetTicks() */
    windowID u32    /**< The window with mouse focus, if any */
    which u32       /**< The mouse instance id, or SDL_TOUCH_MOUSEID */
    button byte       /**< The mouse button index */
    state byte        /**< ::SDL_PRESSED or ::SDL_RELEASED */
    clicks byte       /**< 1 for single-click, 2 for double-click, etc. */
    padding1 byte
    x int           /**< X coordinate, relative to window */
    y int           /**< Y coordinate, relative to window */
}

pub struct C.SDL_MouseWheelEvent {
pub:
    @type u32        /**< ::SDL_MOUSEWHEEL */
    timestamp u32   /**< In milliseconds, populated using SDL_GetTicks() */
    windowID u32    /**< The window with mouse focus, if any */
    which u32       /**< The mouse instance id, or SDL_TOUCH_MOUSEID */
    x int           /**< The amount scrolled horizontally, positive to the right and negative to the left */
    y int           /**< The amount scrolled vertically, positive away from the user and negative toward the user */
    direction u32   /**< Set to one of the SDL_MOUSEWHEEL_* defines. When FLIPPED the values in X and Y will be opposite. Multiply by -1 to change them back */
}

pub struct C.SDL_JoyAxisEvent {
pub:
    @type u32        /**< ::SDL_JOYAXISMOTION */
    timestamp u32   /**< In milliseconds, populated using SDL_GetTicks() */
    which int /**< The joystick instance id */
    axis byte         /**< The joystick axis index */
    padding1 byte
    padding2 byte
    padding3 byte
    value i16       /**< The axis value (range: -32768 to 32767) */
    padding4 u16
}

pub struct C.SDL_JoyBallEvent {
pub:
    @type u32        /**< ::SDL_JOYBALLMOTION */
    timestamp u32   /**< In milliseconds, populated using SDL_GetTicks() */
    which int /**< The joystick instance id */
    ball byte         /**< The joystick trackball index */
    padding1 byte
    padding2 byte
    padding3 byte
    xrel i16        /**< The relative motion in the X direction */
    yrel i16        /**< The relative motion in the Y direction */
}

pub struct C.SDL_JoyHatEvent {
pub:
	@type u32       /**< SDL_JOYHATMOTION */
	timestamp u32
	which int       /**< The joystick device index */
	hat byte        /**< The joystick hat index */
	value byte      /**< The hat position value:
						*   SDL_HAT_LEFTUP   SDL_HAT_UP       SDL_HAT_RIGHTUP
						*   SDL_HAT_LEFT     SDL_HAT_CENTERED SDL_HAT_RIGHT
						*   SDL_HAT_LEFTDOWN SDL_HAT_DOWN     SDL_HAT_RIGHTDOWN
						*  Note that zero means the POV is centered.
						*/
    padding1 byte
    padding2 byte
}

pub struct C.SDL_JoyButtonEvent {
pub:
	@type u32 		/**< SDL_JOYBUTTONDOWN or SDL_JOYBUTTONUP */
	timestamp u32
	which int 		/**< The joystick device index */
	button byte		/**< The joystick button index */
	state byte		/**< SDL_PRESSED or SDL_RELEASED */
    padding1 byte
    padding2 byte
}

pub struct C.SDL_JoyDeviceEvent {
pub:
    @type u32        /**< ::SDL_JOYDEVICEADDED or ::SDL_JOYDEVICEREMOVED */
    timestamp u32   /**< In milliseconds, populated using SDL_GetTicks() */
    which int       /**< The joystick device index for the ADDED event, instance id for the REMOVED event */
}

pub struct C.SDL_ControllerAxisEvent {
pub:
    @type u32        /**< ::SDL_CONTROLLERAXISMOTION */
    timestamp u32   /**< In milliseconds, populated using SDL_GetTicks() */
    which int /**< The joystick instance id */
    axis byte         /**< The controller axis (SDL_GameControllerAxis) */
    padding1 byte
    padding2 byte
    padding3 byte
    value i16       /**< The axis value (range: -32768 to 32767) */
    padding4 u16
}

pub struct C.SDL_ControllerButtonEvent {
pub:
    @type u32        /**< ::SDL_CONTROLLERBUTTONDOWN or ::SDL_CONTROLLERBUTTONUP */
    timestamp u32   /**< In milliseconds, populated using SDL_GetTicks() */
    which int /**< The joystick instance id */
    button byte       /**< The controller button (SDL_GameControllerButton) */
    state byte        /**< ::SDL_PRESSED or ::SDL_RELEASED */
    padding1 byte
    padding2 byte
}

pub struct C.SDL_ControllerDeviceEvent {
pub:
    @type u32        /**< ::SDL_CONTROLLERDEVICEADDED, ::SDL_CONTROLLERDEVICEREMOVED, or ::SDL_CONTROLLERDEVICEREMAPPED */
    timestamp u32   /**< In milliseconds, populated using SDL_GetTicks() */
    which int       /**< The joystick device index for the ADDED event, instance id for the REMOVED or REMAPPED event */
}

pub struct C.SDL_AudioDeviceEvent {
pub:
    @type u32        /**< ::SDL_AUDIODEVICEADDED, or ::SDL_AUDIODEVICEREMOVED */
    timestamp u32   /**< In milliseconds, populated using SDL_GetTicks() */
    which u32       /**< The audio device index for the ADDED event (valid until next SDL_GetNumAudioDevices() call), SDL_AudioDeviceID for the REMOVED event */
    iscapture byte    /**< zero if an output device, non-zero if a capture device. */
    padding1 byte
    padding2 byte
    padding3 byte
}

pub struct C.SDL_TouchFingerEvent {
pub:
    @type u32        /**< ::SDL_FINGERMOTION or ::SDL_FINGERDOWN or ::SDL_FINGERUP */
    timestamp u32   /**< In milliseconds, populated using SDL_GetTicks() */
    touchId i64 /**< The touch device id */
    fingerId i64
    x f32            /**< Normalized in the range 0...1 */
    y f32            /**< Normalized in the range 0...1 */
    dx f32           /**< Normalized in the range -1...1 */
    dy f32           /**< Normalized in the range -1...1 */
    pressure f32     /**< Normalized in the range 0...1 */
}

pub struct C.SDL_MultiGestureEvent {
pub:
    @type u32        /**< ::SDL_MULTIGESTURE */
    timestamp u32   /**< In milliseconds, populated using SDL_GetTicks() */
    touchId i64 /**< The touch device id */
    dTheta f32
    dDist f32
    x f32
    y f32
    numFingers u16
    padding u16
}

pub struct C.SDL_DollarGestureEvent {
pub:
	@type u32
	timestamp u32
	touchId i64
	gestureId i64
	numFingers u32
	error f32
	x f32
	y f32
}

pub struct C.SDL_DropEvent {
pub:
    @type u32        /**< ::SDL_DROPBEGIN or ::SDL_DROPFILE or ::SDL_DROPTEXT or ::SDL_DROPCOMPLETE */
    timestamp u32   /**< In milliseconds, populated using SDL_GetTicks() */
    file byteptr         /**< The file name, which should be freed with SDL_free(), is NULL on begin/complete */
    windowID u32    /**< The window that was dropped on, if any */
}

pub struct C.SDL_SensorEvent {
pub:
    @type u32        /**< ::SDL_SENSORUPDATE */
    timestamp u32   /**< In milliseconds, populated using SDL_GetTicks() */
    which int       /**< The instance ID of the sensor */
    data [6]f32      /**< Up to 6 values from the sensor - additional values can be queried using SDL_SensorGetData() */
}

pub struct C.SDL_QuitEvent {
pub:
	@type u32 /**< SDL_QUIT */
	timestamp u32
}

pub struct C.SDL_OSEvent {
pub:
	@type u32
	timestamp u32
}

pub struct C.SDL_UserEvent {
pub:
    @type u32        /**< ::SDL_USEREVENT through ::SDL_LASTEVENT-1 */
    timestamp u32   /**< In milliseconds, populated using SDL_GetTicks() */
    windowID u32    /**< The associated window if any */
    code int        /**< User defined event code */
    data1 voidptr        /**< User defined data pointer */
    data2 voidptr        /**< User defined data pointer */
}

pub struct C.SDL_SysWMmsg {}

pub struct C.SDL_SysWMEvent {
pub:
	@type u32
	timestamp u32
	msg &SDL_SysWMmsg
}

pub struct C.SDL_Event {
pub:
	@type EventType
	common SDL_CommonEvent
	display SDL_DisplayEvent
	window SDL_WindowEvent
	key SDL_KeyboardEvent
	edit SDL_TextEditingEvent
	text SDL_TextInputEvent
	motion SDL_MouseMotionEvent
	button SDL_MouseButtonEvent
	wheel SDL_MouseWheelEvent
	jaxis SDL_JoyAxisEvent
	jball SDL_JoyBallEvent
	jhat SDL_JoyHatEvent
	jbutton SDL_JoyButtonEvent
	jdevice SDL_JoyDeviceEvent
	caxis SDL_ControllerAxisEvent
	cbutton SDL_ControllerButtonEvent
	cdevice SDL_ControllerDeviceEvent
	adevice SDL_AudioDeviceEvent
	sensor SDL_SensorEvent
	quit SDL_QuitEvent
	user SDL_UserEvent
	syswm SDL_SysWMEvent
	tfinger SDL_TouchFingerEvent
	mgesture SDL_MultiGestureEvent
	dgesture SDL_DollarGestureEvent
	drop SDL_DropEvent
	padding [56]byte
}

fn C.SDL_PumpEvents()
fn C.SDL_PeepEvents(events &SDL_Event, numevents int, action Eventaction, minType u32, maxType u32) int
fn C.SDL_HasEvent(typ u32) Bool
fn C.SDL_HasEvents(minType u32, maxType u32) Bool
fn C.SDL_FlushEvent(typ u32)
fn C.SDL_FlushEvents(minType u32, maxType u32)
fn C.SDL_PollEvent(event &SDL_Event) int
fn C.SDL_WaitEvent(event &SDL_Event) int
fn C.SDL_WaitEventTimeout(event &SDL_Event, timeout int) int
fn C.SDL_PushEvent(event &SDL_Event) int
fn C.SDL_SetEventFilter(filter fn(voidptr, &SDL_Event) int, userdata voidptr)
fn C.SDL_GetEventFilter(filter fn(voidptr, &SDL_Event) int, userdata &voidptr /* void** */) Bool
fn C.SDL_AddEventWatch(filter fn(voidptr, &SDL_Event) int, userdata voidptr)
fn C.SDL_DelEventWatch(filter fn(voidptr, &SDL_Event) int, userdata voidptr)
fn C.SDL_FilterEvents(filter fn(voidptr, &SDL_Event) int, userdata voidptr)
fn C.SDL_EventState(typ u32, state int) byte
fn C.SDL_RegisterEvents(numevents int) u32
