/// @description Insert description here
// You can write your code in this editor







// Inherit the parent event
if player == noone {
	event_inherited();
	if other.player.input_grab and image_number >= 2 { // excludes mika and other grabbables that only have 1 sprite
		other.player.input_grab = false
		other.player.grabbed = self.id
		player = other.player.id 
		instance_deactivate_object(other)
		
	} else if sprite_index == sMika and other.player.input_grab{
		with(other.player) {
			mika += 1
		}
		instance_destroy()
	}
}
