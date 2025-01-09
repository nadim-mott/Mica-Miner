if global.debug_mode_is_on {
	global.debug_mode_is_on = false
	window_set_cursor(cr_none)
} else {
	global.debug_mode_is_on = true
	window_set_cursor(cr_default)

}