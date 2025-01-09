/// @description Insert description here
// You can write your code in this editor

if global.debug_mode_is_on and variable_instance_exists(id,"origin") and mouse_touching {
	draw_circle(origin[0],origin[1],16, false)
}