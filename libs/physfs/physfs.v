module physfs

[inline]
pub fn initialize() int {
	return C.PHYSFS_init(C.NULL)
}

[inline]
pub fn deinit() int {
	return C.PHYSFS_deinit()
}

[inline]
pub fn get_linked_version() C.PHYSFS_Version {
	version := C.PHYSFS_Version{}
	C.PHYSFS_getLinkedVersion(&version)
	return version
}

[inline]
pub fn supported_archive_types() []C.PHYSFS_ArchiveInfo {
	ptr := C.PHYSFS_supportedArchiveTypes()

	mut arr := []C.PHYSFS_ArchiveInfo{}
	unsafe {
		info_ptr_array := **C.PHYSFS_ArchiveInfo(ptr)
	}

	// iterate until we find a null element
	for i := 0; info_ptr_array[i]; i++ {
		unsafe {
			info := *C.PHYSFS_ArchiveInfo(info_ptr_array[i])
			arr << *info
		}
	}

	return arr
}

[inline]
pub fn free_list(list_var voidptr) {
	C.PHYSFS_freeList(list_var)
}

[inline]
pub fn get_dir_separator() string {
	return C.PHYSFS_getDirSeparator().str()
}

[inline]
pub fn permit_symbolic_links(allow int) {
	C.PHYSFS_permitSymbolicLinks(allow)
}

[inline]
pub fn get_base_dir() string {
	return C.PHYSFS_getBaseDir().str()
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

	mut arr := []string{}
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

	mut arr := []string{}
	string_ptr_array := **byteptr(ptr)

	mut i := 0
	for voidptr(string_ptr_array[i]) != voidptr(0) {
		arr << string_ptr_array[i].str()
		i++
	}

	return arr
}

[inline]
pub fn exists(fname string) bool {
	return C.PHYSFS_exists(fname.str) == 1
}

[inline]
pub fn exists_c(fname charptr) bool {
	return C.PHYSFS_exists(fname) == 1
}

[inline]
pub fn open_write(filename string) &C.PHYSFS_File {
	return C.PHYSFS_openWrite(filename.str)
}

[inline]
pub fn open_append(filename string) &C.PHYSFS_File {
	return C.PHYSFS_openAppend(filename.str)
}

[inline]
pub fn open_read(fname string) &C.PHYSFS_File {
	return C.PHYSFS_openRead(fname.str)
}

[inline]
pub fn close(handle &C.PHYSFS_File) int {
	return C.PHYSFS_close(handle)
}

[inline]
pub fn eof(handle &C.PHYSFS_File) int {
	return C.PHYSFS_eof(handle)
}

[inline]
pub fn tell(handle &C.PHYSFS_File) i64 {
	return C.PHYSFS_tell(handle)
}

[inline]
pub fn seek(handle &C.PHYSFS_File, pos u64) int {
	return C.PHYSFS_seek(handle, pos)
}

[inline]
pub fn file_length(handle &C.PHYSFS_File) i64 {
	return C.PHYSFS_fileLength(handle)
}

[inline]
pub fn set_buffer(handle &C.PHYSFS_File, bufsize u64) int {
	return C.PHYSFS_setBuffer(handle, bufsize)
}

[inline]
pub fn flush(handle &C.PHYSFS_File) int {
	return C.PHYSFS_flush(handle)
}

[inline]
pub fn is_init() bool {
	return C.PHYSFS_isInit() == 1
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
	return C.PHYSFS_getMountPoint(dir).str()
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
pub fn read_text(fname string) string {
	return read_text_c(charptr(fname.str))
}

pub fn read_text_c(fname charptr) string {
	buf := read_bytes_c(fname)
	str := tos(buf.data, buf.len)
	unsafe { buf.free() }
	return str
}

pub fn read_bytes(fname string) []byte {
	return read_bytes_c(charptr(fname.str))
}

pub fn read_bytes_c(fname charptr) []byte {
	fp := C.PHYSFS_openRead(fname)
	if fp == &C.PHYSFS_File(0) {
		panic('could not open file: ${tos3(fname)}')
	}
	len := fp.get_length()

	buf := []byte{len: int(len)} //make(int(len), int(len), sizeof(byte))
	fp.read_bytes(buf.data, u64(len))
	fp.close()

	return buf
}

[inline]
pub fn write_bytes(handle &C.PHYSFS_File, buffer voidptr, len u64) i64 {
	return C.PHYSFS_writeBytes(handle, buffer, len)
}

[inline]
pub fn get_last_error_code() ErrorCode {
	return C.PHYSFS_getLastErrorCode()
}

[inline]
pub fn get_error_by_code(code ErrorCode) string {
	return C.PHYSFS_getErrorByCode(code).str()
}

[inline]
pub fn get_pref_dir(org string, app string) string {
	return C.PHYSFS_getPrefDir(org.str, app.str).str()
}

[inline]
pub fn set_root(archive string, subdir string) int {
	return C.PHYSFS_setRoot(archive.str, subdir.str)
}