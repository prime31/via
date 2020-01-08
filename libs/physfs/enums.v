module physfs

pub enum EnumerateCallbackResult {
	error = -1
	stop = 0
	ok = 1
}

pub enum FileType {
	regular
	directory
	symlink
	other
}

pub enum ErrorCode {
	ok
	other_error
	out_of_memory
	not_initialized
	is_initialized
	argv0_is_null
	unsupported
	past_eof
	files_still_open
	invalid_argument
	not_mounted
	not_found
	symlink_forbidden
	no_write_dir
	open_for_reading
	open_for_writing
	not_a_file
	read_only
	corrupt
	symlink_loop
	io
	permission
	no_space
	bad_filename
	busy
	dir_not_empty
	os_error
	duplicate
	bad_password
	app_callback
}