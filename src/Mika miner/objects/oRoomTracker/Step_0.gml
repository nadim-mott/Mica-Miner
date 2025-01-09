var previous_hall = current_hall
current_hall = halls[hall_x, hall_y]

if current_hall != previous_hall {
	var current_hall_x = current_hall.x_coord
	var current_hall_y = current_hall.y_coord
	var previous_hall_x = previous_hall.x_coord
	var previous_hall_y = previous_hall.y_coord
	for (var i = 0; i < array_length(hall_entities[previous_hall_x,previous_hall_y]); i++) {
		instance_deactivate_object(hall_entities[previous_hall_x,previous_hall_y][i])
	}
	for (var j = 0; j < array_length(hall_entities[current_hall_x,current_hall_y]); j++) {
		var instance = hall_entities[current_hall_x,current_hall_y][j]
		instance_activate_object(instance)
		if instance_exists(instance) instance.hall = current_hall
	}
}

var current_hall_start = current_hall
oCamera.follow = current_hall //todo make this only update when the hall is updated

for (var i = 0; i < array_length(oPlayerTracker.players); i ++) {
	var player = oPlayerTracker.players[i]
	if (player.health_point <= 0) continue;
	//dropping below:
	if (player.y >= current_hall.yy) {
		dead_end_left = false
		dead_end_right = false
		dead_end_resolved = false
		var new_y = hall_y + 1
		
		halls[hall_x,new_y] = create_hall(hall_x, new_y,SIDES.UP)
		hall_y = new_y
	
		with(oPlayer) {
			x = other.current_hall.x + (other.current_hall.door_level_floor + other.current_hall.door_width_floor *0.5) * sprite_get_width(sWall)
			y = other.current_hall.yy + sprite_get_height(sPlayerStand)
			if grabbed != noone {
				with grabbed {
					if !is_array(oRoomTracker.hall_entities[hall.x_coord + 1,hall.y_coord]) {
						oRoomTracker.hall_entities[hall.x_coord + 1,hall.y_coord] = array_create(0)
					}
					array_remove_value(oRoomTracker.hall_entities[hall.x_coord,hall.y_coord],self.id)
					array_push(oRoomTracker.hall_entities[hall.x_coord + 1,hall.y_coord],self.id)	
				}
			}
		}
		with oGhostPlayer {
			x =  other.current_hall.x + (other.current_hall.door_level_floor + other.current_hall.door_width_floor *0.5) * sprite_get_width(sWall)
			y = other.current_hall.yy + sprite_get_height(sPlayerStand)
		}
		
		break;
	}
	//going sideways
	if (player.x > current_hall.xx or player.x < current_hall.x) {
		if (player.x > current_hall.xx){
			var travel_dir =  1
			var came_from = SIDES.LEFT
		} else {
			travel_dir = -1
			came_from = SIDES.RIGHT
		}
		var new_x = hall_x + travel_dir
		try {
			var ignore = halls[new_x,hall_y]
			hall_x = new_x
		}
		catch (_nothing) {
			halls[new_x,hall_y] = create_hall(new_x,hall_y, came_from)
			hall_x = new_x
		}
		if travel_dir == 1  { // right
			with(oPlayer) {
				y = other.current_hall.y + (other.current_hall.door_level_right + other.current_hall.door_height_right *0.5) * sprite_get_width(sWall)
				x = other.current_hall.xx
				if grabbed != noone {
					with grabbed {
						if !is_array(oRoomTracker.hall_entities[hall.x_coord + 1,hall.y_coord]) {
							oRoomTracker.hall_entities[hall.x_coord + 1,hall.y_coord] = array_create(0)
						}
						array_remove_value(oRoomTracker.hall_entities[hall.x_coord,hall.y_coord],self.id)
						array_push(oRoomTracker.hall_entities[hall.x_coord + 1,hall.y_coord],self.id)	
					}
				}
			}
			with oGhostPlayer {
				y = other.current_hall.y + (other.current_hall.door_level_right+ other.current_hall.door_height_right * 0.5) * sprite_get_width(sWall)
				x = other.current_hall.xx
			}
		} else {
			with(oPlayer) { // left
				y = other.current_hall.y + (other.current_hall.door_level_left + other.current_hall.door_height_left* 0.5)* sprite_get_width(sWall)
				x = other.current_hall.x
				if grabbed != noone {
					with grabbed {
						if !is_array(oRoomTracker.hall_entities[hall.x_coord - 1,hall.y_coord]) {
							oRoomTracker.hall_entities[hall.x_coord - 1,hall.y_coord] = array_create(0)
						}
						array_remove_value(oRoomTracker.hall_entities[hall.x_coord,hall.y_coord],self.id)
						array_push(oRoomTracker.hall_entities[hall.x_coord - 1,hall.y_coord],self.id)	
					}
				}
			}
			with oGhostPlayer {
				y = other.current_hall.y +( other.current_hall.door_level_left + other.current_hall.door_height_left * 0.5) * sprite_get_width(sWall)
				x = other.current_hall.x
			}
		}
	}
}
