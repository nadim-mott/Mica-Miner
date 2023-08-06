if place_meeting(x,y,oWall){
	instance_destroy()
}
is_in_initial = hall.x_coord == 0 and hall.y_coord == 0
if !is_in_initial and get_nearest_player_distance(other.x,other.y) > 300 {
	image_blend = c_red
}

if (random(1) < enemy_flying_chance and !is_in_initial and get_nearest_player_distance(other.x,other.y) > 300) {
	image_blend = c_blue
	array_push(hall.hall_entities, instance_create_layer(x,y, "enemies", oEnemyFlying, {hall: hall}).id)
}

if (random(1) < enemy_flying_chance and !is_in_initial and get_nearest_player_distance(other.x,other.y) > 300) {
	image_blend = c_blue
	array_push(hall.hall_entities, instance_create_layer(x,y, "enemies", oEnemyFlying, {hall: hall}).id)
}