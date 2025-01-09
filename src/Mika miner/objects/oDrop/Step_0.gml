//Work out where to move vertically
vertical_speed = vertical_speed + vertical_acceleration

//movement
if (place_meeting(x + horizontal_speed, y, oWall)) {
	var horizontal_bounce = bounce_horizontal_strength
	if place_meeting(x + horizontal_speed, y, oBouncy) horizontal_bounce = bounce_horizontal_super
	if (abs(horizontal_speed) > bounce_threshold) {
		horizontal_speed = horizontal_speed*horizontal_bounce * -1
	}
	else {
		while (abs(horizontal_speed) > 0.1) {
			horizontal_speed *= 0.5;
			if (!place_meeting(x + horizontal_speed, y, oWall)) x += horizontal_speed;
		}
		horizontal_speed = 0;
	}
}
x += horizontal_speed;

if (place_meeting(x, y + vertical_speed, oWall)){
	var vertical_bounce = bounce_vertical_strength
	if place_meeting(x, y + vertical_speed, oBouncy) vertical_bounce = bounce_vertical_super
	if (abs(vertical_speed) > bounce_threshold) {
		vertical_speed = vertical_speed*vertical_bounce * -1
	}
	else {
		while (abs(vertical_speed) > 0.1) {
			vertical_speed *= 0.5;
			if (!place_meeting(x, y +vertical_speed, oWall)) y += vertical_speed;
		}
		vertical_speed = 0;
		horizontal_speed = 0
	}
}
y += vertical_speed;

if vertical_speed != 0  {
	image_angle += abs(vertical_speed) * sign(horizontal_speed)* -1
	if (image_number == 3) image_index = 2
} else {
	image_angle = 0
	thrown = false
}
//----- Room transitions: -----
if variable_instance_exists(id, "hall") {
	if x > hall.xx {
		if !is_array(oRoomTracker.hall_entities[hall.x_coord + 1,hall.y_coord]) {
			oRoomTracker.hall_entities[hall.x_coord + 1,hall.y_coord] = array_create(0)
		}
		array_remove_value(oRoomTracker.hall_entities[hall.x_coord,hall.y_coord],self.id)
		array_push(oRoomTracker.hall_entities[hall.x_coord + 1,hall.y_coord],self.id)
		instance_deactivate_object(self.id)
	} else if x < hall.x {
		if (hall.x_coord - 1 < 0) instance_destroy()
		if !is_array(oRoomTracker.hall_entities[hall.x_coord - 1,hall.y_coord]) {
			oRoomTracker.hall_entities[hall.x_coord - 1,hall.y_coord] = array_create(0)
		}
		array_remove_value(oRoomTracker.hall_entities[hall.x_coord,hall.y_coord],self.id)
		array_push(oRoomTracker.hall_entities[hall.x_coord - 1,hall.y_coord],self.id)
		instance_deactivate_object(self.id)
	} else if y > hall.yy {
		if !is_array(oRoomTracker.hall_entities[hall.x_coord,hall.y_coord + 1]) {
			oRoomTracker.hall_entities[hall.x_coord,hall.y_coord + 1] = array_create(0)
		}
		array_remove_value(oRoomTracker.hall_entities[hall.x_coord,hall.y_coord],self.id)
		array_push(oRoomTracker.hall_entities[hall.x_coord,hall.y_coord + 1],self.id)
		instance_deactivate_object(self.id)
	}
}
if place_meeting(x,y,oWater) {
	if in_water = false {
		if place_meeting(x,y,oLava) {
			instance_create_layer(x,y - 10, "drill", oSplash, {sprite_index: sSplashLava})
		} else {
			instance_create_layer(x,y - 10, "drill", oSplash)
		}
		
	}
	vertical_acceleration = underwater_vertical_acceleration
	in_water = true
	bounce_threshold = bounce_threshold_underwater

	
	
} else {
	vertical_acceleration = vertical_acceleration_default
	in_water = false
	bounce_threshold = bounce_threshold_default
}
