// ---- Keep track of players: -----
players = [];
pads_connected = [];
function add_player(player_input_medium, player_color = c_white){
	var new_player = instance_create_layer(spawn_x, spawn_y, "players",oPlayer, {
		input_medium : player_input_medium,
		sprite_index : sPlayerStand,
		color: player_color
	});
	array_push(players, new_player)
	array_push(pads_connected, player_input_medium)
	oCamera.follow2 = new_player
}
heart_frame = 0