module c

pub const (
	version = 1
)

// SDL2/SDL
fn C.SDL_Init(flags u32) int
fn C.SDL_InitSubSystem(flags u32) int
fn C.SDL_QuitSubSystem(flags u32)
fn C.SDL_WasInit(flags u32) u32
fn C.SDL_Quit()

// SDL2/C.SDL_filesystem
fn C.SDL_GetBasePath() byteptr
fn C.SDL_GetPrefPath(org byteptr, app byteptr) byteptr

// SDL2/C.SDL_version
pub struct C.SDL_version {
pub:
	major byte
	minor byte
	patch byte
}

// SDL2/C.SDL_stdinc
pub enum Bool {
	no = 0
	yes = 1
}

fn C.SDL_GetVersion(ver &C.SDL_version)
fn C.SDL_GetRevision() byteptr
fn C.SDL_GetRevisionNumber() int

fn C.SDL_malloc(size u32) voidptr
fn C.SDL_calloc(nmemb u32, size u32) voidptr
fn C.SDL_realloc(mem voidptr, size u32) voidptr
fn C.SDL_free(mem voidptr)



// mostly junk methods for using SDL Renderer
fn C.SDL_RenderCopy(renderer &C.SDL_Renderer, texture voidptr, srcrect voidptr, dstrect voidptr) int
fn C.SDL_CreateWindowAndRenderer(width int, height int, window_flags u32, window &C.SDL_Window, renderer &C.SDL_Renderer) int
fn C.SDL_CreateRenderer(window &C.SDL_Window, index int, flags u32) voidptr
fn C.SDL_DestroyRenderer(renderer voidptr)
fn C.SDL_RenderGetMetalLayer(renderer voidptr) voidptr
fn C.SDL_GetRendererOutputSize(renderer voidptr, w &int, h &int) int

fn C.SDL_CreateTextureFromSurface(renderer voidptr, surface voidptr) voidptr
fn C.SDL_CreateTexture(renderer &C.SDL_Renderer, format u32, access int, w int, h int) voidptr
fn C.SDL_SetRenderTarget(renderer &C.SDL_Renderer, texture &C.SDL_Texture) int
fn C.SDL_FillRect(dst voidptr, dstrect voidptr, color u32) int
fn C.SDL_SetRenderDrawColor(renderer voidptr, r byte, g byte, b byte, a byte)
fn C.SDL_RenderPresent(renderer voidptr)
fn C.SDL_RenderClear(renderer voidptr) int
fn C.SDL_UpdateTexture(texture voidptr, rect voidptr, pixels voidptr, pitch int) int
fn C.SDL_QueryTexture(texture voidptr, format voidptr, access voidptr, w voidptr, h voidptr) int
fn C.SDL_DestroyTexture(texture voidptr)

fn C.SDL_RenderDrawRect(renderer voidptr, rect voidptr)
fn C.SDL_RenderDrawRectF(renderer voidptr, rect voidptr)
fn C.SDL_RenderFillRect(renderer voidptr, rect voidptr)
fn C.SDL_RenderFillRectF(renderer voidptr, rect voidptr)

fn C.SDL_FreeSurface(surface voidptr)

// following is wrong : C.SDL_Zero is a macro accepting an argument
fn C.SDL_zero()
fn C.SDL_LoadWAV(file byteptr, spec voidptr, audio_buf voidptr, audio_len voidptr) voidptr
fn C.SDL_FreeWAV(audio_buf voidptr)
fn C.SDL_OpenAudio(desired voidptr, obtained voidptr) int
fn C.SDL_CloseAudio()
fn C.SDL_PauseAudio(pause_on int)
