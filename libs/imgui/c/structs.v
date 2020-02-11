module c

pub struct C.ImDrawChannel {
pub mut:
	_CmdBuffer voidptr // ImVector<ImDrawCmd>
	_IdxBuffer voidptr // ImVector<ImDrawIdx>
}

pub struct C.ImDrawCmd {
pub mut:
	ElemCount u32
	ClipRect C.ImVec4
	TextureId voidptr
	VtxOffset u32
	IdxOffset u32
	UserCallback fn(&C.ImDrawList, &C.ImDrawCmd)
	UserCallbackData voidptr
}

pub struct C.ImDrawData {
pub mut:
	Valid bool
	CmdLists &voidptr /* ImDrawList** */
	CmdListsCount int
	TotalIdxCount int
	TotalVtxCount int
	DisplayPos C.ImVec2
	DisplaySize C.ImVec2
	FramebufferScale C.ImVec2
	OwnerViewport &C.ImGuiViewport
}

pub struct C.ImDrawList {
pub mut:
	CmdBuffer voidptr // ImVector<ImDrawCmd>
	IdxBuffer voidptr // ImVector<ImDrawIdx>
	VtxBuffer voidptr // ImVector<ImDrawVert>
	Flags int
	_Data &C.ImDrawListSharedData
	_OwnerName byteptr
	_VtxCurrentOffset u32
	_VtxCurrentIdx u32
	_VtxWritePtr &C.ImDrawVert
	_IdxWritePtr &u16
	_ClipRectStack voidptr // ImVector<ImVec4>
	_TextureIdStack voidptr // ImVector<ImTextureID>
	_Path voidptr // ImVector<ImVec2>
	_Splitter C.ImDrawListSplitter
}

pub struct C.ImDrawListSharedData {
}

pub struct C.ImDrawListSplitter {
pub mut:
	_Current int
	_Count int
	_Channels voidptr // ImVector<ImDrawChannel>
}

pub struct C.ImDrawVert {
pub mut:
	pos C.ImVec2
	uv C.ImVec2
	col u32
}

pub struct C.ImFont {
pub mut:
	IndexAdvanceX voidptr // ImVector<float>
	FallbackAdvanceX f32
	FontSize f32
	IndexLookup voidptr // ImVector<ImWchar>
	Glyphs voidptr // ImVector<ImFontGlyph>
	FallbackGlyph &C.ImFontGlyph
	DisplayOffset C.ImVec2
	ContainerAtlas &C.ImFontAtlas
	ConfigData &C.ImFontConfig
	ConfigDataCount i16
	FallbackChar u16
	EllipsisChar u16
	Scale f32
	Ascent f32
	Descent f32
	MetricsTotalSurface int
	DirtyLookupTables bool
}

pub struct C.ImFontAtlas {
pub mut:
	Locked bool
	Flags int
	TexID voidptr
	TexDesiredWidth int
	TexGlyphPadding int
	TexPixelsAlpha8 &byte
	TexPixelsRGBA32 &u32
	TexWidth int
	TexHeight int
	TexUvScale C.ImVec2
	TexUvWhitePixel C.ImVec2
	Fonts voidptr // ImVector<ImFont *>
	CustomRects voidptr // ImVector<ImFontAtlasCustomRect>
	ConfigData voidptr // ImVector<ImFontConfig>
	CustomRectIds [1]int
}

pub struct C.ImFontConfig {
pub mut:
	FontData voidptr
	FontDataSize int
	FontDataOwnedByAtlas bool
	FontNo int
	SizePixels f32
	OversampleH int
	OversampleV int
	PixelSnapH bool
	GlyphExtraSpacing C.ImVec2
	GlyphOffset C.ImVec2
	GlyphRanges &u16
	GlyphMinAdvanceX f32
	GlyphMaxAdvanceX f32
	MergeMode bool
	RasterizerFlags u32
	RasterizerMultiply f32
	EllipsisChar u16
	Name [40]byte
	DstFont &C.ImFont
}

pub struct C.ImFontGlyph {
pub mut:
	Codepoint u16
	AdvanceX f32
	X0 f32
	Y0 f32
	X1 f32
	Y1 f32
	U0 f32
	V0 f32
	U1 f32
	V1 f32
}

pub struct C.ImFontGlyphRangesBuilder {
pub mut:
	UsedChars voidptr // ImVector<ImU32>
}

pub struct C.ImColor {
pub mut:
	Value C.ImVec4
}

pub struct C.ImGuiContext {
}

pub struct C.ImGuiIO {
pub mut:
	ConfigFlags int
	BackendFlags int
	DisplaySize C.ImVec2
	DeltaTime f32
	IniSavingRate f32
	IniFilename byteptr
	LogFilename byteptr
	MouseDoubleClickTime f32
	MouseDoubleClickMaxDist f32
	MouseDragThreshold f32
	KeyMap [22]int
	KeyRepeatDelay f32
	KeyRepeatRate f32
	UserData voidptr
	Fonts &C.ImFontAtlas
	FontGlobalScale f32
	FontAllowUserScaling bool
	FontDefault &C.ImFont
	DisplayFramebufferScale C.ImVec2
	ConfigDockingNoSplit bool
	ConfigDockingWithShift bool
	ConfigDockingAlwaysTabBar bool
	ConfigDockingTransparentPayload bool
	ConfigViewportsNoAutoMerge bool
	ConfigViewportsNoTaskBarIcon bool
	ConfigViewportsNoDecoration bool
	ConfigViewportsNoDefaultParent bool
	MouseDrawCursor bool
	ConfigMacOSXBehaviors bool
	ConfigInputTextCursorBlink bool
	ConfigWindowsResizeFromEdges bool
	ConfigWindowsMoveFromTitleBarOnly bool
	ConfigWindowsMemoryCompactTimer f32
	BackendPlatformName byteptr
	BackendRendererName byteptr
	BackendPlatformUserData voidptr
	BackendRendererUserData voidptr
	BackendLanguageUserData voidptr
	GetClipboardTextFn fn(voidptr) byteptr
	SetClipboardTextFn fn(voidptr, byteptr)
	ClipboardUserData voidptr
	RenderDrawListsFn fn(&C.ImDrawData)
	MousePos C.ImVec2
	MouseDown [5]bool
	MouseWheel f32
	MouseWheelH f32
	MouseHoveredViewport u32
	KeyCtrl bool
	KeyShift bool
	KeyAlt bool
	KeySuper bool
	KeysDown [512]bool
	NavInputs [21]f32
	WantCaptureMouse bool
	WantCaptureKeyboard bool
	WantTextInput bool
	WantSetMousePos bool
	WantSaveIniSettings bool
	NavActive bool
	NavVisible bool
	Framerate f32
	MetricsRenderVertices int
	MetricsRenderIndices int
	MetricsRenderWindows int
	MetricsActiveWindows int
	MetricsActiveAllocations int
	MouseDelta C.ImVec2
	MousePosPrev C.ImVec2
	MouseClickedPos [5]C.ImVec2
	MouseClickedTime [5]f64
	MouseClicked [5]bool
	MouseDoubleClicked [5]bool
	MouseReleased [5]bool
	MouseDownOwned [5]bool
	MouseDownWasDoubleClick [5]bool
	MouseDownDuration [5]f32
	MouseDownDurationPrev [5]f32
	MouseDragMaxDistanceAbs [5]C.ImVec2
	MouseDragMaxDistanceSqr [5]f32
	KeysDownDuration [512]f32
	KeysDownDurationPrev [512]f32
	NavInputsDownDuration [21]f32
	NavInputsDownDurationPrev [21]f32
	InputQueueCharacters voidptr // ImVector<ImWchar>
}

pub struct C.ImGuiTextEditCallbackData {
pub mut:
	EventFlag int
	Flags int
	UserData voidptr
	EventChar u16
	EventKey int
	Buf byteptr
	BufTextLen int
	BufSize int
	BufDirty bool
	CursorPos int
	SelectionStart int
	SelectionEnd int
}

pub struct C.ImGuiListClipper {
pub mut:
	StartPosY f32
	ItemsHeight f32
	ItemsCount int
	StepNo int
	DisplayStart int
	DisplayEnd int
}

pub struct C.ImGuiOnceUponAFrame {
pub mut:
	RefFrame int
}

pub struct C.ImGuiPayload {
pub mut:
	Data voidptr
	DataSize int
	SourceId u32
	SourceParentId u32
	DataFrameCount int
	DataType [33]byte
	Preview bool
	Delivery bool
}

pub struct C.ImGuiPlatformIO {
pub mut:
	Platform_CreateWindow fn(&C.ImGuiViewport)
	Platform_DestroyWindow fn(&C.ImGuiViewport)
	Platform_ShowWindow fn(&C.ImGuiViewport)
	Platform_SetWindowPos fn(&C.ImGuiViewport, C.ImVec2)
	Platform_GetWindowPos fn(&C.ImGuiViewport) C.ImVec2
	Platform_SetWindowSize fn(&C.ImGuiViewport, C.ImVec2)
	Platform_GetWindowSize fn(&C.ImGuiViewport) C.ImVec2
	Platform_SetWindowFocus fn(&C.ImGuiViewport)
	Platform_GetWindowFocus fn(&C.ImGuiViewport) bool
	Platform_GetWindowMinimized fn(&C.ImGuiViewport) bool
	Platform_SetWindowTitle fn(&C.ImGuiViewport, byteptr)
	Platform_SetWindowAlpha fn(&C.ImGuiViewport, f32)
	Platform_UpdateWindow fn(&C.ImGuiViewport)
	Platform_RenderWindow fn(&C.ImGuiViewport, voidptr)
	Platform_SwapBuffers fn(&C.ImGuiViewport, voidptr)
	Platform_GetWindowDpiScale fn(&C.ImGuiViewport) f32
	Platform_OnChangedViewport fn(&C.ImGuiViewport)
	Platform_SetImeInputPos fn(&C.ImGuiViewport, C.ImVec2)
	Platform_CreateVkSurface fn(&C.ImGuiViewport, u64, voidptr, &u64) int
	Renderer_CreateWindow fn(&C.ImGuiViewport)
	Renderer_DestroyWindow fn(&C.ImGuiViewport)
	Renderer_SetWindowSize fn(&C.ImGuiViewport, C.ImVec2)
	Renderer_RenderWindow fn(&C.ImGuiViewport, voidptr)
	Renderer_SwapBuffers fn(&C.ImGuiViewport, voidptr)
	Monitors voidptr // ImVector<ImGuiPlatformMonitor>
	MainViewport &C.ImGuiViewport
	Viewports voidptr // ImVector<ImGuiViewport *>
}

pub struct C.ImGuiPlatformMonitor {
pub mut:
	MainPos C.ImVec2
	MainSize C.ImVec2
	WorkPos C.ImVec2
	WorkSize C.ImVec2
	DpiScale f32
}

pub struct C.ImGuiSizeCallbackData {
pub mut:
	UserData voidptr
	Pos C.ImVec2
	CurrentSize C.ImVec2
	DesiredSize C.ImVec2
}

pub struct C.ImGuiStorage {
pub mut:
	Data voidptr // ImVector<ImGuiStorage::ImGuiStoragePair>
}

pub struct C.ImGuiStyle {
pub mut:
	Alpha f32
	WindowPadding C.ImVec2
	WindowRounding f32
	WindowBorderSize f32
	WindowMinSize C.ImVec2
	WindowTitleAlign C.ImVec2
	WindowMenuButtonPosition int
	ChildRounding f32
	ChildBorderSize f32
	PopupRounding f32
	PopupBorderSize f32
	FramePadding C.ImVec2
	FrameRounding f32
	FrameBorderSize f32
	ItemSpacing C.ImVec2
	ItemInnerSpacing C.ImVec2
	TouchExtraPadding C.ImVec2
	IndentSpacing f32
	ColumnsMinSpacing f32
	ScrollbarSize f32
	ScrollbarRounding f32
	GrabMinSize f32
	GrabRounding f32
	TabRounding f32
	TabBorderSize f32
	ColorButtonPosition int
	ButtonTextAlign C.ImVec2
	SelectableTextAlign C.ImVec2
	DisplayWindowPadding C.ImVec2
	DisplaySafeAreaPadding C.ImVec2
	MouseCursorScale f32
	AntiAliasedLines bool
	AntiAliasedFill bool
	CurveTessellationTol f32
	Colors [50]C.ImVec4
}

pub struct C.ImGuiTextBuffer {
pub mut:
	Buf voidptr // ImVector<char>
	EmptyString [1]byte
}

pub struct C.ImGuiTextFilter {
pub mut:
	InputBuf [256]byte
	Filters voidptr // ImVector<ImGuiTextFilter::ImGuiTextRange>
	CountGrep int
}

pub struct C.ImGuiViewport {
pub mut:
	ID u32
	Flags int
	Pos C.ImVec2
	Size C.ImVec2
	DpiScale f32
	DrawData &C.ImDrawData
	ParentViewportId u32
	RendererUserData voidptr
	PlatformUserData voidptr
	PlatformHandle voidptr
	PlatformHandleRaw voidptr
	PlatformRequestClose bool
	PlatformRequestMove bool
	PlatformRequestResize bool
}

pub struct C.ImGuiWindowClass {
pub mut:
	ClassId u32
	ParentViewportId u32
	ViewportFlagsOverrideSet int
	ViewportFlagsOverrideClear int
	DockingAlwaysTabBar bool
	DockingAllowUnclassed bool
}

pub struct C.ImVec2 {
pub mut:
	x f32
	y f32
}

pub struct C.ImVec4 {
pub mut:
	x f32
	y f32
	z f32
	w f32
}

pub struct C.ImFontAtlasCustomRect {
pub mut:
	ID u32
	Width u16
	Height u16
	X u16
	Y u16
	GlyphAdvanceX f32
	GlyphOffset C.ImVec2
	Font &C.ImFont
}

pub struct C.ImNewDummy {
}

pub struct C.ImVector {
pub mut:
	Size int
	Capacity int
	Data &T
}