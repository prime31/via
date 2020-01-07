module c

pub struct C.PHYSFS_File {
	opaque voidptr
}
pub fn (f &C.PHYSFS_File) str() string { return '$&f' }

pub struct C.PHYSFS_Version {
pub:
    major byte
    minor byte
    patch byte
}
pub fn (v C.PHYSFS_Version) str() string { return '${v.major}.${v.minor}.${v.patch}' }

pub struct C.PHYSFS_ArchiveInfo {
pub:
    extension byteptr   /**< Archive file extension: "ZIP", for example. */
    description byteptr /**< Human-readable archive description. */
    author byteptr      /**< Person who did support for this archive. */
    url byteptr         /**< URL related to this archive */
    supportsSymlinks int    /**< non-zero if archive offers symbolic links. */
}
pub fn (i C.PHYSFS_ArchiveInfo) str() string { return 'ext=$i.extension, desc=$i.description, author=$i.author, url=$i.url, symlinks=$i.supportsSymlinks' }

pub struct C.PHYSFS_Allocator {
pub:
	Init fn() int
	Deinit fn()
	Malloc fn(u64) voidptr
	Realloc fn(voidptr, u64) voidptr
	Free fn(voidptr)
}

pub struct C.PHYSFS_Stat {
pub:
	filesize i64
	modtime i64
	createtime i64
	accesstime i64
	filetype PhysfsFileType
	readonly int
}
