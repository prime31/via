module imgui
import via.libs.imgui.c

const ( imgui_used_import = c.used_import )

[inline]
pub fn create_context(shared_font_atlas &C.ImFontAtlas) &C.ImGuiContext {
	return C.igCreateContext(shared_font_atlas)
}

[inline]
pub fn destroy_context(ctx &C.ImGuiContext) {
	C.igDestroyContext(ctx)
}

[inline]
pub fn get_current_context() &C.ImGuiContext {
	return C.igGetCurrentContext()
}

[inline]
pub fn set_current_context(ctx &C.ImGuiContext) {
	C.igSetCurrentContext(ctx)
}

[inline]
pub fn debug_check_version_and_data_layout(version_str string, sz_io u32, sz_style u32, sz_vec2 u32, sz_vec4 u32, sz_drawvert u32, sz_drawidx u32) bool {
	return C.igDebugCheckVersionAndDataLayout(version_str.str, sz_io, sz_style, sz_vec2, sz_vec4, sz_drawvert, sz_drawidx)
}

[inline]
pub fn get_i_o() &C.ImGuiIO {
	return C.igGetIO()
}

[inline]
pub fn get_style() &C.ImGuiStyle {
	return C.igGetStyle()
}

[inline]
pub fn get_draw_data() &C.ImDrawData {
	return C.igGetDrawData()
}

[inline]
pub fn show_demo_window(p_open &bool) {
	C.igShowDemoWindow(p_open)
}

[inline]
pub fn show_about_window(p_open &bool) {
	C.igShowAboutWindow(p_open)
}

[inline]
pub fn show_metrics_window(p_open &bool) {
	C.igShowMetricsWindow(p_open)
}

[inline]
pub fn show_style_editor(ref &C.ImGuiStyle) {
	C.igShowStyleEditor(ref)
}

[inline]
pub fn show_style_selector(label string) bool {
	return C.igShowStyleSelector(label.str)
}

[inline]
pub fn show_font_selector(label string) {
	C.igShowFontSelector(label.str)
}

[inline]
pub fn show_user_guide() {
	C.igShowUserGuide()
}

[inline]
pub fn get_version() string {
	return string(C.igGetVersion())
}

[inline]
pub fn style_colors_dark(dst &C.ImGuiStyle) {
	C.igStyleColorsDark(dst)
}

[inline]
pub fn style_colors_classic(dst &C.ImGuiStyle) {
	C.igStyleColorsClassic(dst)
}

[inline]
pub fn style_colors_lht(dst &C.ImGuiStyle) {
	C.igStyleColorsLight(dst)
}

[inline]
pub fn begin(name string, p_open &bool, flags int) bool {
	return C.igBegin(name.str, p_open, flags)
}

[inline]
pub fn end() {
	C.igEnd()
}

[inline]
pub fn begin_child(str_id string, size C.ImVec2, border bool, flags int) bool {
	return C.igBeginChild(str_id.str, size, border, flags)
}

[inline]
pub fn begin_child_id(id u32, size C.ImVec2, border bool, flags int) bool {
	return C.igBeginChildID(id, size, border, flags)
}

[inline]
pub fn end_child() {
	C.igEndChild()
}

[inline]
pub fn is_window_appearing() bool {
	return C.igIsWindowAppearing()
}

[inline]
pub fn is_window_collapsed() bool {
	return C.igIsWindowCollapsed()
}

[inline]
pub fn is_window_focused(flags int) bool {
	return C.igIsWindowFocused(flags)
}

[inline]
pub fn is_window_hovered(flags int) bool {
	return C.igIsWindowHovered(flags)
}

[inline]
pub fn get_window_draw_list() &C.ImDrawList {
	return C.igGetWindowDrawList()
}

[inline]
pub fn get_window_dpi_scale() f32 {
	return C.igGetWindowDpiScale()
}

[inline]
pub fn get_window_viewport() &C.ImGuiViewport {
	return C.igGetWindowViewport()
}

[inline]
pub fn get_window_pos() C.ImVec2 {
	return C.igGetWindowPos()
}

[inline]
pub fn get_window_size() C.ImVec2 {
	return C.igGetWindowSize()
}

[inline]
pub fn get_window_width() f32 {
	return C.igGetWindowWidth()
}

[inline]
pub fn get_window_heht() f32 {
	return C.igGetWindowHeight()
}

[inline]
pub fn set_next_window_pos(pos C.ImVec2, cond int, pivot C.ImVec2) {
	C.igSetNextWindowPos(pos, cond, pivot)
}

[inline]
pub fn set_next_window_size(size C.ImVec2, cond int) {
	C.igSetNextWindowSize(size, cond)
}

[inline]
pub fn set_next_window_size_constraints(size_min C.ImVec2, size_max C.ImVec2, custom_callback fn(&C.ImGuiSizeCallbackData), custom_callback_data voidptr) {
	C.igSetNextWindowSizeConstraints(size_min, size_max, custom_callback, custom_callback_data)
}

[inline]
pub fn set_next_window_content_size(size C.ImVec2) {
	C.igSetNextWindowContentSize(size)
}

[inline]
pub fn set_next_window_collapsed(collapsed bool, cond int) {
	C.igSetNextWindowCollapsed(collapsed, cond)
}

[inline]
pub fn set_next_window_focus() {
	C.igSetNextWindowFocus()
}

[inline]
pub fn set_next_window_bg_alpha(alpha f32) {
	C.igSetNextWindowBgAlpha(alpha)
}

[inline]
pub fn set_next_window_viewport(viewport_id u32) {
	C.igSetNextWindowViewport(viewport_id)
}

[inline]
pub fn set_window_pos_vec2(pos C.ImVec2, cond int) {
	C.igSetWindowPosVec2(pos, cond)
}

[inline]
pub fn set_window_size_vec2(size C.ImVec2, cond int) {
	C.igSetWindowSizeVec2(size, cond)
}

[inline]
pub fn set_window_collapsed_bool(collapsed bool, cond int) {
	C.igSetWindowCollapsedBool(collapsed, cond)
}

[inline]
pub fn set_window_focus() {
	C.igSetWindowFocus()
}

[inline]
pub fn set_window_font_scale(scale f32) {
	C.igSetWindowFontScale(scale)
}

[inline]
pub fn set_window_pos_str(name string, pos C.ImVec2, cond int) {
	C.igSetWindowPosStr(name.str, pos, cond)
}

[inline]
pub fn set_window_size_str(name string, size C.ImVec2, cond int) {
	C.igSetWindowSizeStr(name.str, size, cond)
}

[inline]
pub fn set_window_collapsed_str(name string, collapsed bool, cond int) {
	C.igSetWindowCollapsedStr(name.str, collapsed, cond)
}

[inline]
pub fn set_window_focus_str(name string) {
	C.igSetWindowFocusStr(name.str)
}

[inline]
pub fn get_content_region_max() C.ImVec2 {
	return C.igGetContentRegionMax()
}

[inline]
pub fn get_content_region_avail() C.ImVec2 {
	return C.igGetContentRegionAvail()
}

[inline]
pub fn get_window_content_region_min() C.ImVec2 {
	return C.igGetWindowContentRegionMin()
}

[inline]
pub fn get_window_content_region_max() C.ImVec2 {
	return C.igGetWindowContentRegionMax()
}

[inline]
pub fn get_window_content_region_width() f32 {
	return C.igGetWindowContentRegionWidth()
}

[inline]
pub fn get_scroll_x() f32 {
	return C.igGetScrollX()
}

[inline]
pub fn get_scroll_y() f32 {
	return C.igGetScrollY()
}

[inline]
pub fn get_scroll_max_x() f32 {
	return C.igGetScrollMaxX()
}

[inline]
pub fn get_scroll_max_y() f32 {
	return C.igGetScrollMaxY()
}

[inline]
pub fn set_scroll_x(scroll_x f32) {
	C.igSetScrollX(scroll_x)
}

[inline]
pub fn set_scroll_y(scroll_y f32) {
	C.igSetScrollY(scroll_y)
}

[inline]
pub fn set_scroll_here_x(center_x_ratio f32) {
	C.igSetScrollHereX(center_x_ratio)
}

[inline]
pub fn set_scroll_here_y(center_y_ratio f32) {
	C.igSetScrollHereY(center_y_ratio)
}

[inline]
pub fn set_scroll_from_pos_x(local_x f32, center_x_ratio f32) {
	C.igSetScrollFromPosX(local_x, center_x_ratio)
}

[inline]
pub fn set_scroll_from_pos_y(local_y f32, center_y_ratio f32) {
	C.igSetScrollFromPosY(local_y, center_y_ratio)
}

[inline]
pub fn push_font(font &C.ImFont) {
	C.igPushFont(font)
}

[inline]
pub fn pop_font() {
	C.igPopFont()
}

[inline]
pub fn push_style_color_u32(idx int, col u32) {
	C.igPushStyleColorU32(idx, col)
}

[inline]
pub fn push_style_color(idx int, col C.ImVec4) {
	C.igPushStyleColor(idx, col)
}

[inline]
pub fn pop_style_color(count int) {
	C.igPopStyleColor(count)
}

[inline]
pub fn push_style_var_float(idx int, val f32) {
	C.igPushStyleVarFloat(idx, val)
}

[inline]
pub fn push_style_var_vec2(idx int, val C.ImVec2) {
	C.igPushStyleVarVec2(idx, val)
}

[inline]
pub fn pop_style_var(count int) {
	C.igPopStyleVar(count)
}

[inline]
pub fn get_style_color_vec4(idx int) &C.ImVec4 {
	return C.igGetStyleColorVec4(idx)
}

[inline]
pub fn get_font() &C.ImFont {
	return C.igGetFont()
}

[inline]
pub fn get_font_size() f32 {
	return C.igGetFontSize()
}

[inline]
pub fn get_font_tex_uv_white_pixel() C.ImVec2 {
	return C.igGetFontTexUvWhitePixel()
}

[inline]
pub fn get_color_u32(idx int, alpha_mul f32) u32 {
	return C.igGetColorU32(idx, alpha_mul)
}

[inline]
pub fn get_color_u32_vec4(col C.ImVec4) u32 {
	return C.igGetColorU32Vec4(col)
}

[inline]
pub fn get_color_u32_u32(col u32) u32 {
	return C.igGetColorU32U32(col)
}

[inline]
pub fn push_item_width(item_width f32) {
	C.igPushItemWidth(item_width)
}

[inline]
pub fn pop_item_width() {
	C.igPopItemWidth()
}

[inline]
pub fn set_next_item_width(item_width f32) {
	C.igSetNextItemWidth(item_width)
}

[inline]
pub fn calc_item_width() f32 {
	return C.igCalcItemWidth()
}

[inline]
pub fn push_text_wrap_pos(wrap_local_pos_x f32) {
	C.igPushTextWrapPos(wrap_local_pos_x)
}

[inline]
pub fn pop_text_wrap_pos() {
	C.igPopTextWrapPos()
}

[inline]
pub fn push_allow_keyboard_focus(allow_keyboard_focus bool) {
	C.igPushAllowKeyboardFocus(allow_keyboard_focus)
}

[inline]
pub fn pop_allow_keyboard_focus() {
	C.igPopAllowKeyboardFocus()
}

[inline]
pub fn push_button_repeat(repeat bool) {
	C.igPushButtonRepeat(repeat)
}

[inline]
pub fn pop_button_repeat() {
	C.igPopButtonRepeat()
}

[inline]
pub fn separator() {
	C.igSeparator()
}

[inline]
pub fn same_line(offset_from_start_x f32, spacing f32) {
	C.igSameLine(offset_from_start_x, spacing)
}

[inline]
pub fn new_line() {
	C.igNewLine()
}

[inline]
pub fn spacing() {
	C.igSpacing()
}

[inline]
pub fn dummy(size C.ImVec2) {
	C.igDummy(size)
}

[inline]
pub fn indent(indent_w f32) {
	C.igIndent(indent_w)
}

[inline]
pub fn unindent(indent_w f32) {
	C.igUnindent(indent_w)
}

[inline]
pub fn begin_group() {
	C.igBeginGroup()
}

[inline]
pub fn end_group() {
	C.igEndGroup()
}

[inline]
pub fn get_cursor_pos() C.ImVec2 {
	return C.igGetCursorPos()
}

[inline]
pub fn get_cursor_pos_x() f32 {
	return C.igGetCursorPosX()
}

[inline]
pub fn get_cursor_pos_y() f32 {
	return C.igGetCursorPosY()
}

[inline]
pub fn set_cursor_pos(local_pos C.ImVec2) {
	C.igSetCursorPos(local_pos)
}

[inline]
pub fn set_cursor_pos_x(local_x f32) {
	C.igSetCursorPosX(local_x)
}

[inline]
pub fn set_cursor_pos_y(local_y f32) {
	C.igSetCursorPosY(local_y)
}

[inline]
pub fn get_cursor_start_pos() C.ImVec2 {
	return C.igGetCursorStartPos()
}

[inline]
pub fn get_cursor_screen_pos() C.ImVec2 {
	return C.igGetCursorScreenPos()
}

[inline]
pub fn set_cursor_screen_pos(pos C.ImVec2) {
	C.igSetCursorScreenPos(pos)
}

[inline]
pub fn aln_text_to_frame_padding() {
	C.igAlignTextToFramePadding()
}

[inline]
pub fn get_text_line_heht() f32 {
	return C.igGetTextLineHeight()
}

[inline]
pub fn get_text_line_heht_with_spacing() f32 {
	return C.igGetTextLineHeightWithSpacing()
}

[inline]
pub fn get_frame_heht() f32 {
	return C.igGetFrameHeight()
}

[inline]
pub fn get_frame_heht_with_spacing() f32 {
	return C.igGetFrameHeightWithSpacing()
}

[inline]
pub fn push_id_str(str_id string) {
	C.igPushIDStr(str_id.str)
}

[inline]
pub fn push_id_range(str_id_begin string, str_id_end string) {
	C.igPushIDRange(str_id_begin.str, str_id_end.str)
}

[inline]
pub fn push_id_ptr(ptr_id voidptr) {
	C.igPushIDPtr(ptr_id)
}

[inline]
pub fn push_id_int(int_id int) {
	C.igPushIDInt(int_id)
}

[inline]
pub fn pop_id() {
	C.igPopID()
}

[inline]
pub fn get_id_str(str_id string) u32 {
	return C.igGetIDStr(str_id.str)
}

[inline]
pub fn get_id_range(str_id_begin string, str_id_end string) u32 {
	return C.igGetIDRange(str_id_begin.str, str_id_end.str)
}

[inline]
pub fn get_id_ptr(ptr_id voidptr) u32 {
	return C.igGetIDPtr(ptr_id)
}

[inline]
pub fn text_unformatted(text string, text_end string) {
	C.igTextUnformatted(text.str, text_end.str)
}

[inline]
pub fn text(fmt string) {
	C.igText(fmt.str)
}

[inline]
pub fn text_v(fmt string, args voidptr /* ...voidptr */) {
	C.igTextV(fmt.str, args)
}

[inline]
pub fn text_colored(col C.ImVec4, fmt string) {
	C.igTextColored(col, fmt.str)
}

[inline]
pub fn text_colored_v(col C.ImVec4, fmt string, args voidptr /* ...voidptr */) {
	C.igTextColoredV(col, fmt.str, args)
}

[inline]
pub fn text_disabled(fmt string) {
	C.igTextDisabled(fmt.str)
}

[inline]
pub fn text_disabled_v(fmt string, args voidptr /* ...voidptr */) {
	C.igTextDisabledV(fmt.str, args)
}

[inline]
pub fn text_wrapped(fmt string) {
	C.igTextWrapped(fmt.str)
}

[inline]
pub fn text_wrapped_v(fmt string, args voidptr /* ...voidptr */) {
	C.igTextWrappedV(fmt.str, args)
}

[inline]
pub fn label_text(label string, fmt string) {
	C.igLabelText(label.str, fmt.str)
}

[inline]
pub fn label_text_v(label string, fmt string, args voidptr /* ...voidptr */) {
	C.igLabelTextV(label.str, fmt.str, args)
}

[inline]
pub fn bullet_text(fmt string) {
	C.igBulletText(fmt.str)
}

[inline]
pub fn bullet_text_v(fmt string, args voidptr /* ...voidptr */) {
	C.igBulletTextV(fmt.str, args)
}

[inline]
pub fn button(label string, size C.ImVec2) bool {
	return C.igButton(label.str, size)
}

[inline]
pub fn small_button(label string) bool {
	return C.igSmallButton(label.str)
}

[inline]
pub fn invisible_button(str_id string, size C.ImVec2) bool {
	return C.igInvisibleButton(str_id.str, size)
}

[inline]
pub fn arrow_button(str_id string, dir int) bool {
	return C.igArrowButton(str_id.str, dir)
}

[inline]
pub fn image(user_texture_id voidptr, size C.ImVec2, uv0 C.ImVec2, uv1 C.ImVec2, tint_col C.ImVec4, border_col C.ImVec4) {
	C.igImage(user_texture_id, size, uv0, uv1, tint_col, border_col)
}

[inline]
pub fn image_button(user_texture_id voidptr, size C.ImVec2, uv0 C.ImVec2, uv1 C.ImVec2, frame_padding int, bg_col C.ImVec4, tint_col C.ImVec4) bool {
	return C.igImageButton(user_texture_id, size, uv0, uv1, frame_padding, bg_col, tint_col)
}

[inline]
pub fn checkbox(label string, v &bool) bool {
	return C.igCheckbox(label.str, v)
}

[inline]
pub fn checkbox_flags(label string, flags &u32, flags_value u32) bool {
	return C.igCheckboxFlags(label.str, flags, flags_value)
}

[inline]
pub fn radio_button_bool(label string, active bool) bool {
	return C.igRadioButtonBool(label.str, active)
}

[inline]
pub fn radio_button_int_ptr(label string, v &int, v_button int) bool {
	return C.igRadioButtonIntPtr(label.str, v, v_button)
}

[inline]
pub fn progress_bar(fraction f32, size_arg C.ImVec2, overlay string) {
	C.igProgressBar(fraction, size_arg, overlay.str)
}

[inline]
pub fn bullet() {
	C.igBullet()
}

[inline]
pub fn begin_combo(label string, preview_value string, flags int) bool {
	return C.igBeginCombo(label.str, preview_value.str, flags)
}

[inline]
pub fn end_combo() {
	C.igEndCombo()
}

[inline]
pub fn combo(label string, current_item &int, items []byteptr, items_count int, popup_max_height_in_items int) bool {
	return C.igCombo(label.str, current_item, items.data, items_count, popup_max_height_in_items)
}

[inline]
pub fn combo_str(label string, current_item &int, items_separated_by_zeros string, popup_max_height_in_items int) bool {
	return C.igComboStr(label.str, current_item, items_separated_by_zeros.str, popup_max_height_in_items)
}

[inline]
pub fn combo_fn_ptr(label string, current_item &int, items_getter fn(voidptr, int, &voidptr /* const char** */) bool, data voidptr, items_count int, popup_max_height_in_items int) bool {
	return C.igComboFnPtr(label.str, current_item, items_getter, data, items_count, popup_max_height_in_items)
}

[inline]
pub fn drag_float(label string, v &f32, v_speed f32, v_min f32, v_max f32, format string, power f32) bool {
	return C.igDragFloat(label.str, v, v_speed, v_min, v_max, format.str, power)
}

[inline]
pub fn drag_float2(label string, v &f32, v_speed f32, v_min f32, v_max f32, format string, power f32) bool {
	return C.igDragFloat2(label.str, v, v_speed, v_min, v_max, format.str, power)
}

[inline]
pub fn drag_float3(label string, v &f32, v_speed f32, v_min f32, v_max f32, format string, power f32) bool {
	return C.igDragFloat3(label.str, v, v_speed, v_min, v_max, format.str, power)
}

[inline]
pub fn drag_float4(label string, v &f32, v_speed f32, v_min f32, v_max f32, format string, power f32) bool {
	return C.igDragFloat4(label.str, v, v_speed, v_min, v_max, format.str, power)
}

[inline]
pub fn drag_float_range2(label string, v_current_min &f32, v_current_max &f32, v_speed f32, v_min f32, v_max f32, format string, format_max string, power f32) bool {
	return C.igDragFloatRange2(label.str, v_current_min, v_current_max, v_speed, v_min, v_max, format.str, format_max.str, power)
}

[inline]
pub fn drag_int(label string, v &int, v_speed f32, v_min int, v_max int, format string) bool {
	return C.igDragInt(label.str, v, v_speed, v_min, v_max, format.str)
}

[inline]
pub fn drag_int2(label string, v &int, v_speed f32, v_min int, v_max int, format string) bool {
	return C.igDragInt2(label.str, v, v_speed, v_min, v_max, format.str)
}

[inline]
pub fn drag_int3(label string, v &int, v_speed f32, v_min int, v_max int, format string) bool {
	return C.igDragInt3(label.str, v, v_speed, v_min, v_max, format.str)
}

[inline]
pub fn drag_int4(label string, v &int, v_speed f32, v_min int, v_max int, format string) bool {
	return C.igDragInt4(label.str, v, v_speed, v_min, v_max, format.str)
}

[inline]
pub fn drag_int_range2(label string, v_current_min &int, v_current_max &int, v_speed f32, v_min int, v_max int, format string, format_max string) bool {
	return C.igDragIntRange2(label.str, v_current_min, v_current_max, v_speed, v_min, v_max, format.str, format_max.str)
}

[inline]
pub fn drag_scalar(label string, data_type int, p_data voidptr, v_speed f32, p_min voidptr, p_max voidptr, format string, power f32) bool {
	return C.igDragScalar(label.str, data_type, p_data, v_speed, p_min, p_max, format.str, power)
}

[inline]
pub fn drag_scalar_n(label string, data_type int, p_data voidptr, components int, v_speed f32, p_min voidptr, p_max voidptr, format string, power f32) bool {
	return C.igDragScalarN(label.str, data_type, p_data, components, v_speed, p_min, p_max, format.str, power)
}

[inline]
pub fn slider_float(label string, v &f32, v_min f32, v_max f32, format string, power f32) bool {
	return C.igSliderFloat(label.str, v, v_min, v_max, format.str, power)
}

[inline]
pub fn slider_float2(label string, v &f32, v_min f32, v_max f32, format string, power f32) bool {
	return C.igSliderFloat2(label.str, v, v_min, v_max, format.str, power)
}

[inline]
pub fn slider_float3(label string, v &f32, v_min f32, v_max f32, format string, power f32) bool {
	return C.igSliderFloat3(label.str, v, v_min, v_max, format.str, power)
}

[inline]
pub fn slider_float4(label string, v &f32, v_min f32, v_max f32, format string, power f32) bool {
	return C.igSliderFloat4(label.str, v, v_min, v_max, format.str, power)
}

[inline]
pub fn slider_angle(label string, v_rad &f32, v_degrees_min f32, v_degrees_max f32, format string) bool {
	return C.igSliderAngle(label.str, v_rad, v_degrees_min, v_degrees_max, format.str)
}

[inline]
pub fn slider_int(label string, v &int, v_min int, v_max int, format string) bool {
	return C.igSliderInt(label.str, v, v_min, v_max, format.str)
}

[inline]
pub fn slider_int2(label string, v &int, v_min int, v_max int, format string) bool {
	return C.igSliderInt2(label.str, v, v_min, v_max, format.str)
}

[inline]
pub fn slider_int3(label string, v &int, v_min int, v_max int, format string) bool {
	return C.igSliderInt3(label.str, v, v_min, v_max, format.str)
}

[inline]
pub fn slider_int4(label string, v &int, v_min int, v_max int, format string) bool {
	return C.igSliderInt4(label.str, v, v_min, v_max, format.str)
}

[inline]
pub fn slider_scalar(label string, data_type int, p_data voidptr, p_min voidptr, p_max voidptr, format string, power f32) bool {
	return C.igSliderScalar(label.str, data_type, p_data, p_min, p_max, format.str, power)
}

[inline]
pub fn slider_scalar_n(label string, data_type int, p_data voidptr, components int, p_min voidptr, p_max voidptr, format string, power f32) bool {
	return C.igSliderScalarN(label.str, data_type, p_data, components, p_min, p_max, format.str, power)
}

[inline]
pub fn v_slider_float(label string, size C.ImVec2, v &f32, v_min f32, v_max f32, format string, power f32) bool {
	return C.igVSliderFloat(label.str, size, v, v_min, v_max, format.str, power)
}

[inline]
pub fn v_slider_int(label string, size C.ImVec2, v &int, v_min int, v_max int, format string) bool {
	return C.igVSliderInt(label.str, size, v, v_min, v_max, format.str)
}

[inline]
pub fn v_slider_scalar(label string, size C.ImVec2, data_type int, p_data voidptr, p_min voidptr, p_max voidptr, format string, power f32) bool {
	return C.igVSliderScalar(label.str, size, data_type, p_data, p_min, p_max, format.str, power)
}

[inline]
pub fn input_float(label string, v &f32, step f32, step_fast f32, format string, flags int) bool {
	return C.igInputFloat(label.str, v, step, step_fast, format.str, flags)
}

[inline]
pub fn input_float2(label string, v &f32, format string, flags int) bool {
	return C.igInputFloat2(label.str, v, format.str, flags)
}

[inline]
pub fn input_float3(label string, v &f32, format string, flags int) bool {
	return C.igInputFloat3(label.str, v, format.str, flags)
}

[inline]
pub fn input_float4(label string, v &f32, format string, flags int) bool {
	return C.igInputFloat4(label.str, v, format.str, flags)
}

[inline]
pub fn input_int(label string, v &int, step int, step_fast int, flags int) bool {
	return C.igInputInt(label.str, v, step, step_fast, flags)
}

[inline]
pub fn input_int2(label string, v &int, flags int) bool {
	return C.igInputInt2(label.str, v, flags)
}

[inline]
pub fn input_int3(label string, v &int, flags int) bool {
	return C.igInputInt3(label.str, v, flags)
}

[inline]
pub fn input_int4(label string, v &int, flags int) bool {
	return C.igInputInt4(label.str, v, flags)
}

[inline]
pub fn input_double(label string, v &f64, step f64, step_fast f64, format string, flags int) bool {
	return C.igInputDouble(label.str, v, step, step_fast, format.str, flags)
}

[inline]
pub fn input_scalar(label string, data_type int, p_data voidptr, p_step voidptr, p_step_fast voidptr, format string, flags int) bool {
	return C.igInputScalar(label.str, data_type, p_data, p_step, p_step_fast, format.str, flags)
}

[inline]
pub fn input_scalar_n(label string, data_type int, p_data voidptr, components int, p_step voidptr, p_step_fast voidptr, format string, flags int) bool {
	return C.igInputScalarN(label.str, data_type, p_data, components, p_step, p_step_fast, format.str, flags)
}

[inline]
pub fn color_edit3(label string, col &f32, flags int) bool {
	return C.igColorEdit3(label.str, col, flags)
}

[inline]
pub fn color_edit4(label string, col &f32, flags int) bool {
	return C.igColorEdit4(label.str, col, flags)
}

[inline]
pub fn color_picker3(label string, col &f32, flags int) bool {
	return C.igColorPicker3(label.str, col, flags)
}

[inline]
pub fn color_picker4(label string, col &f32, flags int, ref_col &f32) bool {
	return C.igColorPicker4(label.str, col, flags, ref_col)
}

[inline]
pub fn color_button(desc_id string, col C.ImVec4, flags int, size C.ImVec2) bool {
	return C.igColorButton(desc_id.str, col, flags, size)
}

[inline]
pub fn set_color_edit_options(flags int) {
	C.igSetColorEditOptions(flags)
}

[inline]
pub fn tree_node_str(label string) bool {
	return C.igTreeNodeStr(label.str)
}

[inline]
pub fn tree_node_str_str(str_id string, fmt string) bool {
	return C.igTreeNodeStrStr(str_id.str, fmt.str)
}

[inline]
pub fn tree_node_ptr(ptr_id voidptr, fmt string) bool {
	return C.igTreeNodePtr(ptr_id, fmt.str)
}

[inline]
pub fn tree_node_v_str(str_id string, fmt string, args voidptr /* ...voidptr */) bool {
	return C.igTreeNodeVStr(str_id.str, fmt.str, args)
}

[inline]
pub fn tree_node_v_ptr(ptr_id voidptr, fmt string, args voidptr /* ...voidptr */) bool {
	return C.igTreeNodeVPtr(ptr_id, fmt.str, args)
}

[inline]
pub fn tree_node_ex_str(label string, flags int) bool {
	return C.igTreeNodeExStr(label.str, flags)
}

[inline]
pub fn tree_node_ex_str_str(str_id string, flags int, fmt string) bool {
	return C.igTreeNodeExStrStr(str_id.str, flags, fmt.str)
}

[inline]
pub fn tree_node_ex_ptr(ptr_id voidptr, flags int, fmt string) bool {
	return C.igTreeNodeExPtr(ptr_id, flags, fmt.str)
}

[inline]
pub fn tree_node_ex_v_str(str_id string, flags int, fmt string, args voidptr /* ...voidptr */) bool {
	return C.igTreeNodeExVStr(str_id.str, flags, fmt.str, args)
}

[inline]
pub fn tree_node_ex_v_ptr(ptr_id voidptr, flags int, fmt string, args voidptr /* ...voidptr */) bool {
	return C.igTreeNodeExVPtr(ptr_id, flags, fmt.str, args)
}

[inline]
pub fn tree_push_str(str_id string) {
	C.igTreePushStr(str_id.str)
}

[inline]
pub fn tree_push_ptr(ptr_id voidptr) {
	C.igTreePushPtr(ptr_id)
}

[inline]
pub fn tree_pop() {
	C.igTreePop()
}

[inline]
pub fn get_tree_node_to_label_spacing() f32 {
	return C.igGetTreeNodeToLabelSpacing()
}

[inline]
pub fn collapsing_header(label string, flags int) bool {
	return C.igCollapsingHeader(label.str, flags)
}

[inline]
pub fn collapsing_header_bool_ptr(label string, p_open &bool, flags int) bool {
	return C.igCollapsingHeaderBoolPtr(label.str, p_open, flags)
}

[inline]
pub fn set_next_item_open(is_open bool, cond int) {
	C.igSetNextItemOpen(is_open, cond)
}

[inline]
pub fn selectable(label string, selected bool, flags int, size C.ImVec2) bool {
	return C.igSelectable(label.str, selected, flags, size)
}

[inline]
pub fn plot_lines(label string, values &f32, values_count int, values_offset int, overlay_text string, scale_min f32, scale_max f32, graph_size C.ImVec2, stride int) {
	C.igPlotLines(label.str, values, values_count, values_offset, overlay_text.str, scale_min, scale_max, graph_size, stride)
}

[inline]
pub fn plot_lines_fn_ptr(label string, values_getter fn(voidptr, int) f32, data voidptr, values_count int, values_offset int, overlay_text string, scale_min f32, scale_max f32, graph_size C.ImVec2) {
	C.igPlotLinesFnPtr(label.str, values_getter, data, values_count, values_offset, overlay_text.str, scale_min, scale_max, graph_size)
}

[inline]
pub fn plot_histogram_float_ptr(label string, values &f32, values_count int, values_offset int, overlay_text string, scale_min f32, scale_max f32, graph_size C.ImVec2, stride int) {
	C.igPlotHistogramFloatPtr(label.str, values, values_count, values_offset, overlay_text.str, scale_min, scale_max, graph_size, stride)
}

[inline]
pub fn plot_histogram_fn_ptr(label string, values_getter fn(voidptr, int) f32, data voidptr, values_count int, values_offset int, overlay_text string, scale_min f32, scale_max f32, graph_size C.ImVec2) {
	C.igPlotHistogramFnPtr(label.str, values_getter, data, values_count, values_offset, overlay_text.str, scale_min, scale_max, graph_size)
}

[inline]
pub fn value_bool(prefix string, b bool) {
	C.igValueBool(prefix.str, b)
}

[inline]
pub fn value_int(prefix string, v int) {
	C.igValueInt(prefix.str, v)
}

[inline]
pub fn value_uint(prefix string, v u32) {
	C.igValueUint(prefix.str, v)
}

[inline]
pub fn value_float(prefix string, v f32, float_format string) {
	C.igValueFloat(prefix.str, v, float_format.str)
}

[inline]
pub fn begin_menu_bar() bool {
	return C.igBeginMenuBar()
}

[inline]
pub fn end_menu_bar() {
	C.igEndMenuBar()
}

[inline]
pub fn begin_main_menu_bar() bool {
	return C.igBeginMainMenuBar()
}

[inline]
pub fn end_main_menu_bar() {
	C.igEndMainMenuBar()
}

[inline]
pub fn begin_menu(label string, enabled bool) bool {
	return C.igBeginMenu(label.str, enabled)
}

[inline]
pub fn end_menu() {
	C.igEndMenu()
}

[inline]
pub fn menu_item_bool(label string, shortcut string, selected bool, enabled bool) bool {
	return C.igMenuItemBool(label.str, shortcut.str, selected, enabled)
}

[inline]
pub fn menu_item_bool_ptr(label string, shortcut string, p_selected &bool, enabled bool) bool {
	return C.igMenuItemBoolPtr(label.str, shortcut.str, p_selected, enabled)
}

[inline]
pub fn begin_tooltip() {
	C.igBeginTooltip()
}

[inline]
pub fn end_tooltip() {
	C.igEndTooltip()
}

[inline]
pub fn set_tooltip(fmt string) {
	C.igSetTooltip(fmt.str)
}

[inline]
pub fn set_tooltip_v(fmt string, args voidptr /* ...voidptr */) {
	C.igSetTooltipV(fmt.str, args)
}

[inline]
pub fn open_popup(str_id string) {
	C.igOpenPopup(str_id.str)
}

[inline]
pub fn begin_popup(str_id string, flags int) bool {
	return C.igBeginPopup(str_id.str, flags)
}

[inline]
pub fn begin_popup_context_item(str_id string, mouse_button int) bool {
	return C.igBeginPopupContextItem(str_id.str, mouse_button)
}

[inline]
pub fn begin_popup_context_window(str_id string, mouse_button int, also_over_items bool) bool {
	return C.igBeginPopupContextWindow(str_id.str, mouse_button, also_over_items)
}

[inline]
pub fn begin_popup_context_void(str_id string, mouse_button int) bool {
	return C.igBeginPopupContextVoid(str_id.str, mouse_button)
}

[inline]
pub fn begin_popup_modal(name string, p_open &bool, flags int) bool {
	return C.igBeginPopupModal(name.str, p_open, flags)
}

[inline]
pub fn end_popup() {
	C.igEndPopup()
}

[inline]
pub fn open_popup_on_item_click(str_id string, mouse_button int) bool {
	return C.igOpenPopupOnItemClick(str_id.str, mouse_button)
}

[inline]
pub fn is_popup_open(str_id string) bool {
	return C.igIsPopupOpen(str_id.str)
}

[inline]
pub fn close_current_popup() {
	C.igCloseCurrentPopup()
}

[inline]
pub fn columns(count int, id string, border bool) {
	C.igColumns(count, id.str, border)
}

[inline]
pub fn next_column() {
	C.igNextColumn()
}

[inline]
pub fn get_column_index() int {
	return C.igGetColumnIndex()
}

[inline]
pub fn get_column_width(column_index int) f32 {
	return C.igGetColumnWidth(column_index)
}

[inline]
pub fn set_column_width(column_index int, width f32) {
	C.igSetColumnWidth(column_index, width)
}

[inline]
pub fn get_column_offset(column_index int) f32 {
	return C.igGetColumnOffset(column_index)
}

[inline]
pub fn set_column_offset(column_index int, offset_x f32) {
	C.igSetColumnOffset(column_index, offset_x)
}

[inline]
pub fn get_columns_count() int {
	return C.igGetColumnsCount()
}

[inline]
pub fn begin_tab_bar(str_id string, flags int) bool {
	return C.igBeginTabBar(str_id.str, flags)
}

[inline]
pub fn end_tab_bar() {
	C.igEndTabBar()
}

[inline]
pub fn begin_tab_item(label string, p_open &bool, flags int) bool {
	return C.igBeginTabItem(label.str, p_open, flags)
}

[inline]
pub fn end_tab_item() {
	C.igEndTabItem()
}

[inline]
pub fn set_tab_item_closed(tab_or_docked_window_label string) {
	C.igSetTabItemClosed(tab_or_docked_window_label.str)
}

[inline]
pub fn dock_space(id u32, size C.ImVec2, flags int, window_class &C.ImGuiWindowClass) {
	C.igDockSpace(id, size, flags, window_class)
}

[inline]
pub fn dock_space_over_viewport(viewport &C.ImGuiViewport, flags int, window_class &C.ImGuiWindowClass) u32 {
	return C.igDockSpaceOverViewport(viewport, flags, window_class)
}

[inline]
pub fn set_next_window_dock_id(dock_id u32, cond int) {
	C.igSetNextWindowDockID(dock_id, cond)
}

[inline]
pub fn set_next_window_class(window_class &C.ImGuiWindowClass) {
	C.igSetNextWindowClass(window_class)
}

[inline]
pub fn get_window_dock_id() u32 {
	return C.igGetWindowDockID()
}

[inline]
pub fn is_window_docked() bool {
	return C.igIsWindowDocked()
}

[inline]
pub fn log_to_tty(auto_open_depth int) {
	C.igLogToTTY(auto_open_depth)
}

[inline]
pub fn log_to_file(auto_open_depth int, filename string) {
	C.igLogToFile(auto_open_depth, filename.str)
}

[inline]
pub fn log_to_clipboard(auto_open_depth int) {
	C.igLogToClipboard(auto_open_depth)
}

[inline]
pub fn log_finish() {
	C.igLogFinish()
}

[inline]
pub fn log_buttons() {
	C.igLogButtons()
}

[inline]
pub fn begin_drag_drop_source(flags int) bool {
	return C.igBeginDragDropSource(flags)
}

[inline]
pub fn set_drag_drop_payload(typ string, data voidptr, sz u32, cond int) bool {
	return C.igSetDragDropPayload(typ.str, data, sz, cond)
}

[inline]
pub fn end_drag_drop_source() {
	C.igEndDragDropSource()
}

[inline]
pub fn begin_drag_drop_target() bool {
	return C.igBeginDragDropTarget()
}

[inline]
pub fn accept_drag_drop_payload(typ string, flags int) &C.ImGuiPayload {
	return C.igAcceptDragDropPayload(typ.str, flags)
}

[inline]
pub fn end_drag_drop_target() {
	C.igEndDragDropTarget()
}

[inline]
pub fn get_drag_drop_payload() &C.ImGuiPayload {
	return C.igGetDragDropPayload()
}

[inline]
pub fn push_clip_rect(clip_rect_min C.ImVec2, clip_rect_max C.ImVec2, intersect_with_current_clip_rect bool) {
	C.igPushClipRect(clip_rect_min, clip_rect_max, intersect_with_current_clip_rect)
}

[inline]
pub fn pop_clip_rect() {
	C.igPopClipRect()
}

[inline]
pub fn set_item_default_focus() {
	C.igSetItemDefaultFocus()
}

[inline]
pub fn set_keyboard_focus_here(offset int) {
	C.igSetKeyboardFocusHere(offset)
}

[inline]
pub fn is_item_hovered(flags int) bool {
	return C.igIsItemHovered(flags)
}

[inline]
pub fn is_item_active() bool {
	return C.igIsItemActive()
}

[inline]
pub fn is_item_focused() bool {
	return C.igIsItemFocused()
}

[inline]
pub fn is_item_clicked(mouse_button int) bool {
	return C.igIsItemClicked(mouse_button)
}

[inline]
pub fn is_item_visible() bool {
	return C.igIsItemVisible()
}

[inline]
pub fn is_item_edited() bool {
	return C.igIsItemEdited()
}

[inline]
pub fn is_item_activated() bool {
	return C.igIsItemActivated()
}

[inline]
pub fn is_item_deactivated() bool {
	return C.igIsItemDeactivated()
}

[inline]
pub fn is_item_deactivated_after_edit() bool {
	return C.igIsItemDeactivatedAfterEdit()
}

[inline]
pub fn is_item_toggled_open() bool {
	return C.igIsItemToggledOpen()
}

[inline]
pub fn is_any_item_hovered() bool {
	return C.igIsAnyItemHovered()
}

[inline]
pub fn is_any_item_active() bool {
	return C.igIsAnyItemActive()
}

[inline]
pub fn is_any_item_focused() bool {
	return C.igIsAnyItemFocused()
}

[inline]
pub fn get_item_rect_min() C.ImVec2 {
	return C.igGetItemRectMin()
}

[inline]
pub fn get_item_rect_max() C.ImVec2 {
	return C.igGetItemRectMax()
}

[inline]
pub fn get_item_rect_size() C.ImVec2 {
	return C.igGetItemRectSize()
}

[inline]
pub fn set_item_allow_overlap() {
	C.igSetItemAllowOverlap()
}

[inline]
pub fn is_rect_visible(size C.ImVec2) bool {
	return C.igIsRectVisible(size)
}

[inline]
pub fn is_rect_visible_vec2(rect_min C.ImVec2, rect_max C.ImVec2) bool {
	return C.igIsRectVisibleVec2(rect_min, rect_max)
}

[inline]
pub fn get_frame_count() int {
	return C.igGetFrameCount()
}

[inline]
pub fn get_background_draw_list() &C.ImDrawList {
	return C.igGetBackgroundDrawList()
}

[inline]
pub fn get_foreground_draw_list() &C.ImDrawList {
	return C.igGetForegroundDrawList()
}

[inline]
pub fn get_background_draw_list_viewport_ptr(viewport &C.ImGuiViewport) &C.ImDrawList {
	return C.igGetBackgroundDrawListViewportPtr(viewport)
}

[inline]
pub fn get_foreground_draw_list_viewport_ptr(viewport &C.ImGuiViewport) &C.ImDrawList {
	return C.igGetForegroundDrawListViewportPtr(viewport)
}

[inline]
pub fn get_draw_list_shared_data() &C.ImDrawListSharedData {
	return C.igGetDrawListSharedData()
}

[inline]
pub fn get_style_color_name(idx int) string {
	return string(C.igGetStyleColorName(idx))
}

[inline]
pub fn set_state_storage(storage &C.ImGuiStorage) {
	C.igSetStateStorage(storage)
}

[inline]
pub fn get_state_storage() &C.ImGuiStorage {
	return C.igGetStateStorage()
}

[inline]
pub fn calc_text_size(text string, text_end string, hide_text_after_double_hash bool, wrap_width f32) C.ImVec2 {
	return C.igCalcTextSize(text.str, text_end.str, hide_text_after_double_hash, wrap_width)
}

[inline]
pub fn calc_list_clipping(items_count int, items_height f32, out_items_display_start &int, out_items_display_end &int) {
	C.igCalcListClipping(items_count, items_height, out_items_display_start, out_items_display_end)
}

[inline]
pub fn begin_child_frame(id u32, size C.ImVec2, flags int) bool {
	return C.igBeginChildFrame(id, size, flags)
}

[inline]
pub fn end_child_frame() {
	C.igEndChildFrame()
}

[inline]
pub fn get_key_index(imgui_key int) int {
	return C.igGetKeyIndex(imgui_key)
}

[inline]
pub fn is_key_down(user_key_index int) bool {
	return C.igIsKeyDown(user_key_index)
}

[inline]
pub fn is_key_pressed(user_key_index int, repeat bool) bool {
	return C.igIsKeyPressed(user_key_index, repeat)
}

[inline]
pub fn is_key_released(user_key_index int) bool {
	return C.igIsKeyReleased(user_key_index)
}

[inline]
pub fn get_key_pressed_amount(key_index int, repeat_delay f32, rate f32) int {
	return C.igGetKeyPressedAmount(key_index, repeat_delay, rate)
}

[inline]
pub fn is_mouse_down(button int) bool {
	return C.igIsMouseDown(button)
}

[inline]
pub fn is_any_mouse_down() bool {
	return C.igIsAnyMouseDown()
}

[inline]
pub fn is_mouse_clicked(button int, repeat bool) bool {
	return C.igIsMouseClicked(button, repeat)
}

[inline]
pub fn is_mouse_double_clicked(button int) bool {
	return C.igIsMouseDoubleClicked(button)
}

[inline]
pub fn is_mouse_released(button int) bool {
	return C.igIsMouseReleased(button)
}

[inline]
pub fn is_mouse_dragging(button int, lock_threshold f32) bool {
	return C.igIsMouseDragging(button, lock_threshold)
}

[inline]
pub fn is_mouse_hovering_rect(r_min C.ImVec2, r_max C.ImVec2, clip bool) bool {
	return C.igIsMouseHoveringRect(r_min, r_max, clip)
}

[inline]
pub fn is_mouse_pos_valid(mouse_pos &C.ImVec2) bool {
	return C.igIsMousePosValid(mouse_pos)
}

[inline]
pub fn get_mouse_pos() C.ImVec2 {
	return C.igGetMousePos()
}

[inline]
pub fn get_mouse_pos_on_opening_current_popup() C.ImVec2 {
	return C.igGetMousePosOnOpeningCurrentPopup()
}

[inline]
pub fn get_mouse_drag_delta(button int, lock_threshold f32) C.ImVec2 {
	return C.igGetMouseDragDelta(button, lock_threshold)
}

[inline]
pub fn reset_mouse_drag_delta(button int) {
	C.igResetMouseDragDelta(button)
}

[inline]
pub fn get_mouse_cursor() int {
	return C.igGetMouseCursor()
}

[inline]
pub fn set_mouse_cursor(typ int) {
	C.igSetMouseCursor(typ)
}

[inline]
pub fn capture_keyboard_from_app(want_capture_keyboard_value bool) {
	C.igCaptureKeyboardFromApp(want_capture_keyboard_value)
}

[inline]
pub fn capture_mouse_from_app(want_capture_mouse_value bool) {
	C.igCaptureMouseFromApp(want_capture_mouse_value)
}

[inline]
pub fn get_clipboard_text() string {
	return string(C.igGetClipboardText())
}

[inline]
pub fn set_clipboard_text(text string) {
	C.igSetClipboardText(text.str)
}
