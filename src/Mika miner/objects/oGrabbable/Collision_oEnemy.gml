if horizontal_speed > 2 or vertical_speed > 2 {
	with (other) {
		respond_to_knockback(arctan2(other.vertical_speed, other.horizontal_speed))
	}
}

