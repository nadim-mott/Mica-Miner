/// @description Insert description here
// You can write your code in this editor

if player == noone {
	// Inherit the parent event
	image_index = 0
	event_inherited();
	player_is_ghost = false
} else {
	vertical_speed = 0
	horizontal_speed = 0
	player_is_ghost = (player.drill == noone)
	if player.input_medium == "keyboard" {
		dir =  point_direction(player.x,player.y, mouse_x, mouse_y)
	} else if player.input_joystick_v != 0 and player.input_joystick_h != 0 {
		dir = point_direction(0,0, player.input_joystick_h, player.input_joystick_v)
	}
	if (!player_is_ghost or sprite_index == sDead) image_index = 1 //if not ghost
	var dis_from_player = -16
	x = player.x + lengthdir_x(dis_from_player, dir)
	y = player.y + lengthdir_y(dis_from_player, dir)
	player.image_xscale = sign(player.x - x)
	image_xscale = -1 * player.image_xscale
	
	//dropping:
	if player.input_dig and !place_meeting(x,y, oWall) {
		player.input_dig = false
		thrown = true
		if (player.drill != noone) {
			instance_activate_object(player.drill)
			
		}
		//todo prevent the drill from teleporting
		player.grabbed = noone
		horizontal_speed = lengthdir_x(throwing_strength, dir)
		vertical_speed = lengthdir_y(throwing_strength,dir)
		player = noone
	} else if !place_meeting(x,y, oWall){
		with (player) {
			if grabbed != noone {
				if input_grab {
					input_grab = false
					if (drill != noone) instance_activate_object(drill)
					grabbed.player = noone
					grabbed.horizontal_speed = horizontal_speed
					grabbed.vertical_speed = vertical_speed
					grabbed = noone
		
				}
			}
			
		}
		
	}
}
// ----- interact with liquid: ------ 
if place_meeting(x,y,oWater) and !player_is_ghost {
	layer_add_instance("grabbable_underwater", id)
	
	
} else {
	layer_add_instance("grabbables", id)
}