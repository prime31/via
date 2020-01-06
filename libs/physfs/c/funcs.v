module c

// - commented out methods are not implemented
// - some methods are not wrapped in physfs.v

fn C.PHYSFSRWOPS_openRead(fname byteptr) &C.SDL_RWops
fn C.PHYSFSRWOPS_openWrite(fname byteptr) &C.SDL_RWops
fn C.PHYSFSRWOPS_openAppend(fname byteptr) &C.SDL_RWops
fn C.PHYSFSRWOPS_makeRWops(handle C.PHYSFS_File) &C.SDL_RWops


fn C.PHYSFS_getLinkedVersion(version &C.PHYSFS_Version)
fn C.PHYSFS_init(argv0 byteptr) int
fn C.PHYSFS_deinit() int
fn C.PHYSFS_supportedArchiveTypes() voidptr
fn C.PHYSFS_freeList(list voidptr) // not in physfs.v
fn C.PHYSFS_getDirSeparator() byteptr
fn C.PHYSFS_permitSymbolicLinks(allow int)
//char **PHYSFS_getCdRomDirs(void)
fn C.PHYSFS_getBaseDir() byteptr
fn C.PHYSFS_getWriteDir() byteptr
fn C.PHYSFS_setWriteDir(newDir byteptr) int
fn C.PHYSFS_getSearchPath() voidptr
fn C.PHYSFS_setSaneConfig(organization byteptr, appName byteptr, archiveExt byteptr, includeCdRoms int, archivesFirst int) int // not in physfs.v
fn C.PHYSFS_mkdir(dirName byteptr) int // not in physfs.v
fn C.PHYSFS_delete(filename byteptr) int // not in physfs.v
fn C.PHYSFS_getRealDir(filename byteptr) byteptr // not in physfs.v
//char **PHYSFS_enumerateFiles(const char *dir)
fn C.PHYSFS_exists(fname byteptr) int
//PHYSFS_File *PHYSFS_openWrite(const char *filename)
//PHYSFS_File *PHYSFS_openAppend(const char *filename)
fn C.PHYSFS_openRead(filename byteptr) &C.PHYSFS_File
fn C.PHYSFS_close(handle &C.PHYSFS_File) int
fn C.PHYSFS_eof(handle &PHYSFS_File) int // not in physfs.v
fn C.PHYSFS_tell(handle &PHYSFS_File) i64 // not in physfs.v
fn C.PHYSFS_seek(handle &C.PHYSFS_File, pos u64) int // not in physfs.v
fn C.PHYSFS_readBytes(handle &PHYSFS_File, buffer voidptr, len u64) i64
fn C.PHYSFS_fileLength(handle &PHYSFS_File) i64
//int PHYSFS_setBuffer(PHYSFS_File *handle, PHYSFS_uint64 bufsize)
//int PHYSFS_flush(PHYSFS_File *handle)
//PHYSFS_sint16 PHYSFS_swapSLE16(PHYSFS_sint16 val)
//PHYSFS_uint16 PHYSFS_swapULE16(PHYSFS_uint16 val)
//PHYSFS_sint32 PHYSFS_swapSLE32(PHYSFS_sint32 val)
//PHYSFS_uint32 PHYSFS_swapULE32(PHYSFS_uint32 val)
//PHYSFS_sint64 PHYSFS_swapSLE64(PHYSFS_sint64 val)
//PHYSFS_uint64 PHYSFS_swapULE64(PHYSFS_uint64 val)
//PHYSFS_sint16 PHYSFS_swapSBE16(PHYSFS_sint16 val)

//PHYSFS_uint16 PHYSFS_swapUBE16(PHYSFS_uint16 val)
//PHYSFS_sint32 PHYSFS_swapSBE32(PHYSFS_sint32 val)
//PHYSFS_uint32 PHYSFS_swapUBE32(PHYSFS_uint32 val)
//PHYSFS_sint64 PHYSFS_swapSBE64(PHYSFS_sint64 val)
//PHYSFS_uint64 PHYSFS_swapUBE64(PHYSFS_uint64 val)
//int PHYSFS_readSLE16(PHYSFS_File *file, PHYSFS_sint16 *val)
//int PHYSFS_readULE16(PHYSFS_File *file, PHYSFS_uint16 *val)
//int PHYSFS_readSBE16(PHYSFS_File *file, PHYSFS_sint16 *val)
//int PHYSFS_readUBE16(PHYSFS_File *file, PHYSFS_uint16 *val)
//int PHYSFS_readSLE32(PHYSFS_File *file, PHYSFS_sint32 *val)
//int PHYSFS_readULE32(PHYSFS_File *file, PHYSFS_uint32 *val)
//int PHYSFS_readSBE32(PHYSFS_File *file, PHYSFS_sint32 *val)
//int PHYSFS_readUBE32(PHYSFS_File *file, PHYSFS_uint32 *val)
//int PHYSFS_readSLE64(PHYSFS_File *file, PHYSFS_sint64 *val)
//int PHYSFS_readULE64(PHYSFS_File *file, PHYSFS_uint64 *val)
//int PHYSFS_readSBE64(PHYSFS_File *file, PHYSFS_sint64 *val)
//int PHYSFS_readUBE64(PHYSFS_File *file, PHYSFS_uint64 *val)
//int PHYSFS_writeSLE16(PHYSFS_File *file, PHYSFS_sint16 val)
//int PHYSFS_writeULE16(PHYSFS_File *file, PHYSFS_uint16 val)
//int PHYSFS_writeSBE16(PHYSFS_File *file, PHYSFS_sint16 val)
//int PHYSFS_writeUBE16(PHYSFS_File *file, PHYSFS_uint16 val)
//int PHYSFS_writeSLE32(PHYSFS_File *file, PHYSFS_sint32 val)
//int PHYSFS_writeULE32(PHYSFS_File *file, PHYSFS_uint32 val)
//int PHYSFS_writeSBE32(PHYSFS_File *file, PHYSFS_sint32 val)
//int PHYSFS_writeUBE32(PHYSFS_File *file, PHYSFS_uint32 val)
//int PHYSFS_writeSLE64(PHYSFS_File *file, PHYSFS_sint64 val)
//int PHYSFS_writeULE64(PHYSFS_File *file, PHYSFS_uint64 val)
//int PHYSFS_writeSBE64(PHYSFS_File *file, PHYSFS_sint64 val)
//int PHYSFS_writeUBE64(PHYSFS_File *file, PHYSFS_uint64 val)

fn C.PHYSFS_isInit() int
fn C.PHYSFS_symbolicLinksPermitted() int
fn C.PHYSFS_mount(newDir byteptr, mountPoint byteptr, appendToPath int) int
fn C.PHYSFS_unmount(oldDir byteptr) int
fn C.PHYSFS_getMountPoint(dir byteptr) byteptr
fn C.PHYSFS_getSearchPathCallback(cb voidptr, d voidptr)
fn C.PHYSFS_enumerate(dir byteptr, cb voidptr, d voidptr) int