/// @description Insert description here
// You can write your code in this editor


if hit_cooldown <=0 {
	health_point -= 1
	hit_cooldown = hit_cooldown_max
	vertical_speed = -2
	if (health_point != 0) {
		audio_play_sound(sndGrunt,10,false,,,random_range(0.9,1.2))
	}else {
		audio_play_sound(sndRichardDying,10,false,,,random_range(0.9,1.2))
	}
}
can_jump = 10



