if hit_cooldown > 0 {
	hit_cooldown -= 1
}
if health_point <= 0 {
	instance_destroy()
}