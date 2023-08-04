function create_hall(hallx, hally, came_from = noone, additional_struct = {}) {
	var struct = additional_struct //is this mutating??
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
	var outputhall = instance_create_layer(x,y,"walls",oHall, struct)
	return outputhall
}

dead_end_left = false
dead_end_right = false
dead_end_resolved = false

halls[0,0] = create_hall(0,0)
current_hall = halls[0,0]


hall_x = 0
hall_y = 0
