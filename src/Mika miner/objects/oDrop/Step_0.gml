//Work out where to move vertically
vertical_speed = vertical_speed + vertical_acceleration

//movement
if (place_meeting(x + horizontal_speed, y, oWall)) {
	if (horizontal_speed > 0) {
		horizontal_propulsion = 0
	}
	while (abs(horizontal_speed) > 0.1) {
		horizontal_speed *= 0.5;
		if (!place_meeting(x + horizontal_speed, y, oWall)) x += horizontal_speed;
	}
	horizontal_speed = 0;
}
x += horizontal_speed;

if (place_meeting(x, y + vertical_speed, oWall)){
	if (vertical_speed > 0) {
		can_jump = 10;
		horizontal_propulsion = 0
	}
	while (abs(vertical_speed) > 0.1) {
		vertical_speed *= 0.5;
		if (!place_meeting(x, y +vertical_speed, oWall)) y += vertical_speed;
	}
	vertical_speed = 0;
	horizontal_speed = 0
}
y += vertical_speed;