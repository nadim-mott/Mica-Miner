/// @description Insert description here
// You can write your code in this editor



// Inherit the parent event
event_inherited();

// ---- Behavior control
enum WALK_BEHAVIOR {
	WALKING,
	PAUSING	
}

switch (behavior) {
	case WALK_BEHAVIOR.WALKING:
		
	break;
	case WALK_BEHAVIOR.PAUSING:
		
	break;
	
	
}



//---- Gravity and physics: -----


if horizontal_propulsion != 0 {
	horizontal_speed = horizontal_propulsion
} else {
	horizontal_speed = traverse_speed * direction_traveling * (can_jump == 60)
}
//Work out where to move vertically
vertical_speed = vertical_speed + vertical_acceleration
image_index = 1

//work out if we should jump
if (can_jump -- > 0) {
	
	vertical_speed = -1 * jump_strength
	can_jump = 0
	jumped = true
}
//Collide and Move
if (place_meeting(x + horizontal_speed, y, oWall)) {
	if (abs(horizontal_speed) > 0) {
		horizontal_propulsion = 0
	}
	while (abs(horizontal_speed) > 0.1) {
		horizontal_speed *= 0.5;
		if (!place_meeting(x + horizontal_speed, y, oWall)) x += horizontal_speed;
	}
	horizontal_speed = 0;
	direction_traveling *= -1
}
x += horizontal_speed;

if (place_meeting(x, y + vertical_speed, oWall)){
	if (vertical_speed > 0) {
		can_jump = 10
		horizontal_propulsion = 0
		jumped = false
	}
	while (abs(vertical_speed) > 0.1) {
		vertical_speed *= 0.5;
		if (!place_meeting(x, y +vertical_speed, oWall)) y += vertical_speed;
	}
	vertical_speed = 0;
}
y += vertical_speed;





