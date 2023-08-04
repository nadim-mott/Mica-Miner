/// @description Insert description here
// You can write your code in this editor

if other.player.input_dig {
	if breakable {
		if cool_down <= 0 {
			
			health_point -= 1
			image_index += 1
			cool_down = game_get_speed(gamespeed_fps) * 0.5
		}
		if health_point <= 0 {
			instance_destroy()	
		}
	}
	with other {
		if other.bouncy {
			knockback_player(1)
		} else {
			knockback_player(1/3)
	
		}
	}
}




