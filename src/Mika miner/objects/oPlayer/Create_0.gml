can_jump = 0;
target_x_scale = 1
target_y_scale = 1;
horizontal_speed = 0;
vertical_speed = 0;
horizontal_propulsion = 0
input_joystick_h = 0
input_joystick_v = 0
input_dig = false
input_grab = false
hitting_direction = 0
jumped = false
underwater_move_manually = false
grabbed = noone
walk_speed = walk_speed_default
jump_strength = jump_strength_default
vertical_acceleration = vertical_acceleration_default
// create drill
drill = instance_create_layer(x,y, "drill", oDrill,{player: self.id})


// Voice information:


function update_drill_collisions() {
	// optimize? Maybe split into several functions
	if input_dig {
		with drill {
			other.drill_hitting_wall_horizontal = place_meeting(x, y, oWall)
			other.drill_hitting_wall_vertical = place_meeting(x, y, oWall)
		}
	
	} else {
		drill_hitting_wall_horizontal = false
		drill_hitting_wall_vertical = false
	}
}
function take_damage(){
	if hit_cooldown <=0 {
		health_point -= 1
		hit_cooldown = hit_cooldown_max
		vertical_speed = -2
	if (health_point != 0) {
		audio_play_sound(sndGrunt,10,false,,,random_range(0.9,1.2));
	}else {
		audio_play_sound(sndRichardDying,10,false,,,random_range(0.9,1.2));
	}
}
}
