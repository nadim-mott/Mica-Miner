function create_hall(hallx, hally, came_from = noone, additional_struct = {}) {
	var struct = additional_struct //is this mutating??
	
	if !is_array(hall_entities[hallx,hally]) {
		hall_entities[hallx,hally] = array_create(0)
	}
	struct.x_coord = hallx
	struct.y_coord = hally
	struct.entrances = []
	struct.came_from = came_from
	
	
	if (random(1) < down_chance) array_push(struct.entrances,SIDES.DOWN)
	if (random(1) < side_room_chance) array_push(struct.entrances,SIDES.LEFT)
	if (random(1) < side_room_chance) array_push(struct.entrances,SIDES.RIGHT)
	if (came_from != noone) array_push(struct.entrances,came_from)
	if hallx == 0 {
		struct.entrances = array_intersection(struct.entrances, [SIDES.UP,SIDES.DOWN,SIDES.RIGHT])
		dead_end_left = true
	}
	if !array_contains(struct.entrances, SIDES.LEFT) dead_end_left = true
	if !array_contains(struct.entrances, SIDES.RIGHT) dead_end_right = true
	if array_contains(struct.entrances, SIDES.DOWN) dead_end_resolved = true
	if (dead_end_left and dead_end_right and !dead_end_resolved) array_push(struct.entrances,SIDES.DOWN)
	//liquid:
	if random(1) < water_chance {
		struct.liquid = oWater
	} else if random(1) < lava_chance and !array_contains(struct.entrances, SIDES.DOWN) {
		struct.liquid = oLava
	} else{
		struct.liquid = noone
	}
	
	
	if came_from == SIDES.RIGHT {
		struct.door_level_right = halls[hallx + 1, hally].door_level_left
		struct.door_height_right = halls[hallx + 1, hally].door_height_left
	} else {
		if !variable_instance_exists(struct, "door_level_right") {
			struct.door_level_right = irandom_range(2, 6)
		}
		if !variable_instance_exists(struct, "door_height_right") {
			struct.door_height_right = irandom_range(2, 5)
		}
	}
	if came_from == SIDES.LEFT {
		struct.door_level_left = halls[hallx - 1, hally].door_level_right
		struct.door_height_left = halls[hallx - 1, hally].door_height_right
	} else {
		if !variable_instance_exists(struct, "door_level_left") {
			struct.door_level_left = irandom_range(2, 3)
		}
		if !variable_instance_exists(struct, "door_height_left") {
			struct.door_height_left = irandom_range(2, 5)
		}
	}
	if came_from == SIDES.UP {
		struct.door_level_ceiling = halls[hallx , hally - 1].door_level_floor
		struct.door_width_ceiling = halls[hallx, hally - 1].door_width_floor
		if halls[hallx,hally - 1].liquid == oWater {
			struct.liquid = oWater
			struct.waterfall = true
		}
	} else {
		if !variable_instance_exists(struct, "door_level_ceiling") {
			struct.door_level_ceiling = irandom_range(2, 14)
		}
		if !variable_instance_exists(struct, "door_width_ceiling") {
			struct.door_width_ceiling = irandom_range(2, 5)
		}
	}
	
	if !variable_instance_exists(struct, "door_level_floor") {
			struct.door_level_floor = irandom_range(2, 14)
		}
		if !variable_instance_exists(struct, "door_width_floor") {
			struct.door_width_floor = irandom_range(2, 5)
		}
	
	
	

	
	var outputhall = instance_create_layer(x,y,"walls",oHallChaos, struct)
	return outputhall
}

dead_end_left = false
dead_end_right = false
dead_end_resolved = false

hall_entities[0,0] = array_create(0)
for (var j = 0; j < 99; j++) {
	for (var u = 0; u < 99; u++) {
		hall_entities[j,u] = false
	}
	// THIS MEANS THAT THE GAME WILL NOT WORK FOR MORE THAN 99x99 ROOMS
}

halls[0,0] = create_hall(0,0,,{ceiling_collapsed : true})

current_hall = halls[0,0]


hall_x = 0
hall_y = 0
