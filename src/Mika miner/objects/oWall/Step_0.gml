if cool_down > 0 {
	cool_down -= 1
}

if room==rmMenu and instance_exists(oMenu) {
	vspeed = oMenu.wall_speed
	if y < -64 {
		instance_destroy()
	}
}