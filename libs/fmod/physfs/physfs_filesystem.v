module physfs
import via.libs.physfs
import via.libs.fmod.core as fmod


pub fn set_physfs_file_system(s &fmod.System) int {
	return s.set_file_system(physfs_open_cb, physfs_close_cb, physfs_read_cb, physfs_seek_cb, voidptr(0), voidptr(0), 2048)
}


// Physfs implemention
fn physfs_open_cb(name byteptr, filesize mut &u32, handle mut &voidptr, userdata voidptr) int {
	if name != byteptr(0) {
		fp := PHYSFS_openRead(name)
		if fp == &PHYSFS_File(0) {
			return int(fmod.Result.err_file_notfound)
		}

		*filesize = u32(PHYSFS_fileLength(fp))
		*handle = **voidptr(fp)
	}

	return int(fmod.Result.ok)
}

fn physfs_close_cb(handle voidptr, userdata voidptr) int {
	if handle == voidptr(0) {
		return int(fmod.Result.err_invalid_param)
	}

	PHYSFS_close(handle)
	return int(fmod.Result.ok)
}

fn physfs_read_cb(handle voidptr, buffer voidptr, sizebytes u32, bytesread mut &int, userdata voidptr) int {
	if handle == voidptr(0) {
		return int(fmod.Result.err_invalid_param)
	}

	if bytesread != 0 {
		*bytesread = int(PHYSFS_readBytes(handle, buffer, sizebytes))

		if *bytesread < int(sizebytes) {
			return int(fmod.Result.err_file_eof)
		}
	}

	return int(fmod.Result.ok)
}

fn physfs_seek_cb(handle voidptr, pos u32, userdata voidptr) int {
	if handle == voidptr(0) {
		return int(fmod.Result.err_invalid_param)
	}

	PHYSFS_seek(handle, u64(pos))

	return int(fmod.Result.ok)
}



// Example raw C FILE implementation
// fn C.ftell() int

fn file_open_cb(name byteptr, filesize mut &u32, handle mut &voidptr, userdata voidptr) int {
	if name != byteptr(0) {
		fp := C.fopen(name, 'rb')
		if fp == voidptr(0) {
			return int(fmod.Result.err_file_notfound)
		}

		C.fseek(fp, 0, C.SEEK_END)
		*filesize = C.ftell(fp)
		C.fseek(fp, 0, C.SEEK_SET)

		*handle = fp
	}

	return int(fmod.Result.ok)
}

fn file_close_cb(handle voidptr, userdata voidptr) int {
	if handle == voidptr(0) {
		return int(fmod.Result.err_invalid_param)
	}

	C.fclose(handle)
	return int(fmod.Result.ok)
}

fn file_read_cb(handle voidptr, buffer voidptr, sizebytes u32, bytesread mut &int, userdata voidptr) int {
	if handle == voidptr(0) {
		return int(fmod.Result.err_invalid_param)
	}

	if bytesread != 0 {
		*bytesread = C.fread(buffer, 1, sizebytes, handle)

		if *bytesread < int(sizebytes) {
			return int(fmod.Result.err_file_eof)
		}
	}

	return int(fmod.Result.ok)
}

fn file_seek_cb(handle voidptr, pos u32, userdata voidptr) int {
	if handle == voidptr(0) {
		return int(fmod.Result.err_invalid_param)
	}

	C.fseek(handle, pos, C.SEEK_SET)

	return int(fmod.Result.ok)
}
