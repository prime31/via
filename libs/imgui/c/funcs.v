module c

pub struct C.ImVec2_Simple {
pub:
	x f32
	y f32
}

pub struct C.ImVec4_Simple {
pub:
	x f32
	y f32
	z f32
	w f32
}

pub struct C.ImColor_Simple {
pub:
	Value C.ImVec4_Simple
}

fn C.ImVec2ToSimple(vec C.ImVec2) C.ImVec2_Simple
fn C.ImVec4ToSimple(vec C.ImVec4) C.ImVec4_Simple
fn C.ImColorToSimple(col C.ImColor) C.ImColor_Simple
fn C.ImVec2_ImVec2() &C.ImVec2
fn C.ImVec2_destroy(self &C.ImVec2)
fn C.ImVec2_ImVec2Float(_x f32, _y f32) &C.ImVec2
fn C.ImVec4_ImVec4() &C.ImVec4
fn C.ImVec4_destroy(self &C.ImVec4)
fn C.ImVec4_ImVec4Float(_x f32, _y f32, _z f32, _w f32) &C.ImVec4
fn C.igCreateContext(shared_font_atlas &C.ImFontAtlas) &C.ImGuiContext
fn C.igDestroyContext(ctx &C.ImGuiContext)
fn C.igGetCurrentContext() &C.ImGuiContext
fn C.igSetCurrentContext(ctx &C.ImGuiContext)
fn C.igDebugCheckVersionAndDataLayout(version_str byteptr, sz_io u32, sz_style u32, sz_vec2 u32, sz_vec4 u32, sz_drawvert u32, sz_drawidx u32) bool
fn C.igGetIO() &C.ImGuiIO
fn C.igGetStyle() &C.ImGuiStyle
fn C.igNewFrame()
fn C.igEndFrame()
fn C.igRender()
fn C.igGetDrawData() &C.ImDrawData
fn C.igShowDemoWindow(p_open &bool)
fn C.igShowAboutWindow(p_open &bool)
fn C.igShowMetricsWindow(p_open &bool)
fn C.igShowStyleEditor(ref &C.ImGuiStyle)
fn C.igShowStyleSelector(label byteptr) bool
fn C.igShowFontSelector(label byteptr)
fn C.igShowUserGuide()
fn C.igGetVersion() byteptr
fn C.igStyleColorsDark(dst &C.ImGuiStyle)
fn C.igStyleColorsClassic(dst &C.ImGuiStyle)
fn C.igStyleColorsLight(dst &C.ImGuiStyle)
fn C.igBegin(name byteptr, p_open &bool, flags int) bool
fn C.igEnd()
fn C.igBeginChild(str_id byteptr, size C.ImVec2, border bool, flags int) bool
fn C.igBeginChildID(id u32, size C.ImVec2, border bool, flags int) bool
fn C.igEndChild()
fn C.igIsWindowAppearing() bool
fn C.igIsWindowCollapsed() bool
fn C.igIsWindowFocused(flags int) bool
fn C.igIsWindowHovered(flags int) bool
fn C.igGetWindowDrawList() &C.ImDrawList
fn C.igGetWindowDpiScale() f32
fn C.igGetWindowViewport() &C.ImGuiViewport
fn C.igGetWindowPos() C.ImVec2
fn C.igGetWindowSize() C.ImVec2
fn C.igGetWindowWidth() f32
fn C.igGetWindowHeight() f32
fn C.igSetNextWindowPos(pos C.ImVec2, cond int, pivot C.ImVec2)
fn C.igSetNextWindowSize(size C.ImVec2, cond int)
fn C.igSetNextWindowSizeConstraints(size_min C.ImVec2, size_max C.ImVec2, custom_callback fn(&C.ImGuiSizeCallbackData), custom_callback_data voidptr)
fn C.igSetNextWindowContentSize(size C.ImVec2)
fn C.igSetNextWindowCollapsed(collapsed bool, cond int)
fn C.igSetNextWindowFocus()
fn C.igSetNextWindowBgAlpha(alpha f32)
fn C.igSetNextWindowViewport(viewport_id u32)
fn C.igSetWindowPosVec2(pos C.ImVec2, cond int)
fn C.igSetWindowSizeVec2(size C.ImVec2, cond int)
fn C.igSetWindowCollapsedBool(collapsed bool, cond int)
fn C.igSetWindowFocus()
fn C.igSetWindowFontScale(scale f32)
fn C.igSetWindowPosStr(name byteptr, pos C.ImVec2, cond int)
fn C.igSetWindowSizeStr(name byteptr, size C.ImVec2, cond int)
fn C.igSetWindowCollapsedStr(name byteptr, collapsed bool, cond int)
fn C.igSetWindowFocusStr(name byteptr)
fn C.igGetContentRegionMax() C.ImVec2
fn C.igGetContentRegionAvail() C.ImVec2
fn C.igGetWindowContentRegionMin() C.ImVec2
fn C.igGetWindowContentRegionMax() C.ImVec2
fn C.igGetWindowContentRegionWidth() f32
fn C.igGetScrollX() f32
fn C.igGetScrollY() f32
fn C.igGetScrollMaxX() f32
fn C.igGetScrollMaxY() f32
fn C.igSetScrollX(scroll_x f32)
fn C.igSetScrollY(scroll_y f32)
fn C.igSetScrollHereX(center_x_ratio f32)
fn C.igSetScrollHereY(center_y_ratio f32)
fn C.igSetScrollFromPosX(local_x f32, center_x_ratio f32)
fn C.igSetScrollFromPosY(local_y f32, center_y_ratio f32)
fn C.igPushFont(font &C.ImFont)
fn C.igPopFont()
fn C.igPushStyleColorU32(idx int, col u32)
fn C.igPushStyleColor(idx int, col C.ImVec4)
fn C.igPopStyleColor(count int)
fn C.igPushStyleVarFloat(idx int, val f32)
fn C.igPushStyleVarVec2(idx int, val C.ImVec2)
fn C.igPopStyleVar(count int)
fn C.igGetStyleColorVec4(idx int) &C.ImVec4
fn C.igGetFont() &C.ImFont
fn C.igGetFontSize() f32
fn C.igGetFontTexUvWhitePixel() C.ImVec2
fn C.igGetColorU32(idx int, alpha_mul f32) u32
fn C.igGetColorU32Vec4(col C.ImVec4) u32
fn C.igGetColorU32U32(col u32) u32
fn C.igPushItemWidth(item_width f32)
fn C.igPopItemWidth()
fn C.igSetNextItemWidth(item_width f32)
fn C.igCalcItemWidth() f32
fn C.igPushTextWrapPos(wrap_local_pos_x f32)
fn C.igPopTextWrapPos()
fn C.igPushAllowKeyboardFocus(allow_keyboard_focus bool)
fn C.igPopAllowKeyboardFocus()
fn C.igPushButtonRepeat(repeat bool)
fn C.igPopButtonRepeat()
fn C.igSeparator()
fn C.igSameLine(offset_from_start_x f32, spacing f32)
fn C.igNewLine()
fn C.igSpacing()
fn C.igDummy(size C.ImVec2)
fn C.igIndent(indent_w f32)
fn C.igUnindent(indent_w f32)
fn C.igBeginGroup()
fn C.igEndGroup()
fn C.igGetCursorPos() C.ImVec2
fn C.igGetCursorPosX() f32
fn C.igGetCursorPosY() f32
fn C.igSetCursorPos(local_pos C.ImVec2)
fn C.igSetCursorPosX(local_x f32)
fn C.igSetCursorPosY(local_y f32)
fn C.igGetCursorStartPos() C.ImVec2
fn C.igGetCursorScreenPos() C.ImVec2
fn C.igSetCursorScreenPos(pos C.ImVec2)
fn C.igAlignTextToFramePadding()
fn C.igGetTextLineHeight() f32
fn C.igGetTextLineHeightWithSpacing() f32
fn C.igGetFrameHeight() f32
fn C.igGetFrameHeightWithSpacing() f32
fn C.igPushIDStr(str_id byteptr)
fn C.igPushIDRange(str_id_begin byteptr, str_id_end byteptr)
fn C.igPushIDPtr(ptr_id voidptr)
fn C.igPushIDInt(int_id int)
fn C.igPopID()
fn C.igGetIDStr(str_id byteptr) u32
fn C.igGetIDRange(str_id_begin byteptr, str_id_end byteptr) u32
fn C.igGetIDPtr(ptr_id voidptr) u32
fn C.igTextUnformatted(text byteptr, text_end byteptr)
fn C.igText(fmt byteptr)
fn C.igTextV(fmt byteptr, args voidptr /* ...voidptr */)
fn C.igTextColored(col C.ImVec4, fmt byteptr)
fn C.igTextColoredV(col C.ImVec4, fmt byteptr, args voidptr /* ...voidptr */)
fn C.igTextDisabled(fmt byteptr)
fn C.igTextDisabledV(fmt byteptr, args voidptr /* ...voidptr */)
fn C.igTextWrapped(fmt byteptr)
fn C.igTextWrappedV(fmt byteptr, args voidptr /* ...voidptr */)
fn C.igLabelText(label byteptr, fmt byteptr)
fn C.igLabelTextV(label byteptr, fmt byteptr, args voidptr /* ...voidptr */)
fn C.igBulletText(fmt byteptr)
fn C.igBulletTextV(fmt byteptr, args voidptr /* ...voidptr */)
fn C.igButton(label byteptr, size C.ImVec2) bool
fn C.igSmallButton(label byteptr) bool
fn C.igInvisibleButton(str_id byteptr, size C.ImVec2) bool
fn C.igArrowButton(str_id byteptr, dir int) bool
fn C.igImage(user_texture_id voidptr, size C.ImVec2, uv0 C.ImVec2, uv1 C.ImVec2, tint_col C.ImVec4, border_col C.ImVec4)
fn C.igImageButton(user_texture_id voidptr, size C.ImVec2, uv0 C.ImVec2, uv1 C.ImVec2, frame_padding int, bg_col C.ImVec4, tint_col C.ImVec4) bool
fn C.igCheckbox(label byteptr, v &bool) bool
fn C.igCheckboxFlags(label byteptr, flags &u32, flags_value u32) bool
fn C.igRadioButtonBool(label byteptr, active bool) bool
fn C.igRadioButtonIntPtr(label byteptr, v &int, v_button int) bool
fn C.igProgressBar(fraction f32, size_arg C.ImVec2, overlay byteptr)
fn C.igBullet()
fn C.igBeginCombo(label byteptr, preview_value byteptr, flags int) bool
fn C.igEndCombo()
fn C.igCombo(label byteptr, current_item &int, items []byteptr, items_count int, popup_max_height_in_items int) bool
fn C.igComboStr(label byteptr, current_item &int, items_separated_by_zeros byteptr, popup_max_height_in_items int) bool
fn C.igComboFnPtr(label byteptr, current_item &int, items_getter fn(voidptr, int, &voidptr /* const char** */) bool, data voidptr, items_count int, popup_max_height_in_items int) bool
fn C.igDragFloat(label byteptr, v &f32, v_speed f32, v_min f32, v_max f32, format byteptr, power f32) bool
fn C.igDragFloat2(label byteptr, v &f32, v_speed f32, v_min f32, v_max f32, format byteptr, power f32) bool
fn C.igDragFloat3(label byteptr, v &f32, v_speed f32, v_min f32, v_max f32, format byteptr, power f32) bool
fn C.igDragFloat4(label byteptr, v &f32, v_speed f32, v_min f32, v_max f32, format byteptr, power f32) bool
fn C.igDragFloatRange2(label byteptr, v_current_min &f32, v_current_max &f32, v_speed f32, v_min f32, v_max f32, format byteptr, format_max byteptr, power f32) bool
fn C.igDragInt(label byteptr, v &int, v_speed f32, v_min int, v_max int, format byteptr) bool
fn C.igDragInt2(label byteptr, v &int, v_speed f32, v_min int, v_max int, format byteptr) bool
fn C.igDragInt3(label byteptr, v &int, v_speed f32, v_min int, v_max int, format byteptr) bool
fn C.igDragInt4(label byteptr, v &int, v_speed f32, v_min int, v_max int, format byteptr) bool
fn C.igDragIntRange2(label byteptr, v_current_min &int, v_current_max &int, v_speed f32, v_min int, v_max int, format byteptr, format_max byteptr) bool
fn C.igDragScalar(label byteptr, data_type int, p_data voidptr, v_speed f32, p_min voidptr, p_max voidptr, format byteptr, power f32) bool
fn C.igDragScalarN(label byteptr, data_type int, p_data voidptr, components int, v_speed f32, p_min voidptr, p_max voidptr, format byteptr, power f32) bool
fn C.igSliderFloat(label byteptr, v &f32, v_min f32, v_max f32, format byteptr, power f32) bool
fn C.igSliderFloat2(label byteptr, v &f32, v_min f32, v_max f32, format byteptr, power f32) bool
fn C.igSliderFloat3(label byteptr, v &f32, v_min f32, v_max f32, format byteptr, power f32) bool
fn C.igSliderFloat4(label byteptr, v &f32, v_min f32, v_max f32, format byteptr, power f32) bool
fn C.igSliderAngle(label byteptr, v_rad &f32, v_degrees_min f32, v_degrees_max f32, format byteptr) bool
fn C.igSliderInt(label byteptr, v &int, v_min int, v_max int, format byteptr) bool
fn C.igSliderInt2(label byteptr, v &int, v_min int, v_max int, format byteptr) bool
fn C.igSliderInt3(label byteptr, v &int, v_min int, v_max int, format byteptr) bool
fn C.igSliderInt4(label byteptr, v &int, v_min int, v_max int, format byteptr) bool
fn C.igSliderScalar(label byteptr, data_type int, p_data voidptr, p_min voidptr, p_max voidptr, format byteptr, power f32) bool
fn C.igSliderScalarN(label byteptr, data_type int, p_data voidptr, components int, p_min voidptr, p_max voidptr, format byteptr, power f32) bool
fn C.igVSliderFloat(label byteptr, size C.ImVec2, v &f32, v_min f32, v_max f32, format byteptr, power f32) bool
fn C.igVSliderInt(label byteptr, size C.ImVec2, v &int, v_min int, v_max int, format byteptr) bool
fn C.igVSliderScalar(label byteptr, size C.ImVec2, data_type int, p_data voidptr, p_min voidptr, p_max voidptr, format byteptr, power f32) bool
fn C.igInputText(label byteptr, buf byteptr, buf_size u32, flags int, callback fn(&C.ImGuiTextEditCallbackData) int, user_data voidptr) bool
fn C.igInputTextMultiline(label byteptr, buf byteptr, buf_size u32, size C.ImVec2, flags int, callback fn(&C.ImGuiTextEditCallbackData) int, user_data voidptr) bool
fn C.igInputTextWithHint(label byteptr, hint byteptr, buf byteptr, buf_size u32, flags int, callback fn(&C.ImGuiTextEditCallbackData) int, user_data voidptr) bool
fn C.igInputFloat(label byteptr, v &f32, step f32, step_fast f32, format byteptr, flags int) bool
fn C.igInputFloat2(label byteptr, v &f32, format byteptr, flags int) bool
fn C.igInputFloat3(label byteptr, v &f32, format byteptr, flags int) bool
fn C.igInputFloat4(label byteptr, v &f32, format byteptr, flags int) bool
fn C.igInputInt(label byteptr, v &int, step int, step_fast int, flags int) bool
fn C.igInputInt2(label byteptr, v &int, flags int) bool
fn C.igInputInt3(label byteptr, v &int, flags int) bool
fn C.igInputInt4(label byteptr, v &int, flags int) bool
fn C.igInputDouble(label byteptr, v &f64, step f64, step_fast f64, format byteptr, flags int) bool
fn C.igInputScalar(label byteptr, data_type int, p_data voidptr, p_step voidptr, p_step_fast voidptr, format byteptr, flags int) bool
fn C.igInputScalarN(label byteptr, data_type int, p_data voidptr, components int, p_step voidptr, p_step_fast voidptr, format byteptr, flags int) bool
fn C.igColorEdit3(label byteptr, col &f32, flags int) bool
fn C.igColorEdit4(label byteptr, col &f32, flags int) bool
fn C.igColorPicker3(label byteptr, col &f32, flags int) bool
fn C.igColorPicker4(label byteptr, col &f32, flags int, ref_col &f32) bool
fn C.igColorButton(desc_id byteptr, col C.ImVec4, flags int, size C.ImVec2) bool
fn C.igSetColorEditOptions(flags int)
fn C.igTreeNodeStr(label byteptr) bool
fn C.igTreeNodeStrStr(str_id byteptr, fmt byteptr) bool
fn C.igTreeNodePtr(ptr_id voidptr, fmt byteptr) bool
fn C.igTreeNodeVStr(str_id byteptr, fmt byteptr, args voidptr /* ...voidptr */) bool
fn C.igTreeNodeVPtr(ptr_id voidptr, fmt byteptr, args voidptr /* ...voidptr */) bool
fn C.igTreeNodeExStr(label byteptr, flags int) bool
fn C.igTreeNodeExStrStr(str_id byteptr, flags int, fmt byteptr) bool
fn C.igTreeNodeExPtr(ptr_id voidptr, flags int, fmt byteptr) bool
fn C.igTreeNodeExVStr(str_id byteptr, flags int, fmt byteptr, args voidptr /* ...voidptr */) bool
fn C.igTreeNodeExVPtr(ptr_id voidptr, flags int, fmt byteptr, args voidptr /* ...voidptr */) bool
fn C.igTreePushStr(str_id byteptr)
fn C.igTreePushPtr(ptr_id voidptr)
fn C.igTreePop()
fn C.igGetTreeNodeToLabelSpacing() f32
fn C.igCollapsingHeader(label byteptr, flags int) bool
fn C.igCollapsingHeaderBoolPtr(label byteptr, p_open &bool, flags int) bool
fn C.igSetNextItemOpen(is_open bool, cond int)
fn C.igSelectable(label byteptr, selected bool, flags int, size C.ImVec2) bool
fn C.igSelectableBoolPtr(label byteptr, p_selected &bool, flags int, size C.ImVec2) bool
fn C.igListBoxStr_arr(label byteptr, current_item &int, items []byteptr, items_count int, height_in_items int) bool
fn C.igListBoxFnPtr(label byteptr, current_item &int, items_getter fn(voidptr, int, &voidptr /* const char** */) bool, data voidptr, items_count int, height_in_items int) bool
fn C.igListBoxHeaderVec2(label byteptr, size C.ImVec2) bool
fn C.igListBoxHeaderInt(label byteptr, items_count int, height_in_items int) bool
fn C.igListBoxFooter()
fn C.igPlotLines(label byteptr, values &f32, values_count int, values_offset int, overlay_text byteptr, scale_min f32, scale_max f32, graph_size C.ImVec2, stride int)
fn C.igPlotLinesFnPtr(label byteptr, values_getter fn(voidptr, int) f32, data voidptr, values_count int, values_offset int, overlay_text byteptr, scale_min f32, scale_max f32, graph_size C.ImVec2)
fn C.igPlotHistogramFloatPtr(label byteptr, values &f32, values_count int, values_offset int, overlay_text byteptr, scale_min f32, scale_max f32, graph_size C.ImVec2, stride int)
fn C.igPlotHistogramFnPtr(label byteptr, values_getter fn(voidptr, int) f32, data voidptr, values_count int, values_offset int, overlay_text byteptr, scale_min f32, scale_max f32, graph_size C.ImVec2)
fn C.igValueBool(prefix byteptr, b bool)
fn C.igValueInt(prefix byteptr, v int)
fn C.igValueUint(prefix byteptr, v u32)
fn C.igValueFloat(prefix byteptr, v f32, float_format byteptr)
fn C.igBeginMenuBar() bool
fn C.igEndMenuBar()
fn C.igBeginMainMenuBar() bool
fn C.igEndMainMenuBar()
fn C.igBeginMenu(label byteptr, enabled bool) bool
fn C.igEndMenu()
fn C.igMenuItemBool(label byteptr, shortcut byteptr, selected bool, enabled bool) bool
fn C.igMenuItemBoolPtr(label byteptr, shortcut byteptr, p_selected &bool, enabled bool) bool
fn C.igBeginTooltip()
fn C.igEndTooltip()
fn C.igSetTooltip(fmt byteptr)
fn C.igSetTooltipV(fmt byteptr, args voidptr /* ...voidptr */)
fn C.igOpenPopup(str_id byteptr)
fn C.igBeginPopup(str_id byteptr, flags int) bool
fn C.igBeginPopupContextItem(str_id byteptr, mouse_button int) bool
fn C.igBeginPopupContextWindow(str_id byteptr, mouse_button int, also_over_items bool) bool
fn C.igBeginPopupContextVoid(str_id byteptr, mouse_button int) bool
fn C.igBeginPopupModal(name byteptr, p_open &bool, flags int) bool
fn C.igEndPopup()
fn C.igOpenPopupOnItemClick(str_id byteptr, mouse_button int) bool
fn C.igIsPopupOpen(str_id byteptr) bool
fn C.igCloseCurrentPopup()
fn C.igColumns(count int, id byteptr, border bool)
fn C.igNextColumn()
fn C.igGetColumnIndex() int
fn C.igGetColumnWidth(column_index int) f32
fn C.igSetColumnWidth(column_index int, width f32)
fn C.igGetColumnOffset(column_index int) f32
fn C.igSetColumnOffset(column_index int, offset_x f32)
fn C.igGetColumnsCount() int
fn C.igBeginTabBar(str_id byteptr, flags int) bool
fn C.igEndTabBar()
fn C.igBeginTabItem(label byteptr, p_open &bool, flags int) bool
fn C.igEndTabItem()
fn C.igSetTabItemClosed(tab_or_docked_window_label byteptr)
fn C.igDockSpace(id u32, size C.ImVec2, flags int, window_class &C.ImGuiWindowClass)
fn C.igDockSpaceOverViewport(viewport &C.ImGuiViewport, flags int, window_class &C.ImGuiWindowClass) u32
fn C.igSetNextWindowDockID(dock_id u32, cond int)
fn C.igSetNextWindowClass(window_class &C.ImGuiWindowClass)
fn C.igGetWindowDockID() u32
fn C.igIsWindowDocked() bool
fn C.igLogToTTY(auto_open_depth int)
fn C.igLogToFile(auto_open_depth int, filename byteptr)
fn C.igLogToClipboard(auto_open_depth int)
fn C.igLogFinish()
fn C.igLogButtons()
fn C.igBeginDragDropSource(flags int) bool
fn C.igSetDragDropPayload(typ byteptr, data voidptr, sz u32, cond int) bool
fn C.igEndDragDropSource()
fn C.igBeginDragDropTarget() bool
fn C.igAcceptDragDropPayload(typ byteptr, flags int) &C.ImGuiPayload
fn C.igEndDragDropTarget()
fn C.igGetDragDropPayload() &C.ImGuiPayload
fn C.igPushClipRect(clip_rect_min C.ImVec2, clip_rect_max C.ImVec2, intersect_with_current_clip_rect bool)
fn C.igPopClipRect()
fn C.igSetItemDefaultFocus()
fn C.igSetKeyboardFocusHere(offset int)
fn C.igIsItemHovered(flags int) bool
fn C.igIsItemActive() bool
fn C.igIsItemFocused() bool
fn C.igIsItemClicked(mouse_button int) bool
fn C.igIsItemVisible() bool
fn C.igIsItemEdited() bool
fn C.igIsItemActivated() bool
fn C.igIsItemDeactivated() bool
fn C.igIsItemDeactivatedAfterEdit() bool
fn C.igIsItemToggledOpen() bool
fn C.igIsAnyItemHovered() bool
fn C.igIsAnyItemActive() bool
fn C.igIsAnyItemFocused() bool
fn C.igGetItemRectMin() C.ImVec2
fn C.igGetItemRectMax() C.ImVec2
fn C.igGetItemRectSize() C.ImVec2
fn C.igSetItemAllowOverlap()
fn C.igIsRectVisible(size C.ImVec2) bool
fn C.igIsRectVisibleVec2(rect_min C.ImVec2, rect_max C.ImVec2) bool
fn C.igGetTime()
fn C.igGetFrameCount() int
fn C.igGetBackgroundDrawList() &C.ImDrawList
fn C.igGetForegroundDrawList() &C.ImDrawList
fn C.igGetBackgroundDrawListViewportPtr(viewport &C.ImGuiViewport) &C.ImDrawList
fn C.igGetForegroundDrawListViewportPtr(viewport &C.ImGuiViewport) &C.ImDrawList
fn C.igGetDrawListSharedData() &C.ImDrawListSharedData
fn C.igGetStyleColorName(idx int) byteptr
fn C.igSetStateStorage(storage &C.ImGuiStorage)
fn C.igGetStateStorage() &C.ImGuiStorage
fn C.igCalcTextSize(text byteptr, text_end byteptr, hide_text_after_double_hash bool, wrap_width f32) C.ImVec2
fn C.igCalcListClipping(items_count int, items_height f32, out_items_display_start &int, out_items_display_end &int)
fn C.igBeginChildFrame(id u32, size C.ImVec2, flags int) bool
fn C.igEndChildFrame()
fn C.igColorConvertU32ToFloat4(@in u32) C.ImVec4
fn C.igColorConvertFloat4ToU32(@in C.ImVec4) u32
fn C.igGetKeyIndex(imgui_key int) int
fn C.igIsKeyDown(user_key_index int) bool
fn C.igIsKeyPressed(user_key_index int, repeat bool) bool
fn C.igIsKeyReleased(user_key_index int) bool
fn C.igGetKeyPressedAmount(key_index int, repeat_delay f32, rate f32) int
fn C.igIsMouseDown(button int) bool
fn C.igIsAnyMouseDown() bool
fn C.igIsMouseClicked(button int, repeat bool) bool
fn C.igIsMouseDoubleClicked(button int) bool
fn C.igIsMouseReleased(button int) bool
fn C.igIsMouseDragging(button int, lock_threshold f32) bool
fn C.igIsMouseHoveringRect(r_min C.ImVec2, r_max C.ImVec2, clip bool) bool
fn C.igIsMousePosValid(mouse_pos &C.ImVec2) bool
fn C.igGetMousePos() C.ImVec2
fn C.igGetMousePosOnOpeningCurrentPopup() C.ImVec2
fn C.igGetMouseDragDelta(button int, lock_threshold f32) C.ImVec2
fn C.igResetMouseDragDelta(button int)
fn C.igGetMouseCursor() int
fn C.igSetMouseCursor(typ int)
fn C.igCaptureKeyboardFromApp(want_capture_keyboard_value bool)
fn C.igCaptureMouseFromApp(want_capture_mouse_value bool)
fn C.igGetClipboardText() byteptr
fn C.igSetClipboardText(text byteptr)
fn C.igLoadIniSettingsFromDisk(ini_filename byteptr)
fn C.igLoadIniSettingsFromMemory(ini_data byteptr, ini_size u32)
fn C.igSaveIniSettingsToDisk(ini_filename byteptr)
fn C.igSaveIniSettingsToMemory(out_ini_size &u32) byteptr
fn C.igSetAllocatorFunctions(alloc_func fn(voidptr, voidptr), free_func fn(voidptr, voidptr), user_data voidptr)
fn C.igMemAlloc(size u32) voidptr
fn C.igMemFree(ptr voidptr)
fn C.igGetPlatformIO() &C.ImGuiPlatformIO
fn C.igGetMainViewport() &C.ImGuiViewport
fn C.igUpdatePlatformWindows()
fn C.igRenderPlatformWindowsDefault(platform_arg voidptr, renderer_arg voidptr)
fn C.igDestroyPlatformWindows()
fn C.igFindViewportByID(id u32) &C.ImGuiViewport
fn C.igFindViewportByPlatformHandle(platform_handle voidptr) &C.ImGuiViewport
fn C.ImGuiStyle_ImGuiStyle() &C.ImGuiStyle
fn C.ImGuiStyle_destroy(self &C.ImGuiStyle)
fn C.ImGuiStyle_ScaleAllSizes(self &C.ImGuiStyle, scale_factor f32)
fn C.ImGuiIO_AddInputCharacter(self &C.ImGuiIO, c u32)
fn C.ImGuiIO_AddInputCharactersUTF8(self &C.ImGuiIO, str byteptr)
fn C.ImGuiIO_ClearInputCharacters(self &C.ImGuiIO)
fn C.ImGuiIO_ImGuiIO() &C.ImGuiIO
fn C.ImGuiIO_destroy(self &C.ImGuiIO)
fn C.ImGuiInputTextCallbackData_ImGuiInputTextCallbackData() &C.ImGuiTextEditCallbackData
fn C.ImGuiInputTextCallbackData_destroy(self &C.ImGuiTextEditCallbackData)
fn C.ImGuiInputTextCallbackData_DeleteChars(self &C.ImGuiTextEditCallbackData, pos int, bytes_count int)
fn C.ImGuiInputTextCallbackData_InsertChars(self &C.ImGuiTextEditCallbackData, pos int, text byteptr, text_end byteptr)
fn C.ImGuiInputTextCallbackData_HasSelection(self &C.ImGuiTextEditCallbackData) bool
fn C.ImGuiWindowClass_ImGuiWindowClass() &C.ImGuiWindowClass
fn C.ImGuiWindowClass_destroy(self &C.ImGuiWindowClass)
fn C.ImGuiPayload_ImGuiPayload() &C.ImGuiPayload
fn C.ImGuiPayload_destroy(self &C.ImGuiPayload)
fn C.ImGuiPayload_Clear(self &C.ImGuiPayload)
fn C.ImGuiPayload_IsDataType(self &C.ImGuiPayload, typ byteptr) bool
fn C.ImGuiPayload_IsPreview(self &C.ImGuiPayload) bool
fn C.ImGuiPayload_IsDelivery(self &C.ImGuiPayload) bool
fn C.ImGuiOnceUponAFrame_ImGuiOnceUponAFrame() &C.ImGuiOnceUponAFrame
fn C.ImGuiOnceUponAFrame_destroy(self &C.ImGuiOnceUponAFrame)
fn C.ImGuiTextFilter_ImGuiTextFilter(default_filter byteptr) &C.ImGuiTextFilter
fn C.ImGuiTextFilter_destroy(self &C.ImGuiTextFilter)
fn C.ImGuiTextFilter_Draw(self &C.ImGuiTextFilter, label byteptr, width f32) bool
fn C.ImGuiTextFilter_PassFilter(self &C.ImGuiTextFilter, text byteptr, text_end byteptr) bool
fn C.ImGuiTextFilter_Build(self &C.ImGuiTextFilter)
fn C.ImGuiTextFilter_Clear(self &C.ImGuiTextFilter)
fn C.ImGuiTextFilter_IsActive(self &C.ImGuiTextFilter) bool
// fn C.ImGuiTextRange_ImGuiTextRange() &C.ImGuiTextRange
// fn C.ImGuiTextRange_destroy(self &C.ImGuiTextRange)
// fn C.ImGuiTextRange_ImGuiTextRangeStr(_b byteptr, _e byteptr) &C.ImGuiTextRange
// fn C.ImGuiTextRange_empty(self &C.ImGuiTextRange) bool
// fn C.ImGuiTextRange_split(self &C.ImGuiTextRange, separator byte, out &ImVector<C.ImGuiTextRange>)
fn C.ImGuiTextBuffer_ImGuiTextBuffer() &C.ImGuiTextBuffer
fn C.ImGuiTextBuffer_destroy(self &C.ImGuiTextBuffer)
fn C.ImGuiTextBuffer_begin(self &C.ImGuiTextBuffer) byteptr
fn C.ImGuiTextBuffer_end(self &C.ImGuiTextBuffer) byteptr
fn C.ImGuiTextBuffer_size(self &C.ImGuiTextBuffer) int
fn C.ImGuiTextBuffer_empty(self &C.ImGuiTextBuffer) bool
fn C.ImGuiTextBuffer_clear(self &C.ImGuiTextBuffer)
fn C.ImGuiTextBuffer_reserve(self &C.ImGuiTextBuffer, capacity int)
fn C.ImGuiTextBuffer_c_str(self &C.ImGuiTextBuffer) byteptr
fn C.ImGuiTextBuffer_append(self &C.ImGuiTextBuffer, str byteptr, str_end byteptr)
fn C.ImGuiTextBuffer_appendfv(self &C.ImGuiTextBuffer, fmt byteptr, args voidptr /* ...voidptr */)
// fn C.ImGuiStoragePair_ImGuiStoragePairInt(_key u32, _val_i int) &C.ImGuiStoragePair
// fn C.ImGuiStoragePair_destroy(self &ImGuiStoragePair)
// fn C.ImGuiStoragePair_ImGuiStoragePairFloat(_key u32, _val_f f32) &ImGuiStoragePair
// fn C.ImGuiStoragePair_ImGuiStoragePairPtr(_key u32, _val_p voidptr) &ImGuiStoragePair
fn C.ImGuiStorage_Clear(self &C.ImGuiStorage)
fn C.ImGuiStorage_GetInt(self &C.ImGuiStorage, key u32, default_val int) int
fn C.ImGuiStorage_SetInt(self &C.ImGuiStorage, key u32, val int)
fn C.ImGuiStorage_GetBool(self &C.ImGuiStorage, key u32, default_val bool) bool
fn C.ImGuiStorage_SetBool(self &C.ImGuiStorage, key u32, val bool)
fn C.ImGuiStorage_GetFloat(self &C.ImGuiStorage, key u32, default_val f32) f32
fn C.ImGuiStorage_SetFloat(self &C.ImGuiStorage, key u32, val f32)
fn C.ImGuiStorage_GetVoidPtr(self &C.ImGuiStorage, key u32) voidptr
fn C.ImGuiStorage_SetVoidPtr(self &C.ImGuiStorage, key u32, val voidptr)
fn C.ImGuiStorage_GetIntRef(self &C.ImGuiStorage, key u32, default_val int) &int
fn C.ImGuiStorage_GetBoolRef(self &C.ImGuiStorage, key u32, default_val bool) &bool
fn C.ImGuiStorage_GetFloatRef(self &C.ImGuiStorage, key u32, default_val f32) &f32
fn C.ImGuiStorage_GetVoidPtrRef(self &C.ImGuiStorage, key u32, default_val voidptr) &voidptr /* void** */
fn C.ImGuiStorage_SetAllInt(self &C.ImGuiStorage, val int)
fn C.ImGuiStorage_BuildSortByKey(self &C.ImGuiStorage)
fn C.ImGuiListClipper_ImGuiListClipper(items_count int, items_height f32) &C.ImGuiListClipper
fn C.ImGuiListClipper_destroy(self &C.ImGuiListClipper)
fn C.ImGuiListClipper_Step(self &C.ImGuiListClipper) bool
fn C.ImGuiListClipper_Begin(self &C.ImGuiListClipper, items_count int, items_height f32)
fn C.ImGuiListClipper_End(self &C.ImGuiListClipper)
fn C.ImColor_ImColor() &C.ImColor
fn C.ImColor_destroy(self &C.ImColor)
fn C.ImColor_ImColorInt(r int, g int, b int, a int) &C.ImColor
fn C.ImColor_ImColorU32(rgba u32) &C.ImColor
fn C.ImColor_ImColorFloat(r f32, g f32, b f32, a f32) &C.ImColor
fn C.ImColor_ImColorVec4(col C.ImVec4) &C.ImColor
fn C.ImColor_SetHSV(self &C.ImColor, h f32, s f32, v f32, a f32)
fn C.ImColor_HSV(self &C.ImColor, h f32, s f32, v f32, a f32) C.ImColor
fn C.ImDrawCmd_ImDrawCmd() &C.ImDrawCmd
fn C.ImDrawCmd_destroy(self &C.ImDrawCmd)
fn C.ImDrawListSplitter_ImDrawListSplitter() &C.ImDrawListSplitter
fn C.ImDrawListSplitter_destroy(self &C.ImDrawListSplitter)
fn C.ImDrawListSplitter_Clear(self &C.ImDrawListSplitter)
fn C.ImDrawListSplitter_ClearFreeMemory(self &C.ImDrawListSplitter)
fn C.ImDrawListSplitter_Split(self &C.ImDrawListSplitter, draw_list &C.ImDrawList, count int)
fn C.ImDrawListSplitter_Merge(self &C.ImDrawListSplitter, draw_list &C.ImDrawList)
fn C.ImDrawListSplitter_SetCurrentChannel(self &C.ImDrawListSplitter, draw_list &C.ImDrawList, channel_idx int)
fn C.ImDrawList_ImDrawList(shared_data &C.ImDrawListSharedData) &C.ImDrawList
fn C.ImDrawList_destroy(self &C.ImDrawList)
fn C.ImDrawList_PushClipRect(self &C.ImDrawList, clip_rect_min C.ImVec2, clip_rect_max C.ImVec2, intersect_with_current_clip_rect bool)
fn C.ImDrawList_PushClipRectFullScreen(self &C.ImDrawList)
fn C.ImDrawList_PopClipRect(self &C.ImDrawList)
fn C.ImDrawList_PushTextureID(self &C.ImDrawList, texture_id voidptr)
fn C.ImDrawList_PopTextureID(self &C.ImDrawList)
fn C.ImDrawList_GetClipRectMin(self &C.ImDrawList) C.ImVec2
fn C.ImDrawList_GetClipRectMax(self &C.ImDrawList) C.ImVec2
fn C.ImDrawList_AddLine(self &C.ImDrawList, p1 C.ImVec2, p2 C.ImVec2, col u32, thickness f32)
fn C.ImDrawList_AddRect(self &C.ImDrawList, p_min C.ImVec2, p_max C.ImVec2, col u32, rounding f32, rounding_corners int, thickness f32)
fn C.ImDrawList_AddRectFilled(self &C.ImDrawList, p_min C.ImVec2, p_max C.ImVec2, col u32, rounding f32, rounding_corners int)
fn C.ImDrawList_AddRectFilledMultiColor(self &C.ImDrawList, p_min C.ImVec2, p_max C.ImVec2, col_upr_left u32, col_upr_right u32, col_bot_right u32, col_bot_left u32)
fn C.ImDrawList_AddQuad(self &C.ImDrawList, p1 C.ImVec2, p2 C.ImVec2, p3 C.ImVec2, p4 C.ImVec2, col u32, thickness f32)
fn C.ImDrawList_AddQuadFilled(self &C.ImDrawList, p1 C.ImVec2, p2 C.ImVec2, p3 C.ImVec2, p4 C.ImVec2, col u32)
fn C.ImDrawList_AddTriangle(self &C.ImDrawList, p1 C.ImVec2, p2 C.ImVec2, p3 C.ImVec2, col u32, thickness f32)
fn C.ImDrawList_AddTriangleFilled(self &C.ImDrawList, p1 C.ImVec2, p2 C.ImVec2, p3 C.ImVec2, col u32)
fn C.ImDrawList_AddCircle(self &C.ImDrawList, center C.ImVec2, radius f32, col u32, num_segments int, thickness f32)
fn C.ImDrawList_AddCircleFilled(self &C.ImDrawList, center C.ImVec2, radius f32, col u32, num_segments int)
fn C.ImDrawList_AddText(self &C.ImDrawList, pos C.ImVec2, col u32, text_begin byteptr, text_end byteptr)
fn C.ImDrawList_AddTextFontPtr(self &C.ImDrawList, font &C.ImFont, font_size f32, pos C.ImVec2, col u32, text_begin byteptr, text_end byteptr, wrap_width f32, cpu_fine_clip_rect &C.ImVec4)
fn C.ImDrawList_AddPolyline(self &C.ImDrawList, points &C.ImVec2, num_points int, col u32, closed bool, thickness f32)
fn C.ImDrawList_AddConvexPolyFilled(self &C.ImDrawList, points &C.ImVec2, num_points int, col u32)
fn C.ImDrawList_AddBezierCurve(self &C.ImDrawList, pos0 C.ImVec2, cp0 C.ImVec2, cp1 C.ImVec2, pos1 C.ImVec2, col u32, thickness f32, num_segments int)
fn C.ImDrawList_AddImage(self &C.ImDrawList, user_texture_id voidptr, p_min C.ImVec2, p_max C.ImVec2, uv_min C.ImVec2, uv_max C.ImVec2, col u32)
fn C.ImDrawList_AddImageQuad(self &C.ImDrawList, user_texture_id voidptr, p1 C.ImVec2, p2 C.ImVec2, p3 C.ImVec2, p4 C.ImVec2, uv1 C.ImVec2, uv2 C.ImVec2, uv3 C.ImVec2, uv4 C.ImVec2, col u32)
fn C.ImDrawList_AddImageRounded(self &C.ImDrawList, user_texture_id voidptr, p_min C.ImVec2, p_max C.ImVec2, uv_min C.ImVec2, uv_max C.ImVec2, col u32, rounding f32, rounding_corners int)
fn C.ImDrawList_PathClear(self &C.ImDrawList)
fn C.ImDrawList_PathLineTo(self &C.ImDrawList, pos C.ImVec2)
fn C.ImDrawList_PathLineToMergeDuplicate(self &C.ImDrawList, pos C.ImVec2)
fn C.ImDrawList_PathFillConvex(self &C.ImDrawList, col u32)
fn C.ImDrawList_PathStroke(self &C.ImDrawList, col u32, closed bool, thickness f32)
fn C.ImDrawList_PathArcTo(self &C.ImDrawList, center C.ImVec2, radius f32, a_min f32, a_max f32, num_segments int)
fn C.ImDrawList_PathArcToFast(self &C.ImDrawList, center C.ImVec2, radius f32, a_min_of_12 int, a_max_of_12 int)
fn C.ImDrawList_PathBezierCurveTo(self &C.ImDrawList, p1 C.ImVec2, p2 C.ImVec2, p3 C.ImVec2, num_segments int)
fn C.ImDrawList_PathRect(self &C.ImDrawList, rect_min C.ImVec2, rect_max C.ImVec2, rounding f32, rounding_corners int)
fn C.ImDrawList_AddCallback(self &C.ImDrawList, callback fn(&C.ImDrawList, &C.ImDrawCmd), callback_data voidptr)
fn C.ImDrawList_AddDrawCmd(self &C.ImDrawList)
fn C.ImDrawList_CloneOutput(self &C.ImDrawList) &C.ImDrawList
fn C.ImDrawList_ChannelsSplit(self &C.ImDrawList, count int)
fn C.ImDrawList_ChannelsMerge(self &C.ImDrawList)
fn C.ImDrawList_ChannelsSetCurrent(self &C.ImDrawList, n int)
fn C.ImDrawList_Clear(self &C.ImDrawList)
fn C.ImDrawList_ClearFreeMemory(self &C.ImDrawList)
fn C.ImDrawList_PrimReserve(self &C.ImDrawList, idx_count int, vtx_count int)
fn C.ImDrawList_PrimRect(self &C.ImDrawList, a C.ImVec2, b C.ImVec2, col u32)
fn C.ImDrawList_PrimRectUV(self &C.ImDrawList, a C.ImVec2, b C.ImVec2, uv_a C.ImVec2, uv_b C.ImVec2, col u32)
fn C.ImDrawList_PrimQuadUV(self &C.ImDrawList, a C.ImVec2, b C.ImVec2, c C.ImVec2, d C.ImVec2, uv_a C.ImVec2, uv_b C.ImVec2, uv_c C.ImVec2, uv_d C.ImVec2, col u32)
fn C.ImDrawList_PrimWriteVtx(self &C.ImDrawList, pos C.ImVec2, uv C.ImVec2, col u32)
fn C.ImDrawList_PrimWriteIdx(self &C.ImDrawList, idx u16)
fn C.ImDrawList_PrimVtx(self &C.ImDrawList, pos C.ImVec2, uv C.ImVec2, col u32)
fn C.ImDrawList_UpdateClipRect(self &C.ImDrawList)
fn C.ImDrawList_UpdateTextureID(self &C.ImDrawList)
fn C.ImDrawData_ImDrawData() &C.ImDrawData
fn C.ImDrawData_destroy(self &C.ImDrawData)
fn C.ImDrawData_Clear(self &C.ImDrawData)
fn C.ImDrawData_DeIndexAllBuffers(self &C.ImDrawData)
fn C.ImDrawData_ScaleClipRects(self &C.ImDrawData, fb_scale C.ImVec2)
fn C.ImFontConfig_ImFontConfig() &C.ImFontConfig
fn C.ImFontConfig_destroy(self &C.ImFontConfig)
fn C.ImFontGlyphRangesBuilder_ImFontGlyphRangesBuilder() &C.ImFontGlyphRangesBuilder
fn C.ImFontGlyphRangesBuilder_destroy(self &C.ImFontGlyphRangesBuilder)
fn C.ImFontGlyphRangesBuilder_Clear(self &C.ImFontGlyphRangesBuilder)
fn C.ImFontGlyphRangesBuilder_GetBit(self &C.ImFontGlyphRangesBuilder, n int) bool
fn C.ImFontGlyphRangesBuilder_SetBit(self &C.ImFontGlyphRangesBuilder, n int)
fn C.ImFontGlyphRangesBuilder_AddChar(self &C.ImFontGlyphRangesBuilder, c u16)
fn C.ImFontGlyphRangesBuilder_AddText(self &C.ImFontGlyphRangesBuilder, text byteptr, text_end byteptr)
fn C.ImFontGlyphRangesBuilder_AddRanges(self &C.ImFontGlyphRangesBuilder, ranges &u16)
// fn C.ImFontGlyphRangesBuilder_BuildRanges(self &C.ImFontGlyphRangesBuilder, out_ranges &ImVector<ImWchar>)
fn C.ImFontAtlasCustomRect_ImFontAtlasCustomRect() &C.ImFontAtlasCustomRect
fn C.ImFontAtlasCustomRect_destroy(self &C.ImFontAtlasCustomRect)
fn C.ImFontAtlasCustomRect_IsPacked(self &C.ImFontAtlasCustomRect) bool
fn C.ImFontAtlas_ImFontAtlas() &C.ImFontAtlas
fn C.ImFontAtlas_destroy(self &C.ImFontAtlas)
fn C.ImFontAtlas_AddFont(self &C.ImFontAtlas, font_cfg &C.ImFontConfig) &C.ImFont
fn C.ImFontAtlas_AddFontDefault(self &C.ImFontAtlas, font_cfg &C.ImFontConfig) &C.ImFont
fn C.ImFontAtlas_AddFontFromFileTTF(self &C.ImFontAtlas, filename byteptr, size_pixels f32, font_cfg &C.ImFontConfig, glyph_ranges &u16) &C.ImFont
fn C.ImFontAtlas_AddFontFromMemoryTTF(self &C.ImFontAtlas, font_data voidptr, font_size int, size_pixels f32, font_cfg &C.ImFontConfig, glyph_ranges &u16) &C.ImFont
fn C.ImFontAtlas_AddFontFromMemoryCompressedTTF(self &C.ImFontAtlas, compressed_font_data voidptr, compressed_font_size int, size_pixels f32, font_cfg &C.ImFontConfig, glyph_ranges &u16) &C.ImFont
fn C.ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(self &C.ImFontAtlas, compressed_font_data_base85 byteptr, size_pixels f32, font_cfg &C.ImFontConfig, glyph_ranges &u16) &C.ImFont
fn C.ImFontAtlas_ClearInputData(self &C.ImFontAtlas)
fn C.ImFontAtlas_ClearTexData(self &C.ImFontAtlas)
fn C.ImFontAtlas_ClearFonts(self &C.ImFontAtlas)
fn C.ImFontAtlas_Clear(self &C.ImFontAtlas)
fn C.ImFontAtlas_Build(self &C.ImFontAtlas) bool
fn C.ImFontAtlas_GetTexDataAsAlpha8(self &C.ImFontAtlas, out_pixels &voidptr /* unsigned char** */, out_width &int, out_height &int, out_bytes_per_pixel &int)
fn C.ImFontAtlas_GetTexDataAsRGBA32(self &C.ImFontAtlas, out_pixels &voidptr /* unsigned char** */, out_width &int, out_height &int, out_bytes_per_pixel &int)
fn C.ImFontAtlas_IsBuilt(self &C.ImFontAtlas) bool
fn C.ImFontAtlas_SetTexID(self &C.ImFontAtlas, id voidptr)
fn C.ImFontAtlas_GetGlyphRangesDefault(self &C.ImFontAtlas) &u16
fn C.ImFontAtlas_GetGlyphRangesKorean(self &C.ImFontAtlas) &u16
fn C.ImFontAtlas_GetGlyphRangesJapanese(self &C.ImFontAtlas) &u16
fn C.ImFontAtlas_GetGlyphRangesChineseFull(self &C.ImFontAtlas) &u16
fn C.ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(self &C.ImFontAtlas) &u16
fn C.ImFontAtlas_GetGlyphRangesCyrillic(self &C.ImFontAtlas) &u16
fn C.ImFontAtlas_GetGlyphRangesThai(self &C.ImFontAtlas) &u16
fn C.ImFontAtlas_GetGlyphRangesVietnamese(self &C.ImFontAtlas) &u16
fn C.ImFontAtlas_AddCustomRectRegular(self &C.ImFontAtlas, id u32, width int, height int) int
fn C.ImFontAtlas_AddCustomRectFontGlyph(self &C.ImFontAtlas, font &C.ImFont, id u16, width int, height int, advance_x f32, offset C.ImVec2) int
fn C.ImFontAtlas_GetCustomRectByIndex(self &C.ImFontAtlas, index int) &C.ImFontAtlasCustomRect
fn C.ImFontAtlas_CalcCustomRectUV(self &C.ImFontAtlas, rect &C.ImFontAtlasCustomRect, out_uv_min &C.ImVec2, out_uv_max &C.ImVec2)
fn C.ImFontAtlas_GetMouseCursorTexData(self &C.ImFontAtlas, cursor int, out_offset &C.ImVec2, out_size &C.ImVec2, out_uv_border [2]C.ImVec2, out_uv_fill [2]C.ImVec2) bool
fn C.ImFont_ImFont() &C.ImFont
fn C.ImFont_destroy(self &C.ImFont)
fn C.ImFont_FindGlyph(self &C.ImFont, c u16) &C.ImFontGlyph
fn C.ImFont_FindGlyphNoFallback(self &C.ImFont, c u16) &C.ImFontGlyph
fn C.ImFont_GetCharAdvance(self &C.ImFont, c u16) f32
fn C.ImFont_IsLoaded(self &C.ImFont) bool
fn C.ImFont_GetDebugName(self &C.ImFont) byteptr
fn C.ImFont_CalcTextSizeA(self &C.ImFont, size f32, max_width f32, wrap_width f32, text_begin byteptr, text_end byteptr, remaining &voidptr /* const char** */) C.ImVec2
fn C.ImFont_CalcWordWrapPositionA(self &C.ImFont, scale f32, text byteptr, text_end byteptr, wrap_width f32) byteptr
fn C.ImFont_RenderChar(self &C.ImFont, draw_list &C.ImDrawList, size f32, pos C.ImVec2, col u32, c u16)
fn C.ImFont_RenderText(self &C.ImFont, draw_list &C.ImDrawList, size f32, pos C.ImVec2, col u32, clip_rect C.ImVec4, text_begin byteptr, text_end byteptr, wrap_width f32, cpu_fine_clip bool)
fn C.ImFont_BuildLookupTable(self &C.ImFont)
fn C.ImFont_ClearOutputData(self &C.ImFont)
fn C.ImFont_GrowIndex(self &C.ImFont, new_size int)
fn C.ImFont_AddGlyph(self &C.ImFont, c u16, x0 f32, y0 f32, x1 f32, y1 f32, u0 f32, v0 f32, u1 f32, v1 f32, advance_x f32)
fn C.ImFont_AddRemapChar(self &C.ImFont, dst u16, src u16, overwrite_dst bool)
fn C.ImFont_SetFallbackChar(self &C.ImFont, c u16)
fn C.ImGuiPlatformMonitor_ImGuiPlatformMonitor() &C.ImGuiPlatformMonitor
fn C.ImGuiPlatformMonitor_destroy(self &C.ImGuiPlatformMonitor)
fn C.ImGuiPlatformIO_ImGuiPlatformIO() &C.ImGuiPlatformIO
fn C.ImGuiPlatformIO_destroy(self &C.ImGuiPlatformIO)
fn C.ImGuiViewport_ImGuiViewport() &C.ImGuiViewport
fn C.ImGuiViewport_destroy(self &C.ImGuiViewport)
fn C.igGetWindowPos_nonUDT(pOut &C.ImVec2)
fn C.igGetWindowPos_nonUDT2() C.ImVec2_Simple
fn C.igGetWindowSize_nonUDT(pOut &C.ImVec2)
fn C.igGetWindowSize_nonUDT2() C.ImVec2_Simple
fn C.igGetContentRegionMax_nonUDT(pOut &C.ImVec2)
fn C.igGetContentRegionMax_nonUDT2() C.ImVec2_Simple
fn C.igGetContentRegionAvail_nonUDT(pOut &C.ImVec2)
fn C.igGetContentRegionAvail_nonUDT2() C.ImVec2_Simple
fn C.igGetWindowContentRegionMin_nonUDT(pOut &C.ImVec2)
fn C.igGetWindowContentRegionMin_nonUDT2() C.ImVec2_Simple
fn C.igGetWindowContentRegionMax_nonUDT(pOut &C.ImVec2)
fn C.igGetWindowContentRegionMax_nonUDT2() C.ImVec2_Simple
fn C.igGetFontTexUvWhitePixel_nonUDT(pOut &C.ImVec2)
fn C.igGetFontTexUvWhitePixel_nonUDT2() C.ImVec2_Simple
fn C.igGetCursorPos_nonUDT(pOut &C.ImVec2)
fn C.igGetCursorPos_nonUDT2() C.ImVec2_Simple
fn C.igGetCursorStartPos_nonUDT(pOut &C.ImVec2)
fn C.igGetCursorStartPos_nonUDT2() C.ImVec2_Simple
fn C.igGetCursorScreenPos_nonUDT(pOut &C.ImVec2)
fn C.igGetCursorScreenPos_nonUDT2() C.ImVec2_Simple
fn C.igGetItemRectMin_nonUDT(pOut &C.ImVec2)
fn C.igGetItemRectMin_nonUDT2() C.ImVec2_Simple
fn C.igGetItemRectMax_nonUDT(pOut &C.ImVec2)
fn C.igGetItemRectMax_nonUDT2() C.ImVec2_Simple
fn C.igGetItemRectSize_nonUDT(pOut &C.ImVec2)
fn C.igGetItemRectSize_nonUDT2() C.ImVec2_Simple
fn C.igCalcTextSize_nonUDT(pOut &C.ImVec2, text byteptr, text_end byteptr, hide_text_after_double_hash bool, wrap_width f32)
fn C.igCalcTextSize_nonUDT2(text byteptr, text_end byteptr, hide_text_after_double_hash bool, wrap_width f32) C.ImVec2_Simple
fn C.igColorConvertU32ToFloat4_nonUDT(pOut &C.ImVec4, @in u32)
fn C.igColorConvertU32ToFloat4_nonUDT2(@in u32) C.ImVec4_Simple
fn C.igGetMousePos_nonUDT(pOut &C.ImVec2)
fn C.igGetMousePos_nonUDT2() C.ImVec2_Simple
fn C.igGetMousePosOnOpeningCurrentPopup_nonUDT(pOut &C.ImVec2)
fn C.igGetMousePosOnOpeningCurrentPopup_nonUDT2() C.ImVec2_Simple
fn C.igGetMouseDragDelta_nonUDT(pOut &C.ImVec2, button int, lock_threshold f32)
fn C.igGetMouseDragDelta_nonUDT2(button int, lock_threshold f32) C.ImVec2_Simple
fn C.ImColor_HSV_nonUDT(pOut &C.ImColor, self &C.ImColor, h f32, s f32, v f32, a f32)
fn C.ImColor_HSV_nonUDT2(self &C.ImColor, h f32, s f32, v f32, a f32) C.ImColor_Simple
fn C.ImDrawList_GetClipRectMin_nonUDT(pOut &C.ImVec2, self &C.ImDrawList)
fn C.ImDrawList_GetClipRectMin_nonUDT2(self &C.ImDrawList) C.ImVec2_Simple
fn C.ImDrawList_GetClipRectMax_nonUDT(pOut &C.ImVec2, self &C.ImDrawList)
fn C.ImDrawList_GetClipRectMax_nonUDT2(self &C.ImDrawList) C.ImVec2_Simple
fn C.ImFont_CalcTextSizeA_nonUDT(pOut &C.ImVec2, self &C.ImFont, size f32, max_width f32, wrap_width f32, text_begin byteptr, text_end byteptr, remaining &voidptr /* const char** */)
fn C.ImFont_CalcTextSizeA_nonUDT2(self &C.ImFont, size f32, max_width f32, wrap_width f32, text_begin byteptr, text_end byteptr, remaining &voidptr /* const char** */) C.ImVec2_Simple
fn C.igLogText(fmt byteptr)
fn C.ImGuiTextBuffer_appendf(buffer &C.ImGuiTextBuffer, fmt byteptr)
fn C.igGET_FLT_MAX() f32
fn C.igColorConvertRGBtoHSV(r f32, g f32, b f32, out_h &f32, out_s &f32, out_v &f32)
fn C.igColorConvertHSVtoRGB(h f32, s f32, v f32, out_r &f32, out_g &f32, out_b &f32)
// fn C.ImVector_ImWchar_create() &ImVector<ImWchar>
// fn C.ImVector_ImWchar_destroy(self &ImVector<ImWchar>)
// fn C.ImVector_ImWchar_Init(p &ImVector<ImWchar>)
// fn C.ImVector_ImWchar_UnInit(p &ImVector<ImWchar>)