if sprite_index == sPlayerStand {
	draw_sprite_ext(sPlayerStandVest, image_index,x,y,image_xscale,image_yscale,image_angle,color,1)
} else if sprite_index == sPlayerWalk {
	draw_sprite_ext(sPlayerWalkVest, image_index,x,y,image_xscale,image_yscale,image_angle,color,1)
}

draw_self()