module physfs

[typedef]
pub struct C.PHYSFS_File {
	opaque voidptr
}
pub fn (f &C.PHYSFS_File) str() string { return '$&f' }
pub fn (f &C.PHYSFS_File) get_length() i64 { return C.PHYSFS_fileLength(f) }
pub fn (f &C.PHYSFS_File) seek(pos u64) int { return C.PHYSFS_seek(f, pos) }
pub fn (f &C.PHYSFS_File) read_bytes(buffer voidptr, len u64) i64 { return C.PHYSFS_readBytes(f, buffer, len) }
pub fn (f &C.PHYSFS_File) close() int { return C.PHYSFS_close(f) }

[typedef]
pub struct C.PHYSFS_Version {
pub:
    major byte
    minor byte
    patch byte
}
pub fn (v C.PHYSFS_Version) str() string { return '${v.major}.${v.minor}.${v.patch}' }

[typedef]
pub struct C.PHYSFS_ArchiveInfo {
pub:
    extension byteptr   /**< Archive file extension: "ZIP", for example. */
    description byteptr /**< Human-readable archive description. */
    author byteptr      /**< Person who did support for this archive. */
    url byteptr         /**< URL related to this archive */
    supportsSymlinks int    /**< non-zero if archive offers symbolic links. */
}
pub fn (i C.PHYSFS_ArchiveInfo) str() string { return 'ext=$i.extension, desc=$i.description, author=$i.author, url=$i.url, symlinks=$i.supportsSymlinks' }

[typedef]
pub struct C.PHYSFS_Allocator {
pub:
	Init fn() int
	Deinit fn()
	Malloc fn(u64) voidptr
	Realloc fn(voidptr, u64) voidptr
	Free fn(voidptr)
}

[typedef]
pub struct C.PHYSFS_Stat {
pub:
	filesize i64
	modtime i64
	createtime i64
	accesstime i64
	filetype FileType
	readonly int
}
