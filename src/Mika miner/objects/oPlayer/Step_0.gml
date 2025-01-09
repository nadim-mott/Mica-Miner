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
		if mouse_check_button_pressed(mb_left) {
			input_dig = true
		} else if mouse_check_button_released(mb_left){
			input_dig = false
		}

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
		if gamepad_button_check_pressed(input_medium, gp_shoulderlb) {
			input_dig = true
		} else if gamepad_button_check_released(input_medium, gp_shoulderlb){
			input_dig = false
		}
		input_joystick_h = gamepad_axis_value(input_medium, gp_axisrh) * (0.05 < abs(gamepad_axis_value(input_medium, gp_axisrh)))
		input_joystick_v = gamepad_axis_value(input_medium, gp_axisrv) * (0.05 < abs(gamepad_axis_value(input_medium, gp_axisrv)))
	break;
}

// Work out where to move horizontally
if (input_right - input_left + hitting_direction) != 0 {
	horizontal_speed = walk_speed * (input_right - input_left + hitting_direction)
	horizontal_propulsion = 0
} else {
	horizontal_speed = horizontal_propulsion
} 

// figure out sprite
if (input_right - input_left) != 0{
	if grabbed == noone {
		image_xscale = sign(input_right - input_left)
	}
	if can_jump == 10 {
		sprite_index = sPlayerWalk
	}
}
if hit_cooldown != 0 {
	sprite_index = sPlayerHurt
} else if vertical_speed < 0 and jumped{
	sprite_index = sPlayerJump
} else if vertical_speed != 0{
	sprite_index = sPlayerFall
} else {
	sprite_index = sPlayerStand
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
	if (abs(horizontal_speed) > 0) {
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


// ---- Dying and taking damage: -----
if health_point <= 0 {
	//array_remove_value(oPlayerTracker.players, id)
	//array_remove_value(oPlayerTracker.pads_connected, input_medium)
	//if input_medium == "keyboard" {
	//	oPlayerTracker.keyboard_player_added = false;
	//}
	create_entity(x,y, oRoomTracker.current_hall, oDead,"grabbables", {
		vertical_speed: -5,
		horizontal_speed: image_xscale * -5,
		color: color,
		hall: oRoomTracker.current_hall
	})
	array_push(oPlayerTracker.dead_players, instance_create_layer(x,y,"players", oGhostPlayer, {
		color : color,
		input_medium : input_medium
	}))
	instance_destroy(drill)
	instance_deactivate_object(self)
	
}

// ----- interact with liquid: ------ 
if place_meeting(x,y,oWater) {
	if in_water = false {
		if place_meeting(x,y,oLava) {
			instance_create_layer(x,y, "drill", oSplash, {sprite_index: sSplashLava})
		} else {
			instance_create_layer(x,y, "drill", oSplash)
		}
		
	}
	walk_speed = 3
	jump_strength = 3
	vertical_acceleration = 0.05
	in_water = true
	can_jump = 10
	layer_add_instance("players_underwater", id)
	layer_add_instance("drill_underwater", drill)
	if (input_down - input_up) != 0{
		vertical_speed = (input_down - input_up) * walk_speed
		underwater_move_manually = true
	}
	if underwater_move_manually and (input_down - input_up) == 0 {
		vertical_speed = max(0, vertical_speed)
		underwater_move_manually = false
	}
	
	
} else {
	walk_speed = walk_speed_default
	jump_strength = jump_strength_default
	vertical_acceleration = vertical_acceleration_default
	in_water = false
	layer_add_instance("players", id)
	layer_add_instance("drill", drill)
}


// grabbable 
//if grabbed != noone {
//	if input_grab {
//		input_grab = false
//		instance_activate_object(drill)
//		grabbed.player = noone
//		grabbed.horizontal_speed = horizontal_speed
//		grabbed.vertical_speed = vertical_speed
//		grabbed = noone
		
//	}
//}