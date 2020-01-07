module c

// - commented out methods are not implemented
// - some methods are not wrapped in physfs.v

fn C.PHYSFS_getLinkedVersion(version &C.PHYSFS_Version)
fn C.PHYSFS_init(argv0 byteptr) int
fn C.PHYSFS_deinit() int
fn C.PHYSFS_supportedArchiveTypes() voidptr
fn C.PHYSFS_freeList(list voidptr)
fn C.PHYSFS_getDirSeparator() byteptr
fn C.PHYSFS_permitSymbolicLinks(allow int)
//char **PHYSFS_getCdRomDirs(void)
fn C.PHYSFS_getBaseDir() byteptr
fn C.PHYSFS_getWriteDir() byteptr
fn C.PHYSFS_setWriteDir(newDir byteptr) int
fn C.PHYSFS_getSearchPath() voidptr /* char** */
fn C.PHYSFS_setSaneConfig(organization byteptr, appName byteptr, archiveExt byteptr, includeCdRoms int, archivesFirst int) int
fn C.PHYSFS_mkdir(dirName byteptr) int
fn C.PHYSFS_delete(filename byteptr) int
fn C.PHYSFS_getRealDir(filename byteptr) byteptr
fn C.PHYSFS_enumerateFiles(dir byteptr) voidptr /* char** */
fn C.PHYSFS_exists(fname byteptr) int
fn C.PHYSFS_openWrite(filename byteptr) &C.PHYSFS_File
fn C.PHYSFS_openAppend(filename byteptr) &C.PHYSFS_File
fn C.PHYSFS_openRead(filename byteptr) &C.PHYSFS_File
fn C.PHYSFS_close(handle &C.PHYSFS_File) int
fn C.PHYSFS_eof(handle &PHYSFS_File) int
fn C.PHYSFS_tell(handle &PHYSFS_File) i64
fn C.PHYSFS_seek(handle &C.PHYSFS_File, pos u64) int
fn C.PHYSFS_fileLength(handle &PHYSFS_File) i64
fn C.PHYSFS_setBuffer(handle &PHYSFS_File, bufsize u64) int
fn C.PHYSFS_flush(handle &PHYSFS_File) int

fn C.PHYSFS_swapSLE16(val i16) i16
fn C.PHYSFS_swapULE16(val u16) u16
fn C.PHYSFS_swapSLE32(val int) int
fn C.PHYSFS_swapULE32(val u32) u32
fn C.PHYSFS_swapSLE64(val i64) i64
fn C.PHYSFS_swapULE64(val u64) u64
fn C.PHYSFS_swapSBE16(val i16) i16
fn C.PHYSFS_swapUBE16(val u16) u16
fn C.PHYSFS_swapSBE32(val int) int
fn C.PHYSFS_swapUBE32(val u32) u32
fn C.PHYSFS_swapSBE64(val i64) i64
fn C.PHYSFS_swapUBE64(val u64) u64

fn C.PHYSFS_readSLE16(file &PHYSFS_File, val &i16) int
fn C.PHYSFS_readULE16(file &PHYSFS_File, val &u16) int
fn C.PHYSFS_readSBE16(file &PHYSFS_File, val &i16) int
fn C.PHYSFS_readUBE16(file &PHYSFS_File, val &u16) int
fn C.PHYSFS_readSLE32(file &PHYSFS_File, val &int) int
fn C.PHYSFS_readULE32(file &PHYSFS_File, val &u32) int
fn C.PHYSFS_readSBE32(file &PHYSFS_File, val &int) int
fn C.PHYSFS_readUBE32(file &PHYSFS_File, val &u32) int
fn C.PHYSFS_readSLE64(file &PHYSFS_File, val &i64) int
fn C.PHYSFS_readULE64(file &PHYSFS_File, val &u64) int
fn C.PHYSFS_readSBE64(file &PHYSFS_File, val &i64) int
fn C.PHYSFS_readUBE64(file &PHYSFS_File, val &u64) int

fn C.PHYSFS_writeSLE16(file &PHYSFS_File, val i16) int
fn C.PHYSFS_writeULE16(file &PHYSFS_File, val u16) int
fn C.PHYSFS_writeSBE16(file &PHYSFS_File, val i16) int
fn C.PHYSFS_writeUBE16(file &PHYSFS_File, val u16) int
fn C.PHYSFS_writeSLE32(file &PHYSFS_File, val int) int
fn C.PHYSFS_writeULE32(file &PHYSFS_File, val u32) int
fn C.PHYSFS_writeSBE32(file &PHYSFS_File, val int) int
fn C.PHYSFS_writeUBE32(file &PHYSFS_File, val u32) int
fn C.PHYSFS_writeSLE64(file &PHYSFS_File, val i64) int
fn C.PHYSFS_writeULE64(file &PHYSFS_File, val u64) int
fn C.PHYSFS_writeSBE64(file &PHYSFS_File, val i64) int
fn C.PHYSFS_writeUBE64(file &PHYSFS_File, val u64) int

fn C.PHYSFS_isInit() int
fn C.PHYSFS_symbolicLinksPermitted() int
fn C.PHYSFS_mount(newDir byteptr, mountPoint byteptr, appendToPath int) int
fn C.PHYSFS_getMountPoint(dir byteptr) byteptr
fn C.PHYSFS_getSearchPathCallback(cb voidptr, d voidptr)
fn C.PHYSFS_enumerateFilesCallback(dir byteptr, c voidptr, d voidptr)
fn C.PHYSFS_utf8stricmp(str1 byteptr, str2 byteptr) int
fn C.PHYSFS_utf16stricmp(str1 u16, str2 u16) int
fn C.PHYSFS_ucs4stricmp(str1 u32, str2 u32) int
fn C.PHYSFS_enumerate(dir byteptr, cb voidptr, d voidptr) int
fn C.PHYSFS_unmount(oldDir byteptr) int
fn C.PHYSFS_getAllocator() PHYSFS_Allocator
fn C.PHYSFS_stat(fname byteptr, stat &PHYSFS_Stat) int
fn C.PHYSFS_utf8FromUtf16(src u16, dst byteptr, len u64)
fn C.PHYSFS_utf8ToUtf16(src byteptr, dst &u16, len u64)
fn C.PHYSFS_readBytes(handle &PHYSFS_File, buffer voidptr, len u64) i64
fn C.PHYSFS_writeBytes(handle &PHYSFS_File, buffer voidptr, len u64) i64
fn C.PHYSFS_mountMemory(buf voidptr, len u64, del fn(voidptr), newDir byteptr, mountPoint byteptr, appendToPath int) int
fn C.PHYSFS_mountHandle(file &PHYSFS_File, newDir byteptr, mountPoint byteptr, appendToPath int) int
fn C.PHYSFS_getLastErrorCode() ErrorCode
fn C.PHYSFS_getErrorByCode(code ErrorCode) byteptr
fn C.PHYSFS_setErrorCode(code ErrorCode)
fn C.PHYSFS_getPrefDir(org byteptr, app byteptr) byteptr
fn C.PHYSFS_setRoot(archive byteptr, subdir byteptr) int