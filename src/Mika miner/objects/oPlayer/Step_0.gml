// Find controls:
var is_gamepad = is_numeric(input_medium)
switch (input_medium) {
	case "keyboard":
		var input_left = keyboard_check(ord("A"));
		var input_right = keyboard_check(ord("D"));
		var input_down = keyboard_check(ord("S"));
		var input_up = keyboard_check(ord("W"));
		var input_jump = keyboard_check_pressed(vk_space);
		var input_jump_held = keyboard_check(vk_space)
		input_grab = keyboard_check_pressed(ord("Q"))
		input_dig = mouse_check_button(mb_left);
		input_joystick_h = 0
		input_joystick_v = 0
	break;
	default: 
		input_left = gamepad_button_check(input_medium, gp_padl) or (-0.5 > gamepad_axis_value(input_medium, gp_axislh));
		input_right = gamepad_button_check(input_medium, gp_padr) or (0.5 < gamepad_axis_value(input_medium, gp_axislh));
		input_down = gamepad_button_check(input_medium, gp_padd);
		input_up = gamepad_button_check(input_medium, gp_padu);
		input_jump = gamepad_button_check_pressed(input_medium, gp_face1) or gamepad_button_check_pressed(input_medium, gp_shoulderr);
		input_jump_held = gamepad_button_check(input_medium, gp_face1) or gamepad_button_check(input_medium, gp_shoulderr);
		input_grab = gamepad_button_check_pressed(input_medium, gp_face2)
		input_dig = gamepad_button_check(input_medium, gp_shoulderlb);
		input_joystick_h = gamepad_axis_value(input_medium, gp_axisrh)* (0.1 < abs(gamepad_axis_value(input_medium, gp_axisrh)))
		input_joystick_v = gamepad_axis_value(input_medium, gp_axisrv)* (0.1 < abs(gamepad_axis_value(input_medium, gp_axisrv)))
	break;
}

// Work out where to move horizontally
if (input_right - input_left + hitting_direction) != 0 {
	horizontal_speed = walk_speed * (input_right - input_left + hitting_direction)
	horizontal_propulsion = 0
} else {
	horizontal_speed = horizontal_propulsion
	sprite_index = sPlayerStand
} 
if (input_right - input_left) != 0 {
	image_xscale = sign(input_right - input_left)
	sprite_index = sPlayerWalk
}
	

if hit_cooldown > 0 {
	hit_cooldown -= 1
}

//Work out where to move vertically
vertical_speed = vertical_speed + vertical_acceleration

//work out if we should jump
if (can_jump -- > 0) and (input_jump){
	vertical_speed = -1 * jump_strength
	can_jump = 0
	jumped = true
}
if (!input_jump_held and jumped) {
	vertical_speed = max(0, vertical_speed)
	jumped = false
}


//Collide and Move
if (place_meeting(x + horizontal_speed, y, oWall)) {
	if (horizontal_speed > 0) {
		horizontal_propulsion = 0
	}
	while (abs(horizontal_speed) > 0.1) {
		horizontal_speed *= 0.5;
		if (!place_meeting(x + horizontal_speed, y, oWall)) x += horizontal_speed;
	}
	horizontal_speed = 0;
}
x += horizontal_speed;

if (place_meeting(x, y + vertical_speed, oWall)){
	if (vertical_speed > 0) {
		can_jump = 10;
		horizontal_propulsion = 0
		jumped = false
	}
	while (abs(vertical_speed) > 0.1) {
		vertical_speed *= 0.5;
		if (!place_meeting(x, y +vertical_speed, oWall)) y += vertical_speed;
	}
	vertical_speed = 0;
}
y += vertical_speed;

if health_point <= 0 {
	array_remove_value(oPlayerTracker.players, id)
	array_remove_value(oPlayerTracker.pads_connected, input_medium)
	if input_medium == "keyboard" {
		oPlayerTracker.keyboard_player_added = false;
	}
	instance_destroy(drill)
	instance_destroy()
	
}

// grabbable 
if grabbed != noone {
	if input_grab {
		input_grab = false
		instance_activate_object(drill)
		grabbed.player = noone
		grabbed.horizontal_speed = horizontal_speed
		grabbed = noone
		
	}
}