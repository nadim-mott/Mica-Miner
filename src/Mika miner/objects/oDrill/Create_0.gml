dir = 0
hitting_wall = false
image_blend = player.color

function knockback_player(strength) {
	with (player) {
		vertical_speed = -1 * lengthdir_y(strength * drill_strength, other.image_angle)
		horizontal_propulsion = -1 * lengthdir_x(strength * drill_strength, other.image_angle)
		if (260 < other.image_angle and other.image_angle < 280) {
			horizontal_propulsion = 0
		}
		can_jump = 0
		hitting_direction = sign(horizontal_propulsion)
	}
	
}