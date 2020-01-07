module physfs
import via.libs.physfs.c

const ( version = c.version )

[inline]
pub fn initialize() int {
	return C.PHYSFS_init(C.NULL)
}

[inline]
pub fn deinit() int {
	return C.PHYSFS_deinit()
}

[inline]
pub fn get_linked_version() PHYSFS_Version {
	version := PHYSFS_Version{}
	C.PHYSFS_getLinkedVersion(&version)
	return version
}

[inline]
pub fn supported_archive_types() []PHYSFS_ArchiveInfo {
	ptr := C.PHYSFS_supportedArchiveTypes()

	mut arr := []PHYSFS_ArchiveInfo
	info_ptr_array := **PHYSFS_ArchiveInfo(ptr)

	// iterate until we find a null element
	for i := 0; info_ptr_array[i]; i++ {
		info := *PHYSFS_ArchiveInfo(info_ptr_array[i])
		arr << *info
	}

	return arr
}

[inline]
pub fn free_list(list_var voidptr) {
	C.PHYSFS_freeList(list_var)
}

[inline]
pub fn get_dir_separator() string {
	return string(C.PHYSFS_getDirSeparator())
}

[inline]
pub fn permit_symbolic_links(allow int) {
	C.PHYSFS_permitSymbolicLinks(allow)
}

[inline]
pub fn get_base_dir() string {
	return string(C.PHYSFS_getBaseDir())
}

[inline]
pub fn get_write_dir() string {
	str := C.PHYSFS_getWriteDir()
	if str == C.NULL {
		return ''
	}
	return string(str)
}

[inline]
pub fn set_write_dir(newDir string) int {
	return C.PHYSFS_setWriteDir(newDir.str)
}

[inline]
pub fn get_search_path() []string {
	ptr := C.PHYSFS_getSearchPath()

	mut arr := []string
	string_ptr_array := **byteptr(ptr)

	mut i := 0
	for voidptr(string_ptr_array[i]) != voidptr(0) {
		arr << string(string_ptr_array[i])
		i++
	}

	return arr
}

[inline]
pub fn set_sane_config(organization string, app_name string, archive_ext string, include_cd_roms int, archives_first int) int {
	return C.PHYSFS_setSaneConfig(organization.str, app_name.str, archive_ext.str, include_cd_roms, archives_first)
}

[inline]
pub fn mkdir(dir_name string) int {
	return C.PHYSFS_mkdir(dir_name.str)
}

[inline]
pub fn delete(filename string) int {
	return C.PHYSFS_delete(filename.str)
}

[inline]
pub fn get_real_dir(filename string) byteptr {
	return C.PHYSFS_getRealDir(filename.str)
}

[inline]
pub fn enumerate_files(dir string) []string /* char** */ {
	ptr := C.PHYSFS_enumerateFiles(dir.str)

	mut arr := []string
	string_ptr_array := **byteptr(ptr)

	mut i := 0
	for voidptr(string_ptr_array[i]) != voidptr(0) {
		arr << string(string_ptr_array[i])
		i++
	}

	return arr
}

[inline]
pub fn exists(fname string) bool {
	return PHYSFS_exists(fname.str) == 1
}

[inline]
pub fn open_write(filename string) &PHYSFS_File {
	return C.PHYSFS_openWrite(filename.str)
}

[inline]
pub fn open_append(filename string) &PHYSFS_File {
	return C.PHYSFS_openAppend(filename.str)
}

[inline]
pub fn open_read(fname charptr) &C.PHYSFS_File {
	return PHYSFS_openRead(fname)
}

[inline]
pub fn close(handle &PHYSFS_File) int {
	return C.PHYSFS_close(handle)
}

[inline]
pub fn eof(handle &PHYSFS_File) int {
	return C.PHYSFS_eof(handle)
}

[inline]
pub fn tell(handle &PHYSFS_File) i64 {
	return C.PHYSFS_tell(handle)
}

[inline]
pub fn seek(handle &PHYSFS_File, pos u64) int {
	return C.PHYSFS_seek(handle, pos)
}

[inline]
pub fn file_length(handle &PHYSFS_File) i64 {
	return PHYSFS_fileLength(handle)
}

[inline]
pub fn set_buffer(handle &PHYSFS_File, bufsize u64) int {
	return C.PHYSFS_setBuffer(handle, bufsize)
}

[inline]
pub fn flush(handle &PHYSFS_File) int {
	return C.PHYSFS_flush(handle)
}

[inline]
pub fn is_init() int {
	return C.PHYSFS_isInit()
}

[inline]
pub fn symbolic_links_permitted() int {
	return C.PHYSFS_symbolicLinksPermitted()
}

[inline]
pub fn mount(new_dir string, mount_point string, append_to_path bool) bool {
	append := if append_to_path { 1 } else { 0 }
	return C.PHYSFS_mount(new_dir.str, mount_point.str, append) == 1
}

[inline]
pub fn get_mount_point(dir byteptr) string {
	return string(C.PHYSFS_getMountPoint(dir))
}

[inline]
pub fn get_search_path_callback(cb fn(voidptr, byteptr), d voidptr) {
	C.PHYSFS_getSearchPathCallback(cb, d)
}

// (*PHYSFS_EnumerateCallback)(void *data, const char *origdir, const char *fname)
[inline]
pub fn enumerate(dir string, cb fn(voidptr, byteptr, byteptr) int, d voidptr) int {
	return C.PHYSFS_enumerate(dir.str, cb, d)
}

[inline]
pub fn unmount(old_dir string) bool {
	return C.PHYSFS_unmount(old_dir.str) == 1
}

[inline]
pub fn read_bytes(handle &PHYSFS_File, buffer voidptr, len u64) i64 {
	return PHYSFS_readBytes(handle, buffer, len)
}

[inline]
pub fn write_bytes(handle &PHYSFS_File, buffer voidptr, len u64) i64 {
	return C.PHYSFS_writeBytes(handle, buffer, len)
}

[inline]
pub fn get_last_error_code() c.ErrorCode {
	return C.PHYSFS_getLastErrorCode()
}

[inline]
pub fn get_error_by_code(code c.ErrorCode) string {
	return string(C.PHYSFS_getErrorByCode(code))
}

[inline]
pub fn get_pref_dir(org string, app string) string {
	return string(C.PHYSFS_getPrefDir(org.str, app.str))
}

[inline]
pub fn set_root(archive string, subdir string) int {
	return C.PHYSFS_setRoot(archive.str, subdir.str)
}