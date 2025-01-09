event_inherited();

enum PHASE {
	CHILLING,
	ATTACKING
}
current_phase = PHASE.CHILLING
function respond_to_knockback(angle, damage = 1) {
		knockback_y = lengthdir_y(6, angle)
		knockback_x = lengthdir_x(6, angle)
		knockback_count = 2
		if hit_cooldown <= 0 {
			health_point -= damage
			hit_cooldown = hit_cooldown_max
		}
}
function get_to_point(_x,_y) {
	var target_direction = point_direction(x,y,_x,_y)
	hspd = lengthdir_x(spd, target_direction) + knockback_x
	vspd = lengthdir_y(spd, target_direction) + knockback_y
	x += hspd
	y += vspd
	if sign(hspd) != 0 {
		image_xscale = -1 * sign(hspd)
	}
	
}
target = noone
//target = array_select_random(oPlayerTracker.players)
//if target == noone {
//	target = self.id
//}
//active = true
knockback_x = 0
knockback_y = 0
knockback_count = 0
hspd = 0
vspd = 0
timer = 0
hall_x_min = hall.x + 64
hall_x_max = hall.xx - 64
hall_y_min = hall.y + 64
hall_y_max = min(hall.yy - 64, hall.lava_level_y)