module c

pub enum ImDrawCornerFlags {
	non = 0
	top_left = 1
	top_right = 2
	bot_left = 4
	bot_right = 8
	top = 3
	bot = 12
	left = 5
	right = 10
	all = 15
}

pub enum ImDrawListFlags {
	non = 0
	anti_aliased_lines = 1
	anti_aliased_fill = 2
	allow_vtx_offset = 4
}

pub enum ImFontAtlasFlags {
	non = 0
	no_power_of_two_height = 1
	no_mouse_cursors = 2
}

pub enum ImGuiBackendFlags {
	non = 0
	has_gamepad = 1
	has_mouse_cursors = 2
	has_set_mouse_pos = 4
	renderer_has_vtx_offset = 8
}

pub enum ImGuiCol {
	text = 0
	text_disabled = 1
	window_bg = 2
	child_bg = 3
	popup_bg = 4
	border = 5
	border_shadow = 6
	frame_bg = 7
	frame_bg_hovered = 8
	frame_bg_active = 9
	title_bg = 10
	title_bg_active = 11
	title_bg_collapsed = 12
	menu_bar_bg = 13
	scrollbar_bg = 14
	scrollbar_grab = 15
	scrollbar_grab_hovered = 16
	scrollbar_grab_active = 17
	check_mark = 18
	slider_grab = 19
	slider_grab_active = 20
	button = 21
	button_hovered = 22
	button_active = 23
	header = 24
	header_hovered = 25
	header_active = 26
	separator = 27
	separator_hovered = 28
	separator_active = 29
	resize_grip = 30
	resize_grip_hovered = 31
	resize_grip_active = 32
	tab = 33
	tab_hovered = 34
	tab_active = 35
	tab_unfocused = 36
	tab_unfocused_active = 37
	plot_lines = 38
	plot_lines_hovered = 39
	plot_histogram = 40
	plot_histogram_hovered = 41
	text_selected_bg = 42
	drag_drop_target = 43
	nav_highlight = 44
	nav_windowing_highlight = 45
	nav_windowing_dim_bg = 46
	modal_window_dim_bg = 47
	c_o_u_n_t = 48
}

pub enum ImGuiColorEditFlags {
	non = 0
	no_alpha = 2
	no_picker = 4
	no_options = 8
	no_small_preview = 16
	no_inputs = 32
	no_tooltip = 64
	no_label = 128
	no_side_preview = 256
	no_drag_drop = 512
	alpha_bar = 65536
	alpha_preview = 131072
	alpha_preview_half = 262144
	h_d_r = 524288
	display_r_g_b = 1048576
	display_h_s_v = 2097152
	display_hex = 4194304
	uint8 = 8388608
	float = 16777216
	picker_hue_bar = 33554432
	picker_hue_wheel = 67108864
	input_r_g_b = 134217728
	input_h_s_v = 268435456
	__options_default = 177209344
	__display_mask = 7340032
	__data_type_mask = 25165824
	__picker_mask = 100663296
	__input_mask = 402653184
}

pub enum ImGuiComboFlags {
	non = 0
	popup_align_left = 1
	height_small = 2
	height_regular = 4
	height_large = 8
	height_largest = 16
	no_arrow_button = 32
	no_preview = 64
	height_mask_ = 30
}

pub enum ImGuiCond {
	always = 1
	once = 2
	first_use_ever = 4
	appearing = 8
}

pub enum ImGuiConfigFlags {
	non = 0
	nav_enable_keyboard = 1
	nav_enable_gamepad = 2
	nav_enable_set_mouse_pos = 4
	nav_no_capture_keyboard = 8
	no_mouse = 16
	no_mouse_cursor_change = 32
	is_s_r_g_b = 1048576
	is_touch_screen = 2097152
}

pub enum ImGuiDataType {
	s8 = 0
	u8 = 1
	s16 = 2
	u16 = 3
	s32 = 4
	u32 = 5
	s64 = 6
	u64 = 7
	float = 8
	double = 9
	c_o_u_n_t = 10
}

pub enum ImGuiDir {
	non = -1
	left = 0
	right = 1
	up = 2
	down = 3
	c_o_u_n_t = 4
}

pub enum ImGuiDragDropFlags {
	non = 0
	source_no_preview_tooltip = 1
	source_no_disable_hover = 2
	source_no_hold_to_open_others = 4
	source_allow_null_i_d = 8
	source_extern = 16
	source_auto_expire_payload = 32
	accept_before_delivery = 1024
	accept_no_draw_default_rect = 2048
	accept_no_preview_tooltip = 4096
	accept_peek_only = 3072
}

pub enum ImGuiFocusedFlags {
	non = 0
	child_windows = 1
	root_window = 2
	any_window = 4
	root_and_child_windows = 3
}

pub enum ImGuiHoveredFlags {
	non = 0
	child_windows = 1
	root_window = 2
	any_window = 4
	allow_when_blocked_by_popup = 8
	allow_when_blocked_by_active_item = 32
	allow_when_overlapped = 64
	allow_when_disabled = 128
	rect_only = 104
	root_and_child_windows = 3
}

pub enum ImGuiInputTextFlags {
	non = 0
	chars_decimal = 1
	chars_hexadecimal = 2
	chars_uppercase = 4
	chars_no_blank = 8
	auto_select_all = 16
	enter_returns_true = 32
	callback_completion = 64
	callback_history = 128
	callback_always = 256
	callback_char_filter = 512
	allow_tab_input = 1024
	ctrl_enter_for_new_line = 2048
	no_horizontal_scroll = 4096
	always_insert_mode = 8192
	read_only = 16384
	password = 32768
	no_undo_redo = 65536
	chars_scientific = 131072
	callback_resize = 262144
	multiline = 1048576
	no_mark_edited = 2097152
}

pub enum ImGuiKey {
	tab = 0
	left_arrow = 1
	right_arrow = 2
	up_arrow = 3
	down_arrow = 4
	page_up = 5
	page_down = 6
	home = 7
	end = 8
	insert = 9
	delete = 10
	backspace = 11
	space = 12
	enter = 13
	escape = 14
	key_pad_enter = 15
	a = 16
	c = 17
	v = 18
	x = 19
	y = 20
	z = 21
	c_o_u_n_t = 22
}

pub enum ImGuiMouseCursor {
	non = -1
	arrow = 0
	text_input = 1
	resize_all = 2
	resize_n_s = 3
	resize_e_w = 4
	resize_n_e_s_w = 5
	resize_n_w_s_e = 6
	hand = 7
	c_o_u_n_t = 8
}

pub enum ImGuiNavInput {
	activate = 0
	cancel = 1
	input = 2
	menu = 3
	dpad_left = 4
	dpad_right = 5
	dpad_up = 6
	dpad_down = 7
	l_stick_left = 8
	l_stick_right = 9
	l_stick_up = 10
	l_stick_down = 11
	focus_prev = 12
	focus_next = 13
	tweak_slow = 14
	tweak_fast = 15
	key_menu_ = 16
	key_left_ = 17
	key_right_ = 18
	key_up_ = 19
	key_down_ = 20
	c_o_u_n_t = 21
	internal_start_ = 16
}

pub enum ImGuiSelectableFlags {
	non = 0
	dont_close_popups = 1
	span_all_columns = 2
	allow_double_click = 4
	disabled = 8
	allow_item_overlap = 16
}

pub enum ImGuiStyleVar {
	alpha = 0
	window_padding = 1
	window_rounding = 2
	window_border_size = 3
	window_min_size = 4
	window_title_align = 5
	child_rounding = 6
	child_border_size = 7
	popup_rounding = 8
	popup_border_size = 9
	frame_padding = 10
	frame_rounding = 11
	frame_border_size = 12
	item_spacing = 13
	item_inner_spacing = 14
	indent_spacing = 15
	scrollbar_size = 16
	scrollbar_rounding = 17
	grab_min_size = 18
	grab_rounding = 19
	tab_rounding = 20
	button_text_align = 21
	selectable_text_align = 22
	c_o_u_n_t = 23
}

pub enum ImGuiTabBarFlags {
	non = 0
	reorderable = 1
	auto_select_new_tabs = 2
	tab_list_popup_button = 4
	no_close_with_middle_mouse_button = 8
	no_tab_list_scrolling_buttons = 16
	no_tooltip = 32
	fitting_policy_resize_down = 64
	fitting_policy_scroll = 128
	fitting_policy_mask_ = 192
	fitting_policy_default_ = 64
}

pub enum ImGuiTabItemFlags {
	non = 0
	unsaved_document = 1
	set_selected = 2
	no_close_with_middle_mouse_button = 4
	no_push_id = 8
}

pub enum ImGuiTreeNodeFlags {
	non = 0
	selected = 1
	framed = 2
	allow_item_overlap = 4
	no_tree_push_on_open = 8
	no_auto_open_on_log = 16
	default_open = 32
	open_on_double_click = 64
	open_on_arrow = 128
	leaf = 256
	bullet = 512
	frame_padding = 1024
	span_avail_width = 2048
	span_full_width = 4096
	nav_left_jumps_back_here = 8192
	collapsing_header = 26
}

pub enum ImGuiWindowFlags {
	non = 0
	no_title_bar = 1
	no_resize = 2
	no_move = 4
	no_scrollbar = 8
	no_scroll_with_mouse = 16
	no_collapse = 32
	always_auto_resize = 64
	no_background = 128
	no_saved_settings = 256
	no_mouse_inputs = 512
	menu_bar = 1024
	horizontal_scrollbar = 2048
	no_focus_on_appearing = 4096
	no_bring_to_front_on_focus = 8192
	always_vertical_scrollbar = 16384
	always_horizontal_scrollbar = 32768
	always_use_window_padding = 65536
	no_nav_inputs = 262144
	no_nav_focus = 524288
	unsaved_document = 1048576
	no_nav = 786432
	no_decoration = 43
	no_inputs = 786944
	nav_flattened = 8388608
	child_window = 16777216
	tooltip = 33554432
	popup = 67108864
	modal = 134217728
	child_menu = 268435456
}