/// @description Insert description here
// You can write your code in this editor







// Inherit the parent event
event_inherited();

function respond_to_knockback(angle, damage = 1) {
		vertical_speed = lengthdir_y(10, angle)
		horizontal_propulsion = lengthdir_x(10, angle)
		knockback_count = 2
		if hit_cooldown <= 0 {
			health_point -= damage
			hit_cooldown = hit_cooldown_max
		}
}