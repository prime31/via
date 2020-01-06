module c

fn C.ImColor_HSV(self &ImColor, h f32, s f32, v f32, a f32) ImColor

fn C.ImColor_ImColor()

fn C.ImColor_SetHSV(self &ImColor, h f32, s f32, v f32, a f32)

fn C.ImColor_destroy(self &ImColor)

fn C.ImDrawCmd_ImDrawCmd()

// fn C.ImDrawCmd_destroy(self &C.ImDrawCmd)

// fn C.ImDrawData_Clear(self &C.ImDrawData)

// fn C.ImDrawData_DeIndexAllBuffers(self &C.ImDrawData)

fn C.ImDrawData_ImDrawData()

// fn C.ImDrawData_ScaleClipRects(self &ImDrawData, fb_scale ImVec2)

// fn C.ImDrawData_destroy(self &ImDrawData)

// fn C.ImDrawListSplitter_Clear(self &ImDrawListSplitter)

// fn C.ImDrawListSplitter_ClearFreeMemory(self &ImDrawListSplitter)

// fn C.ImDrawListSplitter_ImDrawListSplitter()

// fn C.ImDrawListSplitter_Merge(self &ImDrawListSplitter, draw_list &ImDrawList)

// fn C.ImDrawListSplitter_SetCurrentChannel(self &ImDrawListSplitter, draw_list &ImDrawList, channel_idx int)

// fn C.ImDrawListSplitter_Split(self &ImDrawListSplitter, draw_list &ImDrawList, count int)

// fn C.ImDrawListSplitter_destroy(self &ImDrawListSplitter)

// fn C.ImDrawList_AddBezierCurve(self &ImDrawList, pos0 ImVec2, cp0 ImVec2, cp1 ImVec2, pos1 ImVec2, col u32, thickness f32, num_segments int)

// fn C.ImDrawList_AddCallback(self &ImDrawList, callback ImDrawCallback, callback_data voidptr)

// fn C.ImDrawList_AddCircle(self &ImDrawList, center ImVec2, radius f32, col u32, num_segments int, thickness f32)

// fn C.ImDrawList_AddCircleFilled(self &ImDrawList, center ImVec2, radius f32, col u32, num_segments int)

// fn C.ImDrawList_AddConvexPolyFilled(self &ImDrawList, points &ImVec2, num_points int, col u32)

// fn C.ImDrawList_AddDrawCmd(self &ImDrawList)

// fn C.ImDrawList_AddImage(self &ImDrawList, user_texture_id ImTextureID, p_min ImVec2, p_max ImVec2, uv_min ImVec2, uv_max ImVec2, col u32)

// fn C.ImDrawList_AddImageQuad(self &ImDrawList, user_texture_id ImTextureID, p1 ImVec2, p2 ImVec2, p3 ImVec2, p4 ImVec2, uv1 ImVec2, uv2 ImVec2, uv3 ImVec2, uv4 ImVec2, col u32)

// fn C.ImDrawList_AddImageRounded(self &ImDrawList, user_texture_id ImTextureID, p_min ImVec2, p_max ImVec2, uv_min ImVec2, uv_max ImVec2, col u32, rounding f32, rounding_corners ImDrawCornerFlags)

// fn C.ImDrawList_AddLine(self &ImDrawList, p1 ImVec2, p2 ImVec2, col u32, thickness f32)

// fn C.ImDrawList_AddPolyline(self &ImDrawList, points &ImVec2, num_points int, col u32, closed bool, thickness f32)

// fn C.ImDrawList_AddQuad(self &ImDrawList, p1 ImVec2, p2 ImVec2, p3 ImVec2, p4 ImVec2, col u32, thickness f32)

// fn C.ImDrawList_AddQuadFilled(self &ImDrawList, p1 ImVec2, p2 ImVec2, p3 ImVec2, p4 ImVec2, col u32)

// fn C.ImDrawList_AddRect(self &ImDrawList, p_min ImVec2, p_max ImVec2, col u32, rounding f32, rounding_corners ImDrawCornerFlags, thickness f32)

// fn C.ImDrawList_AddRectFilled(self &ImDrawList, p_min ImVec2, p_max ImVec2, col u32, rounding f32, rounding_corners ImDrawCornerFlags)

// fn C.ImDrawList_AddRectFilledMultiColor(self &ImDrawList, p_min ImVec2, p_max ImVec2, col_upr_left u32, col_upr_right u32, col_bot_right u32, col_bot_left u32)

// fn C.ImDrawList_AddText(self &ImDrawList, pos ImVec2, col u32, text_begin byteptr, text_end byteptr)

// fn C.ImDrawList_AddTriangle(self &ImDrawList, p1 ImVec2, p2 ImVec2, p3 ImVec2, col u32, thickness f32)

// fn C.ImDrawList_AddTriangleFilled(self &ImDrawList, p1 ImVec2, p2 ImVec2, p3 ImVec2, col u32)

// fn C.ImDrawList_ChannelsMerge(self &ImDrawList)

// fn C.ImDrawList_ChannelsSetCurrent(self &ImDrawList, n int)

// fn C.ImDrawList_ChannelsSplit(self &ImDrawList, count int)

// fn C.ImDrawList_Clear(self &ImDrawList)

// fn C.ImDrawList_ClearFreeMemory(self &ImDrawList)

// fn C.ImDrawList_CloneOutput(self &ImDrawList) &ImDrawList

// fn C.ImDrawList_GetClipRectMax(self &ImDrawList) ImVec2

// fn C.ImDrawList_GetClipRectMin(self &ImDrawList) ImVec2

// fn C.ImDrawList_ImDrawList(shared_data &ImDrawListSharedData)

// fn C.ImDrawList_PathArcTo(self &ImDrawList, center ImVec2, radius f32, a_min f32, a_max f32, num_segments int)

// fn C.ImDrawList_PathArcToFast(self &ImDrawList, center ImVec2, radius f32, a_min_of_12 int, a_max_of_12 int)

// fn C.ImDrawList_PathBezierCurveTo(self &ImDrawList, p1 ImVec2, p2 ImVec2, p3 ImVec2, num_segments int)

// fn C.ImDrawList_PathClear(self &ImDrawList)

// fn C.ImDrawList_PathFillConvex(self &ImDrawList, col u32)

// fn C.ImDrawList_PathLineTo(self &ImDrawList, pos ImVec2)

// fn C.ImDrawList_PathLineToMergeDuplicate(self &ImDrawList, pos ImVec2)

// fn C.ImDrawList_PathRect(self &ImDrawList, rect_min ImVec2, rect_max ImVec2, rounding f32, rounding_corners ImDrawCornerFlags)

// fn C.ImDrawList_PathStroke(self &ImDrawList, col u32, closed bool, thickness f32)

// fn C.ImDrawList_PopClipRect(self &ImDrawList)

// fn C.ImDrawList_PopTextureID(self &ImDrawList)

// fn C.ImDrawList_PrimQuadUV(self &ImDrawList, a ImVec2, b ImVec2, c ImVec2, d ImVec2, uv_a ImVec2, uv_b ImVec2, uv_c ImVec2, uv_d ImVec2, col u32)

// fn C.ImDrawList_PrimRect(self &ImDrawList, a ImVec2, b ImVec2, col u32)

// fn C.ImDrawList_PrimRectUV(self &ImDrawList, a ImVec2, b ImVec2, uv_a ImVec2, uv_b ImVec2, col u32)

// fn C.ImDrawList_PrimReserve(self &ImDrawList, idx_count int, vtx_count int)

// fn C.ImDrawList_PrimVtx(self &ImDrawList, pos ImVec2, uv ImVec2, col u32)

// fn C.ImDrawList_PrimWriteIdx(self &ImDrawList, idx ImDrawIdx)

// fn C.ImDrawList_PrimWriteVtx(self &ImDrawList, pos ImVec2, uv ImVec2, col u32)

// fn C.ImDrawList_PushClipRect(self &ImDrawList, clip_rect_min ImVec2, clip_rect_max ImVec2, intersect_with_current_clip_rect bool)

// fn C.ImDrawList_PushClipRectFullScreen(self &ImDrawList)

// fn C.ImDrawList_PushTextureID(self &ImDrawList, texture_id ImTextureID)

// fn C.ImDrawList_UpdateClipRect(self &ImDrawList)

// fn C.ImDrawList_UpdateTextureID(self &ImDrawList)

// fn C.ImDrawList_destroy(self &ImDrawList)

fn C.ImFontAtlasCustomRect_ImFontAtlasCustomRect()

fn C.ImFontAtlasCustomRect_IsPacked(self &ImFontAtlasCustomRect) bool

fn C.ImFontAtlasCustomRect_destroy(self &ImFontAtlasCustomRect)

fn C.ImFontAtlas_AddCustomRectFontGlyph(self &ImFontAtlas, font &ImFont, id ImWchar, width int, height int, advance_x f32, offset ImVec2) int

fn C.ImFontAtlas_AddCustomRectRegular(self &ImFontAtlas, id u32, width int, height int) int

fn C.ImFontAtlas_AddFont(self &ImFontAtlas, font_cfg &ImFontConfig) &ImFont

fn C.ImFontAtlas_AddFontDefault(self &ImFontAtlas, font_cfg &ImFontConfig) &ImFont

fn C.ImFontAtlas_AddFontFromFileTTF(self &ImFontAtlas, filename byteptr, size_pixels f32, font_cfg &ImFontConfig, glyph_ranges &ImWchar) &ImFont

fn C.ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(self &ImFontAtlas, compressed_font_data_base85 byteptr, size_pixels f32, font_cfg &ImFontConfig, glyph_ranges &ImWchar) &ImFont

fn C.ImFontAtlas_AddFontFromMemoryCompressedTTF(self &ImFontAtlas, compressed_font_data voidptr, compressed_font_size int, size_pixels f32, font_cfg &ImFontConfig, glyph_ranges &ImWchar) &ImFont

fn C.ImFontAtlas_AddFontFromMemoryTTF(self &ImFontAtlas, font_data voidptr, font_size int, size_pixels f32, font_cfg &ImFontConfig, glyph_ranges &ImWchar) &ImFont

fn C.ImFontAtlas_Build(self &ImFontAtlas) bool

fn C.ImFontAtlas_CalcCustomRectUV(self &ImFontAtlas, rect &ImFontAtlasCustomRect, out_uv_min &ImVec2, out_uv_max &ImVec2)

fn C.ImFontAtlas_Clear(self &ImFontAtlas)

fn C.ImFontAtlas_ClearFonts(self &ImFontAtlas)

fn C.ImFontAtlas_ClearInputData(self &ImFontAtlas)

fn C.ImFontAtlas_ClearTexData(self &ImFontAtlas)

fn C.ImFontAtlas_GetCustomRectByIndex(self &ImFontAtlas, index int) &ImFontAtlasCustomRect

fn C.ImFontAtlas_GetGlyphRangesChineseFull(self &ImFontAtlas) &ImWchar

fn C.ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(self &ImFontAtlas) &ImWchar

fn C.ImFontAtlas_GetGlyphRangesCyrillic(self &ImFontAtlas) &ImWchar

fn C.ImFontAtlas_GetGlyphRangesDefault(self &ImFontAtlas) &ImWchar

fn C.ImFontAtlas_GetGlyphRangesJapanese(self &ImFontAtlas) &ImWchar

fn C.ImFontAtlas_GetGlyphRangesKorean(self &ImFontAtlas) &ImWchar

fn C.ImFontAtlas_GetGlyphRangesThai(self &ImFontAtlas) &ImWchar

fn C.ImFontAtlas_GetGlyphRangesVietnamese(self &ImFontAtlas) &ImWchar

fn C.ImFontAtlas_GetMouseCursorTexData(self &ImFontAtlas, cursor ImGuiMouseCursor, out_offset &ImVec2, out_size &ImVec2, out_uv_border &ImVec2, out_uv_fill &ImVec2) bool

fn C.ImFontAtlas_GetTexDataAsAlpha8(self &ImFontAtlas, out_pixels voidptr, out_width &int, out_height &int, out_bytes_per_pixel &int)

fn C.ImFontAtlas_GetTexDataAsRGBA32(self &ImFontAtlas, out_pixels voidptr, out_width &int, out_height &int, out_bytes_per_pixel &int)

fn C.ImFontAtlas_ImFontAtlas()

fn C.ImFontAtlas_IsBuilt(self &ImFontAtlas) bool

fn C.ImFontAtlas_SetTexID(self &ImFontAtlas, id ImTextureID)

fn C.ImFontAtlas_destroy(self &ImFontAtlas)

fn C.ImFontConfig_ImFontConfig()

fn C.ImFontConfig_destroy(self &ImFontConfig)

fn C.ImFontGlyphRangesBuilder_AddChar(self &ImFontGlyphRangesBuilder, c ImWchar)

fn C.ImFontGlyphRangesBuilder_AddRanges(self &ImFontGlyphRangesBuilder, ranges &ImWchar)

fn C.ImFontGlyphRangesBuilder_AddText(self &ImFontGlyphRangesBuilder, text byteptr, text_end byteptr)

// fn C.ImFontGlyphRangesBuilder_BuildRanges(self &ImFontGlyphRangesBuilder, out_ranges &ImVector_ImWchar)

fn C.ImFontGlyphRangesBuilder_Clear(self &ImFontGlyphRangesBuilder)

fn C.ImFontGlyphRangesBuilder_GetBit(self &ImFontGlyphRangesBuilder, n int) bool

fn C.ImFontGlyphRangesBuilder_ImFontGlyphRangesBuilder()

fn C.ImFontGlyphRangesBuilder_SetBit(self &ImFontGlyphRangesBuilder, n int)

fn C.ImFontGlyphRangesBuilder_destroy(self &ImFontGlyphRangesBuilder)

fn C.ImFont_AddGlyph(self &ImFont, c ImWchar, x0 f32, y0 f32, x1 f32, y1 f32, u0 f32, v0 f32, u1 f32, v1 f32, advance_x f32)

fn C.ImFont_AddRemapChar(self &ImFont, dst ImWchar, src ImWchar, overwrite_dst bool)

fn C.ImFont_BuildLookupTable(self &ImFont)

fn C.ImFont_CalcTextSizeA(self &ImFont, size f32, max_width f32, wrap_width f32, text_begin byteptr, text_end byteptr, remaining voidptr) ImVec2

fn C.ImFont_CalcWordWrapPositionA(self &ImFont, scale f32, text byteptr, text_end byteptr, wrap_width f32) byteptr

fn C.ImFont_ClearOutputData(self &ImFont)

fn C.ImFont_FindGlyph(self &ImFont, c ImWchar) &ImFontGlyph

fn C.ImFont_FindGlyphNoFallback(self &ImFont, c ImWchar) &ImFontGlyph

fn C.ImFont_GetCharAdvance(self &ImFont, c ImWchar) f32

fn C.ImFont_GetDebugName(self &ImFont) byteptr

fn C.ImFont_GrowIndex(self &ImFont, new_size int)

fn C.ImFont_ImFont()

fn C.ImFont_IsLoaded(self &ImFont) bool

// fn C.ImFont_RenderChar(self &ImFont, draw_list &ImDrawList, size f32, pos ImVec2, col u32, c ImWchar)

// fn C.ImFont_RenderText(self &ImFont, draw_list &ImDrawList, size f32, pos ImVec2, col u32, clip_rect C.ImVec4, text_begin byteptr, text_end byteptr, wrap_width f32, cpu_fine_clip bool)

fn C.ImFont_SetFallbackChar(self &ImFont, c ImWchar)

fn C.ImFont_destroy(self &ImFont)

fn C.ImGuiIO_AddInputCharacter(self &ImGuiIO, c u32)

fn C.ImGuiIO_AddInputCharactersUTF8(self &ImGuiIO, str byteptr)

fn C.ImGuiIO_ClearInputCharacters(self &ImGuiIO)

fn C.ImGuiIO_ImGuiIO()

fn C.ImGuiIO_destroy(self &ImGuiIO)

// fn C.ImGuiInputTextCallbackData_DeleteChars(self &ImGuiInputTextCallbackData, pos int, bytes_count int)

// fn C.ImGuiInputTextCallbackData_HasSelection(self &ImGuiInputTextCallbackData) bool

// fn C.ImGuiInputTextCallbackData_ImGuiInputTextCallbackData()

// fn C.ImGuiInputTextCallbackData_InsertChars(self &ImGuiInputTextCallbackData, pos int, text byteptr, text_end byteptr)

// fn C.ImGuiInputTextCallbackData_destroy(self &ImGuiInputTextCallbackData)

fn C.ImGuiListClipper_Begin(self &ImGuiListClipper, items_count int, items_height f32)

fn C.ImGuiListClipper_End(self &ImGuiListClipper)

fn C.ImGuiListClipper_ImGuiListClipper(items_count int, items_height f32)

fn C.ImGuiListClipper_Step(self &ImGuiListClipper) bool

fn C.ImGuiListClipper_destroy(self &ImGuiListClipper)

fn C.ImGuiOnceUponAFrame_ImGuiOnceUponAFrame()

fn C.ImGuiOnceUponAFrame_destroy(self &ImGuiOnceUponAFrame)

fn C.ImGuiPayload_Clear(self &ImGuiPayload)

fn C.ImGuiPayload_ImGuiPayload()

fn C.ImGuiPayload_IsDataType(self &ImGuiPayload, @type byteptr) bool

fn C.ImGuiPayload_IsDelivery(self &ImGuiPayload) bool

fn C.ImGuiPayload_IsPreview(self &ImGuiPayload) bool

fn C.ImGuiPayload_destroy(self &ImGuiPayload)

fn C.ImGuiStoragePair_ImGuiStoragePair(_key ImGuiID, _val_i int)

fn C.ImGuiStoragePair_destroy(self &ImGuiStoragePair)

fn C.ImGuiStorage_BuildSortByKey(self &ImGuiStorage)

fn C.ImGuiStorage_Clear(self &ImGuiStorage)

fn C.ImGuiStorage_GetBool(self &ImGuiStorage, key ImGuiID, default_val bool) bool

fn C.ImGuiStorage_GetBoolRef(self &ImGuiStorage, key ImGuiID, default_val bool) &bool

fn C.ImGuiStorage_GetFloat(self &ImGuiStorage, key ImGuiID, default_val f32) f32

fn C.ImGuiStorage_GetFloatRef(self &ImGuiStorage, key ImGuiID, default_val f32) &f32

fn C.ImGuiStorage_GetInt(self &ImGuiStorage, key ImGuiID, default_val int) int

fn C.ImGuiStorage_GetIntRef(self &ImGuiStorage, key ImGuiID, default_val int) &int

fn C.ImGuiStorage_GetVoidPtr(self &ImGuiStorage, key ImGuiID) voidptr

fn C.ImGuiStorage_GetVoidPtrRef(self &ImGuiStorage, key ImGuiID, default_val voidptr) &voidptr

fn C.ImGuiStorage_SetAllInt(self &ImGuiStorage, val int)

fn C.ImGuiStorage_SetBool(self &ImGuiStorage, key ImGuiID, val bool)

fn C.ImGuiStorage_SetFloat(self &ImGuiStorage, key ImGuiID, val f32)

fn C.ImGuiStorage_SetInt(self &ImGuiStorage, key ImGuiID, val int)

fn C.ImGuiStorage_SetVoidPtr(self &ImGuiStorage, key ImGuiID, val voidptr)

fn C.ImGuiStyle_ImGuiStyle()

fn C.ImGuiStyle_ScaleAllSizes(self &ImGuiStyle, scale_factor f32)

fn C.ImGuiStyle_destroy(self &ImGuiStyle)

fn C.ImGuiTextBuffer_ImGuiTextBuffer()

fn C.ImGuiTextBuffer_append(self &ImGuiTextBuffer, str byteptr, str_end byteptr)

// fn C.ImGuiTextBuffer_appendf(self &ImGuiTextBuffer, fmt byteptr, ... ...)

fn C.ImGuiTextBuffer_appendfv(self &ImGuiTextBuffer, fmt byteptr, args voidptr /*va_list*/)

fn C.ImGuiTextBuffer_begin(self &ImGuiTextBuffer) byteptr

fn C.ImGuiTextBuffer_c_str(self &ImGuiTextBuffer) byteptr

fn C.ImGuiTextBuffer_clear(self &ImGuiTextBuffer)

fn C.ImGuiTextBuffer_destroy(self &ImGuiTextBuffer)

fn C.ImGuiTextBuffer_empty(self &ImGuiTextBuffer) bool

fn C.ImGuiTextBuffer_end(self &ImGuiTextBuffer) byteptr

fn C.ImGuiTextBuffer_reserve(self &ImGuiTextBuffer, capacity int)

fn C.ImGuiTextBuffer_size(self &ImGuiTextBuffer) int

fn C.ImGuiTextFilter_Build(self &ImGuiTextFilter)

fn C.ImGuiTextFilter_Clear(self &ImGuiTextFilter)

fn C.ImGuiTextFilter_Draw(self &ImGuiTextFilter, label byteptr, width f32) bool

fn C.ImGuiTextFilter_ImGuiTextFilter(default_filter byteptr)

fn C.ImGuiTextFilter_IsActive(self &ImGuiTextFilter) bool

fn C.ImGuiTextFilter_PassFilter(self &ImGuiTextFilter, text byteptr, text_end byteptr) bool

fn C.ImGuiTextFilter_destroy(self &ImGuiTextFilter)

fn C.ImGuiTextRange_ImGuiTextRange()

fn C.ImGuiTextRange_destroy(self &ImGuiTextRange)

fn C.ImGuiTextRange_empty(self &ImGuiTextRange) bool

// fn C.ImGuiTextRange_split(self &ImGuiTextRange, separator byte, out &ImVector_ImGuiTextRange)

fn C.ImVec2_ImVec2()

fn C.ImVec2_destroy(self &ImVec2)

fn C.ImVec4_ImVec4()

fn C.ImVec4_destroy(self &ImVec4)

fn C.ImVector_ImVector()

// fn C.ImVector__grow_capacity(self &ImVector, sz int) int

// fn C.ImVector_back(self &ImVector) &T

// fn C.ImVector_begin(self &ImVector) &T

// fn C.ImVector_capacity(self &ImVector) int

// fn C.ImVector_clear(self &ImVector)

// fn C.ImVector_contains(self &ImVector, v T) bool

// fn C.ImVector_destroy(self &ImVector)

// fn C.ImVector_empty(self &ImVector) bool

// fn C.ImVector_end(self &ImVector) &T

// fn C.ImVector_erase(self &ImVector, it &T) &T

// fn C.ImVector_erase_unsorted(self &ImVector, it &T) &T

// fn C.ImVector_find(self &ImVector, v T) &T

// fn C.ImVector_find_erase(self &ImVector, v T) bool

// fn C.ImVector_find_erase_unsorted(self &ImVector, v T) bool

// fn C.ImVector_front(self &ImVector) &T

// fn C.ImVector_index_from_ptr(self &ImVector, it &T) int

// fn C.ImVector_insert(self &ImVector, it &T, v T) &T

// fn C.ImVector_pop_back(self &ImVector)

// fn C.ImVector_push_back(self &ImVector, v T)

// fn C.ImVector_push_front(self &ImVector, v T)

// fn C.ImVector_reserve(self &ImVector, new_capacity int)

// fn C.ImVector_resize(self &ImVector, new_size int)

// fn C.ImVector_shrink(self &ImVector, new_size int)

// fn C.ImVector_size(self &ImVector) int

// fn C.ImVector_size_in_bytes(self &ImVector) int

// fn C.ImVector_swap(self &ImVector, rhs &ImVector)

fn C.igAcceptDragDropPayload(@type byteptr, flags ImGuiDragDropFlags) &ImGuiPayload

fn C.igAlignTextToFramePadding()

fn C.igArrowButton(str_id byteptr, dir ImGuiDir) bool

fn C.igBegin(name byteptr, p_open &bool, flags ImGuiWindowFlags) bool

fn C.igBeginChild(str_id byteptr, size ImVec2, border bool, flags ImGuiWindowFlags) bool

fn C.igBeginChildFrame(id ImGuiID, size ImVec2, flags ImGuiWindowFlags) bool

fn C.igBeginCombo(label byteptr, preview_value byteptr, flags ImGuiComboFlags) bool

fn C.igBeginDragDropSource(flags ImGuiDragDropFlags) bool

fn C.igBeginDragDropTarget() bool

fn C.igBeginGroup()

fn C.igBeginMainMenuBar() bool

fn C.igBeginMenu(label byteptr, enabled bool) bool

fn C.igBeginMenuBar() bool

fn C.igBeginPopup(str_id byteptr, flags ImGuiWindowFlags) bool

fn C.igBeginPopupContextItem(str_id byteptr, mouse_button int) bool

fn C.igBeginPopupContextVoid(str_id byteptr, mouse_button int) bool

fn C.igBeginPopupContextWindow(str_id byteptr, mouse_button int, also_over_items bool) bool

fn C.igBeginPopupModal(name byteptr, p_open &bool, flags ImGuiWindowFlags) bool

fn C.igBeginTabBar(str_id byteptr, flags ImGuiTabBarFlags) bool

fn C.igBeginTabItem(label byteptr, p_open &bool, flags ImGuiTabItemFlags) bool

fn C.igBeginTooltip()

fn C.igBullet()

// fn C.igBulletText(fmt byteptr, ... ...)

fn C.igBulletTextV(fmt byteptr, args voidptr /*va_list*/)

fn C.igButton(label byteptr, size ImVec2) bool

fn C.igCalcItemWidth() f32

fn C.igCalcListClipping(items_count int, items_height f32, out_items_display_start &int, out_items_display_end &int)

fn C.igCalcTextSize(text byteptr, text_end byteptr, hide_text_after_double_hash bool, wrap_width f32) ImVec2

fn C.igCaptureKeyboardFromApp(want_capture_keyboard_value bool)

fn C.igCaptureMouseFromApp(want_capture_mouse_value bool)

fn C.igCheckbox(label byteptr, v &bool) bool

fn C.igCheckboxFlags(label byteptr, flags &u32, flags_value u32) bool

fn C.igCloseCurrentPopup()

fn C.igCollapsingHeader(label byteptr, flags ImGuiTreeNodeFlags) bool

fn C.igColorButton(desc_id byteptr, col C.ImVec4, flags ImGuiColorEditFlags, size ImVec2) bool

fn C.igColorConvertFloat4ToU32(inn C.ImVec4) u32

fn C.igColorConvertHSVtoRGB(h f32, s f32, v f32, out_r &f32, out_g &f32, out_b &f32)

fn C.igColorConvertRGBtoHSV(r f32, g f32, b f32, out_h &f32, out_s &f32, out_v &f32)

fn C.igColorConvertU32ToFloat4(inn u32) ImVec4

fn C.igColorEdit3(label byteptr, col []f32, flags ImGuiColorEditFlags) bool

fn C.igColorEdit4(label byteptr, col []f32, flags ImGuiColorEditFlags) bool

fn C.igColorPicker3(label byteptr, col []f32, flags ImGuiColorEditFlags) bool

fn C.igColorPicker4(label byteptr, col []f32, flags ImGuiColorEditFlags, ref_col &f32) bool

fn C.igColumns(count int, id byteptr, border bool)

// fn C.igCombo(label byteptr, current_item &int, items []]char* const, items_count int, popup_max_height_in_items int) bool

// fn C.igCreateContext(shared_font_atlas &ImFontAtlas) &ImGuiContext

fn C.igDebugCheckVersionAndDataLayout(version_str byteptr, sz_io u32, sz_style u32, sz_vec2 u32, sz_vec4 u32, sz_drawvert u32, sz_drawidx u32) bool

// fn C.igDestroyContext(ctx &ImGuiContext)

fn C.igDragFloat(label byteptr, v &f32, v_speed f32, v_min f32, v_max f32, format byteptr, power f32) bool

fn C.igDragFloat2(label byteptr, v []f32, v_speed f32, v_min f32, v_max f32, format byteptr, power f32) bool

fn C.igDragFloat3(label byteptr, v []f32, v_speed f32, v_min f32, v_max f32, format byteptr, power f32) bool

fn C.igDragFloat4(label byteptr, v []f32, v_speed f32, v_min f32, v_max f32, format byteptr, power f32) bool

fn C.igDragFloatRange2(label byteptr, v_current_min &f32, v_current_max &f32, v_speed f32, v_min f32, v_max f32, format byteptr, format_max byteptr, power f32) bool

fn C.igDragInt(label byteptr, v &int, v_speed f32, v_min int, v_max int, format byteptr) bool

fn C.igDragInt2(label byteptr, v []int, v_speed f32, v_min int, v_max int, format byteptr) bool

fn C.igDragInt3(label byteptr, v []int, v_speed f32, v_min int, v_max int, format byteptr) bool

fn C.igDragInt4(label byteptr, v []int, v_speed f32, v_min int, v_max int, format byteptr) bool

fn C.igDragIntRange2(label byteptr, v_current_min &int, v_current_max &int, v_speed f32, v_min int, v_max int, format byteptr, format_max byteptr) bool

fn C.igDragScalar(label byteptr, data_type ImGuiDataType, p_data voidptr, v_speed f32, p_min voidptr, p_max voidptr, format byteptr, power f32) bool

fn C.igDragScalarN(label byteptr, data_type ImGuiDataType, p_data voidptr, components int, v_speed f32, p_min voidptr, p_max voidptr, format byteptr, power f32) bool

fn C.igDummy(size ImVec2)

fn C.igEnd()

fn C.igEndChild()

fn C.igEndChildFrame()

fn C.igEndCombo()

fn C.igEndDragDropSource()

fn C.igEndDragDropTarget()

fn C.igEndFrame()

fn C.igEndGroup()

fn C.igEndMainMenuBar()

fn C.igEndMenu()

fn C.igEndMenuBar()

fn C.igEndPopup()

fn C.igEndTabBar()

fn C.igEndTabItem()

fn C.igEndTooltip()

// fn C.igGetBackgroundDrawList() &ImDrawList

fn C.igGetClipboardText() byteptr

fn C.igGetColorU32(idx ImGuiCol, alpha_mul f32) u32

fn C.igGetColumnIndex() int

fn C.igGetColumnOffset(column_index int) f32

fn C.igGetColumnWidth(column_index int) f32

fn C.igGetColumnsCount() int

fn C.igGetContentRegionAvail() ImVec2

fn C.igGetContentRegionMax() ImVec2

// fn C.igGetCurrentContext() &ImGuiContext

fn C.igGetCursorPos() ImVec2

fn C.igGetCursorPosX() f32

fn C.igGetCursorPosY() f32

fn C.igGetCursorScreenPos() ImVec2

fn C.igGetCursorStartPos() ImVec2

fn C.igGetDragDropPayload() &ImGuiPayload

// fn C.igGetDrawData() &ImDrawData

// fn C.igGetDrawListSharedData() &ImDrawListSharedData

fn C.igGetFont() &ImFont

fn C.igGetFontSize() f32

fn C.igGetFontTexUvWhitePixel() ImVec2

// fn C.igGetForegroundDrawList() &ImDrawList

fn C.igGetFrameCount() int

fn C.igGetFrameHeight() f32

fn C.igGetFrameHeightWithSpacing() f32

fn C.igGetID(str_id byteptr) ImGuiID

fn C.igGetIO() &C.ImGuiIO

fn C.igGetItemRectMax() ImVec2

fn C.igGetItemRectMin() ImVec2

fn C.igGetItemRectSize() ImVec2

fn C.igGetKeyIndex(imgui_key ImGuiKey) int

fn C.igGetKeyPressedAmount(key_index int, repeat_delay f32, rate f32) int

fn C.igGetMouseCursor() ImGuiMouseCursor

fn C.igGetMouseDragDelta(button int, lock_threshold f32) ImVec2

fn C.igGetMousePos() ImVec2

fn C.igGetMousePosOnOpeningCurrentPopup() ImVec2

fn C.igGetScrollMaxX() f32

fn C.igGetScrollMaxY() f32

fn C.igGetScrollX() f32

fn C.igGetScrollY() f32

fn C.igGetStateStorage() &ImGuiStorage

fn C.igGetStyle() &C.ImGuiStyle

fn C.igGetStyleColorName(idx ImGuiCol) byteptr

fn C.igGetStyleColorVec4(idx ImGuiCol) &ImVec4

fn C.igGetTextLineHeight() f32

fn C.igGetTextLineHeightWithSpacing() f32

fn C.igGetTime() f64

fn C.igGetTreeNodeToLabelSpacing() f32

fn C.igGetVersion() byteptr

fn C.igGetWindowContentRegionMax() ImVec2

fn C.igGetWindowContentRegionMin() ImVec2

fn C.igGetWindowContentRegionWidth() f32

// fn C.igGetWindowDrawList() &ImDrawList

fn C.igGetWindowHeight() f32

fn C.igGetWindowPos() ImVec2

fn C.igGetWindowSize() ImVec2

fn C.igGetWindowWidth() f32

fn C.igImage(user_texture_id ImTextureID, size ImVec2, uv0 ImVec2, uv1 ImVec2, tint_col C.ImVec4, border_col C.ImVec4)

fn C.igImageButton(user_texture_id ImTextureID, size ImVec2, uv0 ImVec2, uv1 ImVec2, frame_padding int, bg_col C.ImVec4, tint_col C.ImVec4) bool

fn C.igIndent(inndent_w f32)

fn C.igInputDouble(label byteptr, v &f64, step f64, step_fast f64, format byteptr, flags ImGuiInputTextFlags) bool

fn C.igInputFloat(label byteptr, v &f32, step f32, step_fast f32, format byteptr, flags ImGuiInputTextFlags) bool

fn C.igInputFloat2(label byteptr, v []f32, format byteptr, flags ImGuiInputTextFlags) bool

fn C.igInputFloat3(label byteptr, v []f32, format byteptr, flags ImGuiInputTextFlags) bool

fn C.igInputFloat4(label byteptr, v []f32, format byteptr, flags ImGuiInputTextFlags) bool

fn C.igInputInt(label byteptr, v &int, step int, step_fast int, flags ImGuiInputTextFlags) bool

fn C.igInputInt2(label byteptr, v []int, flags ImGuiInputTextFlags) bool

fn C.igInputInt3(label byteptr, v []int, flags ImGuiInputTextFlags) bool

fn C.igInputInt4(label byteptr, v []int, flags ImGuiInputTextFlags) bool

fn C.igInputScalar(label byteptr, data_type ImGuiDataType, p_data voidptr, p_step voidptr, p_step_fast voidptr, format byteptr, flags ImGuiInputTextFlags) bool

fn C.igInputScalarN(label byteptr, data_type ImGuiDataType, p_data voidptr, components int, p_step voidptr, p_step_fast voidptr, format byteptr, flags ImGuiInputTextFlags) bool

// fn C.igInputText(label byteptr, buf &byte, buf_size u32, flags ImGuiInputTextFlags, callback ImGuiInputTextCallback, user_data voidptr) bool

// fn C.igInputTextMultiline(label byteptr, buf &byte, buf_size u32, size ImVec2, flags ImGuiInputTextFlags, callback ImGuiInputTextCallback, user_data voidptr) bool

// fn C.igInputTextWithHint(label byteptr, hint byteptr, buf &byte, buf_size u32, flags ImGuiInputTextFlags, callback ImGuiInputTextCallback, user_data voidptr) bool

fn C.igInvisibleButton(str_id byteptr, size ImVec2) bool

fn C.igIsAnyItemActive() bool

fn C.igIsAnyItemFocused() bool

fn C.igIsAnyItemHovered() bool

fn C.igIsAnyMouseDown() bool

fn C.igIsItemActivated() bool

fn C.igIsItemActive() bool

fn C.igIsItemClicked(mouse_button int) bool

fn C.igIsItemDeactivated() bool

fn C.igIsItemDeactivatedAfterEdit() bool

fn C.igIsItemEdited() bool

fn C.igIsItemFocused() bool

fn C.igIsItemHovered(flags ImGuiHoveredFlags) bool

fn C.igIsItemToggledOpen() bool

fn C.igIsItemVisible() bool

fn C.igIsKeyDown(user_key_index int) bool

fn C.igIsKeyPressed(user_key_index int, repeat bool) bool

fn C.igIsKeyReleased(user_key_index int) bool

fn C.igIsMouseClicked(button int, repeat bool) bool

fn C.igIsMouseDoubleClicked(button int) bool

fn C.igIsMouseDown(button int) bool

fn C.igIsMouseDragging(button int, lock_threshold f32) bool

fn C.igIsMouseHoveringRect(r_min ImVec2, r_max ImVec2, clip bool) bool

fn C.igIsMousePosValid(mouse_pos &ImVec2) bool

fn C.igIsMouseReleased(button int) bool

fn C.igIsPopupOpen(str_id byteptr) bool

fn C.igIsRectVisible(size ImVec2) bool

fn C.igIsWindowAppearing() bool

fn C.igIsWindowCollapsed() bool

fn C.igIsWindowFocused(flags ImGuiFocusedFlags) bool

fn C.igIsWindowHovered(flags ImGuiHoveredFlags) bool

// fn C.igLabelText(label byteptr, fmt byteptr, ... ...)

fn C.igLabelTextV(label byteptr, fmt byteptr, args voidptr /*va_list*/)

// fn C.igListBox(label byteptr, current_item &int, items []]char* const, items_count int, height_in_items int) bool

fn C.igListBoxFooter()

fn C.igListBoxHeader(label byteptr, size ImVec2) bool

fn C.igLoadIniSettingsFromDisk(inni_filename byteptr)

fn C.igLoadIniSettingsFromMemory(inni_data byteptr, ini_size u32)

fn C.igLogButtons()

fn C.igLogFinish()

// fn C.igLogText(fmt byteptr, ... ...)

fn C.igLogToClipboard(auto_open_depth int)

fn C.igLogToFile(auto_open_depth int, filename byteptr)

fn C.igLogToTTY(auto_open_depth int)

fn C.igMemAlloc(size u32) voidptr

fn C.igMemFree(ptr voidptr)

fn C.igMenuItemBool(label byteptr, shortcut byteptr, selected bool, enabled bool) bool
fn C.igMenuItemBoolPtr(label byteptr, shortcut byteptr, p_selected &bool, enabled bool) bool
fn C.igMenuItem(label byteptr, shortcut byteptr, selected bool, enabled bool) bool

fn C.igNewFrame()

fn C.igNewLine()

fn C.igNextColumn()

fn C.igOpenPopup(str_id byteptr)

fn C.igOpenPopupOnItemClick(str_id byteptr, mouse_button int) bool

fn C.igPlotHistogram(label byteptr, values &f32, values_count int, values_offset int, overlay_text byteptr, scale_min f32, scale_max f32, graph_size ImVec2, stride int)

fn C.igPlotLines(label byteptr, values &f32, values_count int, values_offset int, overlay_text byteptr, scale_min f32, scale_max f32, graph_size ImVec2, stride int)

fn C.igPopAllowKeyboardFocus()

fn C.igPopButtonRepeat()

fn C.igPopClipRect()

fn C.igPopFont()

fn C.igPopID()

fn C.igPopItemWidth()

fn C.igPopStyleColor(count int)

fn C.igPopStyleVar(count int)

fn C.igPopTextWrapPos()

fn C.igProgressBar(fraction f32, size_arg ImVec2, overlay byteptr)

fn C.igPushAllowKeyboardFocus(allow_keyboard_focus bool)

fn C.igPushButtonRepeat(repeat bool)

fn C.igPushClipRect(clip_rect_min ImVec2, clip_rect_max ImVec2, intersect_with_current_clip_rect bool)

fn C.igPushFont(font &ImFont)

fn C.igPushID(str_id byteptr)

fn C.igPushItemWidth(item_width f32)

fn C.igPushStyleColor(idx ImGuiCol, col u32)

fn C.igPushStyleVar(idx ImGuiStyleVar, val f32)

fn C.igPushTextWrapPos(wrap_local_pos_x f32)

fn C.igRadioButton(label byteptr, active bool) bool

fn C.igRender()

fn C.igResetMouseDragDelta(button int)

fn C.igSameLine(offset_from_start_x f32, spacing f32)

fn C.igSaveIniSettingsToDisk(inni_filename byteptr)

fn C.igSaveIniSettingsToMemory(out_ini_size &u32) byteptr

fn C.igSelectable(label byteptr, selected bool, flags ImGuiSelectableFlags, size ImVec2) bool

fn C.igSeparator()

fn C.igSetAllocatorFunctions(alloc_func voidptr /*void*(*)(size_t sz,void* user_data)*/, free_func voidptr /*void(*)(void* ptr,void* user_data)*/, user_data voidptr)

fn C.igSetClipboardText(text byteptr)

fn C.igSetColorEditOptions(flags ImGuiColorEditFlags)

fn C.igSetColumnOffset(column_index int, offset_x f32)

fn C.igSetColumnWidth(column_index int, width f32)

// fn C.igSetCurrentContext(ctx &ImGuiContext)

fn C.igSetCursorPos(local_pos ImVec2)

fn C.igSetCursorPosX(local_x f32)

fn C.igSetCursorPosY(local_y f32)

fn C.igSetCursorScreenPos(pos ImVec2)

fn C.igSetDragDropPayload(@type byteptr, data voidptr, sz u32, cond ImGuiCond) bool

fn C.igSetItemAllowOverlap()

fn C.igSetItemDefaultFocus()

fn C.igSetKeyboardFocusHere(offset int)

fn C.igSetMouseCursor(@type ImGuiMouseCursor)

fn C.igSetNextItemOpen(is_open bool, cond ImGuiCond)

fn C.igSetNextItemWidth(item_width f32)

fn C.igSetNextWindowBgAlpha(alpha f32)

fn C.igSetNextWindowCollapsed(collapsed bool, cond ImGuiCond)

fn C.igSetNextWindowContentSize(size ImVec2)

fn C.igSetNextWindowFocus()

fn C.igSetNextWindowPos(pos ImVec2, cond ImGuiCond, pivot ImVec2)

fn C.igSetNextWindowSize(size ImVec2, cond ImGuiCond)

// fn C.igSetNextWindowSizeConstraints(size_min ImVec2, size_max ImVec2, custom_callback ImGuiSizeCallback, custom_callback_data voidptr)

fn C.igSetScrollFromPosX(local_x f32, center_x_ratio f32)

fn C.igSetScrollFromPosY(local_y f32, center_y_ratio f32)

fn C.igSetScrollHereX(center_x_ratio f32)

fn C.igSetScrollHereY(center_y_ratio f32)

fn C.igSetScrollX(scroll_x f32)

fn C.igSetScrollY(scroll_y f32)

fn C.igSetStateStorage(storage &ImGuiStorage)

fn C.igSetTabItemClosed(tab_or_docked_window_label byteptr)

// fn C.igSetTooltip(fmt byteptr, ... ...)

fn C.igSetTooltipV(fmt byteptr, args voidptr /*va_list*/)

fn C.igSetWindowCollapsed(collapsed bool, cond ImGuiCond)

fn C.igSetWindowFocus()

fn C.igSetWindowFontScale(scale f32)

fn C.igSetWindowPos(pos ImVec2, cond ImGuiCond)

fn C.igSetWindowSize(size ImVec2, cond ImGuiCond)

fn C.igShowAboutWindow(p_open &bool)

fn C.igShowDemoWindow(p_open &bool)

fn C.igShowFontSelector(label byteptr)

fn C.igShowMetricsWindow(p_open &bool)

fn C.igShowStyleEditor(ref &ImGuiStyle)

fn C.igShowStyleSelector(label byteptr) bool

fn C.igShowUserGuide()

fn C.igSliderAngle(label byteptr, v_rad &f32, v_degrees_min f32, v_degrees_max f32, format byteptr) bool

fn C.igSliderFloat(label byteptr, v &f32, v_min f32, v_max f32, format byteptr, power f32) bool

fn C.igSliderFloat2(label byteptr, v []f32, v_min f32, v_max f32, format byteptr, power f32) bool

fn C.igSliderFloat3(label byteptr, v []f32, v_min f32, v_max f32, format byteptr, power f32) bool

fn C.igSliderFloat4(label byteptr, v []f32, v_min f32, v_max f32, format byteptr, power f32) bool

fn C.igSliderInt(label byteptr, v &int, v_min int, v_max int, format byteptr) bool

fn C.igSliderInt2(label byteptr, v []int, v_min int, v_max int, format byteptr) bool

fn C.igSliderInt3(label byteptr, v []int, v_min int, v_max int, format byteptr) bool

fn C.igSliderInt4(label byteptr, v []int, v_min int, v_max int, format byteptr) bool

fn C.igSliderScalar(label byteptr, data_type ImGuiDataType, p_data voidptr, p_min voidptr, p_max voidptr, format byteptr, power f32) bool

fn C.igSliderScalarN(label byteptr, data_type ImGuiDataType, p_data voidptr, components int, p_min voidptr, p_max voidptr, format byteptr, power f32) bool

fn C.igSmallButton(label byteptr) bool

fn C.igSpacing()

fn C.igStyleColorsClassic(dst &ImGuiStyle)

fn C.igStyleColorsDark(dst &ImGuiStyle)

fn C.igStyleColorsLight(dst &ImGuiStyle)

// fn C.igText(fmt byteptr, ... ...)

// fn C.igTextColored(col C.ImVec4, fmt byteptr, ... ...)

fn C.igTextColoredV(col C.ImVec4, fmt byteptr, args voidptr /*va_list*/)

// fn C.igTextDisabled(fmt byteptr, ... ...)

fn C.igTextDisabledV(fmt byteptr, args voidptr /*va_list*/)

fn C.igTextUnformatted(text byteptr, text_end byteptr)

fn C.igTextV(fmt byteptr, args voidptr /*va_list*/)

// fn C.igTextWrapped(fmt byteptr, ... ...)

fn C.igTextWrappedV(fmt byteptr, args voidptr /*va_list*/)

fn C.igTreeNode(label byteptr) bool

fn C.igTreeNodeEx(label byteptr, flags ImGuiTreeNodeFlags) bool

fn C.igTreeNodeExV(str_id byteptr, flags ImGuiTreeNodeFlags, fmt byteptr, args voidptr /*va_list*/) bool

fn C.igTreeNodeV(str_id byteptr, fmt byteptr, args voidptr /*va_list*/) bool

fn C.igTreePop()

fn C.igTreePush(str_id byteptr)

fn C.igUnindent(inndent_w f32)

fn C.igVSliderFloat(label byteptr, size ImVec2, v &f32, v_min f32, v_max f32, format byteptr, power f32) bool

fn C.igVSliderInt(label byteptr, size ImVec2, v &int, v_min int, v_max int, format byteptr) bool

fn C.igVSliderScalar(label byteptr, size ImVec2, data_type ImGuiDataType, p_data voidptr, p_min voidptr, p_max voidptr, format byteptr, power f32) bool

fn C.igValue(prefix byteptr, b bool)
