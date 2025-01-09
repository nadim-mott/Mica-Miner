/// @description Insert description here

// ----- Get Input: -----
switch (input_medium) {
	case "keyboard":
		var input_left = keyboard_check(ord("A"));
		var input_right = keyboard_check(ord("D"));
		var input_down = keyboard_check(ord("S"));
		var input_up = keyboard_check(ord("W")) or keyboard_check(vk_space) ;
		var input_jump = keyboard_check_pressed(vk_space);
		var input_jump_held = keyboard_check(vk_space)
		input_grab = keyboard_check_pressed(ord("Q"))
		if mouse_check_button_pressed(mb_left) {
			input_dig = true
		} else if mouse_check_button_released(mb_left){
			input_dig = false
		}

		input_joystick_h = 0
		input_joystick_v = 0
		input_joystick_move_h = 0
		input_joystick_move_v = 0
	break;
	default: 
		input_left = gamepad_button_check(input_medium, gp_padl);
		input_right = gamepad_button_check(input_medium, gp_padr);
		input_down = gamepad_button_check(input_medium, gp_padd);
		input_up = gamepad_button_check(input_medium, gp_padu) or gamepad_button_check(input_medium, gp_face1) or gamepad_button_check(input_medium, gp_shoulderr);;
		input_jump = gamepad_button_check_pressed(input_medium, gp_face1) or gamepad_button_check_pressed(input_medium, gp_shoulderr);
		input_jump_held = gamepad_button_check(input_medium, gp_face1) or gamepad_button_check(input_medium, gp_shoulderr);
		input_grab = gamepad_button_check_pressed(input_medium, gp_face2)
		if gamepad_button_check_pressed(input_medium, gp_shoulderlb) {
			input_dig = true
		} else if gamepad_button_check_released(input_medium, gp_shoulderlb){
			input_dig = false
		}
		input_joystick_move_h =  gamepad_axis_value(input_medium, gp_axislh) * (0.1 < abs(gamepad_axis_value(input_medium, gp_axislh)))
		input_joystick_move_v = gamepad_axis_value(input_medium, gp_axislv) * (0.1 < abs(gamepad_axis_value(input_medium, gp_axislv)))
		
		input_joystick_h = gamepad_axis_value(input_medium, gp_axisrh) * (0.05 < abs(gamepad_axis_value(input_medium, gp_axisrh)))
		input_joystick_v = gamepad_axis_value(input_medium, gp_axisrv) * (0.05 < abs(gamepad_axis_value(input_medium, gp_axisrv)))
	break;
}

//----- calculate movement: ----

if input_joystick_move_h != 0 or input_joystick_move_v != 0 {
	var dir = darctan2(-1 * input_joystick_move_v, input_joystick_move_h)
	horizontal_speed = lengthdir_x(spd, dir) * point_distance(0,0,input_joystick_move_v,input_joystick_move_h)
	vertical_speed = lengthdir_y(spd, dir) * point_distance(0,0,input_joystick_move_v,input_joystick_move_h)
	if (horizontal_speed != 0) image_xscale = sign(horizontal_speed)
} else if (input_up - input_down) != 0 or (input_right - input_left) != 0 {
	var dir = darctan2((input_up - input_down),(input_right - input_left))
	horizontal_speed = lengthdir_x(spd, dir)
	vertical_speed = lengthdir_y(spd, dir)
	if (horizontal_speed != 0) image_xscale = sign(horizontal_speed)
} else {
	horizontal_speed = 0
	vertical_speed = 0
}

if x + horizontal_speed < oRoomTracker.current_hall.xx and x + horizontal_speed > oRoomTracker.current_hall.x {
	x += horizontal_speed
}
if y + vertical_speed < oRoomTracker.current_hall.yy and y + vertical_speed > oRoomTracker.current_hall.y {
	y += vertical_speed
}
if grabbed != noone {
	spd = grab_spd
} else {
	spd = spd_default
}