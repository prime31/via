module c

type ImWchar u16
type ImGuiID u32
type ImTextureID voidptr

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

pub struct C.ImColor {
pub mut:
	Value ImVec4
}

pub struct C.ImFont {
pub mut:
	IndexAdvanceX voidptr // ImVector_float
	FallbackAdvanceX f32
	FontSize f32
	IndexLookup voidptr // ImVector_ImWchar
	Glyphs voidptr // ImVector_ImFontGlyph
	FallbackGlyph voidptr // &(ImFontGlyph, False)
	DisplayOffset ImVec2
	ContainerAtlas voidptr // &(ImFontAtlas, False)
	ConfigData voidptr // &(ImFontConfig, False)
	ConfigDataCount i16
	FallbackChar ImWchar
	EllipsisChar ImWchar
	Scale f32
	Ascent f32
	Descent f32
	MetricsTotalSurface int
	DirtyLookupTables bool
}

pub struct C.ImFontAtlas {
pub mut:
	Locked bool
	Flags ImFontAtlasFlags
	TexID voidptr // ImTextureID
	TexDesiredWidth int
	TexGlyphPadding int
	TexPixelsAlpha8 voidptr // &(unsigned char, False)
	TexPixelsRGBA32 voidptr // &(u32, True)
	TexWidth int
	TexHeight int
	TexUvScale ImVec2
	TexUvWhitePixel ImVec2
	Fonts voidptr // ImVector_ImFontPtr
	CustomRects voidptr // ImVector_ImFontAtlasCustomRect
	ConfigData voidptr // ImVector_ImFontConfig
	CustomRectIds [1]int
}

pub struct C.ImFontAtlasCustomRect {
pub mut:
	ID u32
	Width u16
	Height u16
	X u16
	Y u16
	GlyphAdvanceX f32
	GlyphOffset ImVec2
	Font voidptr // &(ImFont, False)
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
	GlyphExtraSpacing ImVec2
	GlyphOffset ImVec2
	GlyphRanges voidptr // &(ImWchar, False)
	GlyphMinAdvanceX f32
	GlyphMaxAdvanceX f32
	MergeMode bool
	RasterizerFlags u32
	RasterizerMultiply f32
	EllipsisChar ImWchar
	Name [40]byte
	// DstFont &(ImFont, False)
}

pub struct C.ImFontGlyph {
pub mut:
	Codepoint ImWchar
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
	UsedChars voidptr // ImVector_ImU32
}

pub struct C.ImGuiIO {
pub mut:
	ConfigFlags ImGuiConfigFlags
	BackendFlags ImGuiBackendFlags
	DisplaySize ImVec2
	DeltaTime f32
	IniSavingRate f32
	IniFilename byteptr
	LogFilename byteptr
	MouseDoubleClickTime f32
	MouseDoubleClickMaxDist f32
	MouseDragThreshold f32
	KeyMap [ImGuiKey_COUNT]int
	KeyRepeatDelay f32
	KeyRepeatRate f32
	UserData voidptr
	Fonts voidptr // &(ImFontAtlas, False)
	FontGlobalScale f32
	FontAllowUserScaling bool
	FontDefault voidptr // &(ImFont, False)
	DisplayFramebufferScale ImVec2
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
	GetClipboardTextFn voidptr // char*(*)(void* user_data)
	SetClipboardTextFn voidptr // void(*)(void* user_data,char* text)
	ClipboardUserData voidptr
	ImeSetInputScreenPosFn voidptr // void(*)(int x,int y)
	ImeWindowHandle voidptr
	RenderDrawListsFnUnused voidptr
	MousePos ImVec2
	MouseDown [5]bool
	MouseWheel f32
	MouseWheelH f32
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
	MouseDelta ImVec2
	MousePosPrev ImVec2
	MouseClickedPos [5]ImVec2
	MouseClickedTime [5]double
	MouseClicked [5]bool
	MouseDoubleClicked [5]bool
	MouseReleased [5]bool
	MouseDownOwned [5]bool
	MouseDownWasDoubleClick [5]bool
	MouseDownDuration [5]f32
	MouseDownDurationPrev [5]f32
	MouseDragMaxDistanceAbs [5]ImVec2
	MouseDragMaxDistanceSqr [5]f32
	KeysDownDuration [512]f32
	KeysDownDurationPrev [512]f32
	NavInputsDownDuration [21]f32
	NavInputsDownDurationPrev [21]f32
	InputQueueCharacters voidptr // ImVector_ImWchar
}

pub struct C.ImGuiInputTextCallbackData {
pub mut:
	EventFlag ImGuiInputTextFlags
	Flags ImGuiInputTextFlags
	UserData voidptr
	EventChar ImWchar
	EventKey ImGuiKey
	Buf voidptr // &(byte, True)
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
	SourceId ImGuiID
	SourceParentId ImGuiID
	DataFrameCount int
	DataType [33]byte
	Preview bool
	Delivery bool
}

pub struct C.ImGuiSizeCallbackData {
pub mut:
	UserData voidptr
	Pos ImVec2
	CurrentSize ImVec2
	DesiredSize ImVec2
}

pub struct C.ImGuiStorage {
pub mut:
	Data voidptr // ImVector_ImGuiStoragePair
}

pub union StoragePairValue {
	val_i int
	val_f f32
	val_p voidptr
}

pub struct C.ImGuiStoragePair {
pub mut:
	key ImGuiID
	value StoragePairValue
}

pub struct C.ImGuiStyle {
pub mut:
	Alpha f32
	WindowPadding ImVec2
	WindowRounding f32
	WindowBorderSize f32
	WindowMinSize ImVec2
	WindowTitleAlign ImVec2
	WindowMenuButtonPosition ImGuiDir
	ChildRounding f32
	ChildBorderSize f32
	PopupRounding f32
	PopupBorderSize f32
	FramePadding ImVec2
	FrameRounding f32
	FrameBorderSize f32
	ItemSpacing ImVec2
	ItemInnerSpacing ImVec2
	TouchExtraPadding ImVec2
	IndentSpacing f32
	ColumnsMinSpacing f32
	ScrollbarSize f32
	ScrollbarRounding f32
	GrabMinSize f32
	GrabRounding f32
	TabRounding f32
	TabBorderSize f32
	ColorButtonPosition ImGuiDir
	ButtonTextAlign ImVec2
	SelectableTextAlign ImVec2
	DisplayWindowPadding ImVec2
	DisplaySafeAreaPadding ImVec2
	MouseCursorScale f32
	AntiAliasedLines bool
	AntiAliasedFill bool
	CurveTessellationTol f32
	Colors [49]ImVec4
}

pub struct C.ImGuiTextBuffer {
pub mut:
	Buf voidptr // ImVector_char
}

pub struct C.ImGuiTextFilter {
pub mut:
	InputBuf [256]byte
	Filters voidptr // ImVector_ImGuiTextRange
	CountGrep int
}

pub struct C.ImGuiTextRange {
pub mut:
	b byteptr
	e byteptr
}