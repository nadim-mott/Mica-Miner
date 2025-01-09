if hit_cooldown <=0 {
	health_point -= 1
	hit_cooldown = hit_cooldown_max
	horizontal_propulsion = (sign(x - other.x) + (image_xscale*-1*(sign(x - other.x) == 0))) * other.knockback_strength
	vertical_speed = -2
	if (health_point != 0) {
		audio_play_sound(sndGrunt,10,false,,,random_range(0.9,1.2))
	}else {
		audio_play_sound(sndRichardDying,10,false,,,random_range(0.9,1.2))
	}
}