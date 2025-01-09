if (horizontal_speed > 1 or vertical_speed > 1) and thrown {
	with (other) {
		respond_to_knockback(arctan2(other.vertical_speed, other.horizontal_speed), 3)
	}
}

