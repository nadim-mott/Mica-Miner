for (var i = 0; i< array_length(players); i++) {
	// canva:
	var player = players[i]
	var canvas_width = sprite_get_width(sCanvas)
	var canvas_height = sprite_get_height(sCanvas)
	var canvas_x_pos = 10 * (i + 1) + i * canvas_width
	var canvas_width_center = canvas_x_pos + canvas_width / 2
	var player_scale = 3
	var player_x = canvas_width_center - (sprite_get_width(sPlayerStand) * player_scale) /2 
	var canvas_y_pos = 10
	var border = 8
	draw_sprite_ext(sCanvas, 0, canvas_x_pos, canvas_y_pos, 1, 1, 0, player.color, 1)
	draw_sprite_part_ext(sPlayerStand,0,0,0, (canvas_width - (border * 2)) / player_scale, (canvas_height - (border * 2) + 15) / player_scale,player_x, canvas_y_pos + border - 15, player_scale, player_scale, c_white, 1)
	draw_sprite_part_ext(sPlayerStandVest,0,0,0, (canvas_width - (border * 2)) / player_scale, (canvas_height - (border * 2) + 15) / player_scale,player_x, canvas_y_pos + border - 15, player_scale, player_scale, player.color, 1)
	
	//mika
	draw_set_font(fntUndo)
	var fnt_size = font_get_size(fntUndo)
	draw_text_outline(canvas_x_pos + border + 2, canvas_y_pos + canvas_height - border - 2 - fnt_size, "Mica: " + string(player.mika), c_white, c_black)
	
	// hearts:
	for (var heart = 0; heart < player.health_point_max; heart ++) {
		var heart_x = canvas_x_pos + (heart % 5) * sprite_get_width(sHeart)
		var heart_y = canvas_y_pos + canvas_height + floor(heart / 5) * sprite_get_height(sHeart)
		if heart + 1 == player.health_point {
			draw_sprite(sHeartbeat, heart_frame, heart_x, heart_y)
		} else {
			draw_sprite(sHeart, (heart >= player.health_point), heart_x, heart_y)
		}
	}
}
