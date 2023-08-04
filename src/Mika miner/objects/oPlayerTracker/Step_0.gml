if (!keyboard_player_added and keyboard_check_pressed(vk_space)) {
	add_player("keyboard",make_color_rgb(irandom(255),irandom(255),irandom(255)))
	keyboard_player_added = true
}

for (var i = 0; i < gamepad_get_device_count(); i++) {
	if gamepad_is_connected(i) {
		if (gamepad_button_check_pressed(i, gp_face1) && !array_contains(pads_connected, i)) {
			add_player(i, make_color_rgb(irandom(255),irandom(255),irandom(255)))
		}
	}
}

spawn_x = oRoomTracker.current_hall.x + 325
spawn_y = oRoomTracker.current_hall.y + 200
heart_frame += 0.2