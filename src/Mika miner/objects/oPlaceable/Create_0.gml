descriptor = "none"
if place_meeting(x,y,oWall){
	instance_destroy()
} else {
	// ----- Determine where we are -----
	if place_meeting(x,y - 1,oWall) { // ceiling
		descriptor = "ceiling"
		is_ceiling = true
	}
	if place_meeting(x,y + 1, oWall) { //floor
		descriptor = "floor"
		is_floor = true
	}
	if place_meeting(x + 1, y, oWall) { //right wall
		descriptor = "right"
		is_right_wall = true
	}
	if place_meeting(x - 1, y, oWall) { //left wall
		descriptor = "left"
		is_right_wall = true
	}
	if (is_ceiling or is_floor or is_left_wall or is_right_wall) {
		is_wall = true
	}
	
	
	
	is_in_initial = hall.x_coord == 0 and hall.y_coord == 0

	if (!is_in_initial and get_nearest_player_distance(other.x,other.y) > 300) and random(1) < enemy_chance {
		
		if random(1) < enemy_jump_chance and is_floor {
			image_blend = c_blue
			var hall_x = hall.x_coord
			var hall_y = hall.y_coord
			create_entity(x,y,hall, oEnemyJump, "enemies")
		} else if random(1) < enemy_flying_chance {
			image_blend = c_blue
			var hall_x = hall.x_coord
			var hall_y = hall.y_coord
			create_entity(x,y,hall, oEnemyFlying, "enemies")
		}
		//array_push(oRoomTracker.hall_entities[hall_x,hall_y], instance_create_layer(x,y, "enemies", oEnemyFlying, {hall: hall}).id)
	}
	if (random(1) < grabbable_chance and is_floor) {
		image_blend = c_blue
		var possible_grabbables = [sBone, sPick, sSkull, sRock, sRock, sRock]
		create_entity(x,y,hall, oGrabbable,"grabbables", {
			sprite_index : possible_grabbables[irandom(array_length(possible_grabbables) - 1)]
		})
	}
}