if hit_cooldown > 0 {
	hit_cooldown -= 1
	sprite_index = hurt_sprite
} else {
	sprite_index = default_sprite
}
if health_point <= 0 {
	var possible_sprites = [sEnemybit1, sEnemybit2, sEnemybit3]
	var random_dir =irandom_range(0, 360)
	create_entity(x,y,oRoomTracker.current_hall,oGrabbable,"grabbables", {
		vertical_speed: lengthdir_y(10, random_dir),
		horizontal_speed: lengthdir_y(10, random_dir),
		sprite_index : possible_sprites[irandom(2)]
	})
	instance_destroy()
}

// ----- interact with liquid: ------ 
if place_meeting(x,y,oWater) {
	layer_add_instance("enemy_underwater", id)
	
	
} else {
	layer_add_instance("enemies", id)
}