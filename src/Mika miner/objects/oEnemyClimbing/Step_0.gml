/// @description Insert description here
// You can write your code in this editor

function respond_to_knockback(angle, damage = 1) {
	if hit_cooldown <= 0 {
		health_point -= damage
		hit_cooldown = hit_cooldown_max
	}
}






// Inherit the parent event
event_inherited();

