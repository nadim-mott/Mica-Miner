var previous_hall = current_hall
current_hall = halls[hall_x, hall_y]
if current_hall != previous_hall {
	with current_hall {
		activate_all_entities()
	}
	with previous_hall {
		deactive_all_entities()
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
			x = other.current_hall.x + 0.5 * room_width
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
		if travel_dir == 1 {
			with(oPlayer) {
				y = other.current_hall.y + 0.5 * room_height
				x = other.current_hall.xx
			}
		} else {
			with(oPlayer) {
				y = other.current_hall.y + 0.5 * room_height
				x = other.current_hall.x
			}
		}
	}
}