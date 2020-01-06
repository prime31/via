module core

// callbacks are manually translated

// FILE
pub type FileOpenCallback fn(name byteptr, filesize &u32, handle &voidptr, userdata voidptr) int
pub type FileCloseCallback fn(handle voidptr, userdata voidptr) int
pub type FileReadCallback fn(handle voidptr, buffer voidptr, sizebytes u32, bytesread &int, userdata voidptr) int
pub type FileSeekCallback fn(handle voidptr, pos u32, userdata voidptr) int
pub type FileAsyncreadCallback fn(info voidptr, userdata voidptr) int
pub type FileAsyncCancelCallback fn(info voidptr, userdata voidptr) int



// typedef FMOD_RESULT (F_CALL *FMOD_FILE_OPEN_CALLBACK)       (const char *name, unsigned int *filesize, void **handle, void *userdata);
// typedef FMOD_RESULT (F_CALL *FMOD_FILE_CLOSE_CALLBACK)      (void *handle, void *userdata);
// typedef FMOD_RESULT (F_CALL *FMOD_FILE_READ_CALLBACK)       (void *handle, void *buffer, unsigned int sizebytes, unsigned int *bytesread, void *userdata);
// typedef FMOD_RESULT (F_CALL *FMOD_FILE_SEEK_CALLBACK)       (void *handle, unsigned int pos, void *userdata);

// typedef FMOD_RESULT (F_CALL *FMOD_FILE_ASYNCREAD_CALLBACK)  (FMOD_ASYNCREADINFO *info, void *userdata);
// typedef FMOD_RESULT (F_CALL *FMOD_FILE_ASYNCCANCEL_CALLBACK)(FMOD_ASYNCREADINFO *info, void *userdata);