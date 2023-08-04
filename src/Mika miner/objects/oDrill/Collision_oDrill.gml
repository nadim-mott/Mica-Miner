// Player collisions (needs further testing
if oSettings.jump_on_drill {
	if player.input_dig {
		if other.player.input_dig {
			with (player) {
				vertical_speed = -1 * lengthdir_y(3, other.image_angle)
				horizontal_propulsion = -1 * lengthdir_x(3, other.image_angle)
				can_jump = 0
			}
		}
	}
}