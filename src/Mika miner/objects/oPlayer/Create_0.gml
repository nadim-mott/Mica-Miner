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
grabbed = noone
// create drill
drill = instance_create_layer(x,y, "drill", oDrill,{player: self.id})

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