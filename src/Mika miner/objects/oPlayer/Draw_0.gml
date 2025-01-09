if (hit_cooldown % 10 >= 5) and hit_cooldown != 0 {
	image_alpha = 0.2
} else {
	image_alpha = 1
}
draw_self()

switch (sprite_index){
	case sPlayerJump:
		var vest = sPlayerJumpVest
		break;
	case sPlayerWalk:
		vest = sPlayerWalkVest
		break;
	case sPlayerFall:
		vest = sPlayerFallVest
		break;
	case sPlayerHurt:
		vest = sPlayerHurtVest
		break;
	default:
		vest = sPlayerStandVest
	
}

draw_sprite_ext(vest, image_index,x,y,image_xscale,image_yscale,image_angle,color,image_alpha)