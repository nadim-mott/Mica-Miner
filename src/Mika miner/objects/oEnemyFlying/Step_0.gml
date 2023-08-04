//if !instance_exists(target) {
//	target = noone
//	if array_length(oPlayerTracker.players) != 1 {
//		target = array_select_random(oPlayerTracker.players)
//	} 
//}
//if active {
//	if target != noone {
//		var target_direction = point_direction(x,y,target.x,target.y)
//		hspd = lengthdir_x(spd, target_direction) + knockback_x
//		vspd = lengthdir_y(spd, target_direction) + knockback_y
//		x += hspd
//		y += vspd
//	}
	
//	if knockback_count > 0 {
//		knockback_count -= 1
//	} else {
//		knockback_x = 0
//		knockback_y = 0
//	}
//	//if target == noone and instance_exists(oPlayer){
//	//	target = oPlayer.id
//	//}
//}

if current_phase == PHASE.CHILLING {
	// Decide if you should stay in chilling phase:
	if distance_to_object(oPlayer) < activation_distance {
		current_phase = PHASE.ATTACKING
		target = instance_nearest(x,y, oPlayer)
	} else if target = noone or (abs(target[0] - x) < 5 and abs(target[1] - y) < 5){
		timer -= 1 
		// hall bounds
		if (timer <=0) {
			timer = 60
			var distance_target = 100
			target = [clamp(irandom_range(x - distance_target, x + distance_target), hall_x_min, hall_x_max), clamp(irandom_range(y - distance_target, y + distance_target), hall_y_min, hall_y_max)]
		}
	} else {
		get_to_point(target[0],target[1])
	}
} else if current_phase == PHASE.ATTACKING {
	if !instance_exists(target) {
		current_phase = PHASE.CHILLING
		target = noone
	} else {
		get_to_point(target.x, target.y)
	}
}
if knockback_count > 0 {
		knockback_count -= 1
	} else {
		knockback_x = 0
		knockback_y = 0
	}
event_inherited();