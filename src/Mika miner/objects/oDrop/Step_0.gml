//Work out where to move vertically
vertical_speed = vertical_speed + vertical_acceleration

//movement
if (place_meeting(x + horizontal_speed, y, oWall)) {
	var horizontal_bounce = 0.4
	if place_meeting(x + horizontal_speed, y, oBouncy) horizontal_bounce = 0.8
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
	var vertical_bounce = 0.2
	if place_meeting(x, y + vertical_speed, oBouncy) vertical_bounce = 0.5
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