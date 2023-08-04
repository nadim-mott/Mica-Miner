if (follow2 != noone and (follow != noone)) {
	var room_strengthx = 18
	var room_strengthy = 20
	x_to = ((follow.x + (cam_width*0.5)) * room_strengthx + follow2.x) / (room_strengthx + 1)
	y_to = ((follow.y + (cam_height*0.5)) * room_strengthy + follow2.y) / (room_strengthy + 1)
} else if (follow != noone) {
	x_to = follow.x + (cam_width*0.5);
	y_to = follow.y + (cam_height*0.5);
}



x += (x_to - x) / 5
y += (y_to - y)/5


camera_set_view_pos(view_camera[0], x - (cam_width*0.5),y -(cam_height*0.5));

var default_x = oRoomTracker.current_hall.x
var difference = x - (default_x + (cam_width*0.5))

if (layer_exists("Sparkle")) {
	layer_x("Sparkle", default_x + difference * 0.8)
	layer_y("Sparkle", 0)
}

if (layer_exists("Spikes2")) {
	layer_x("Spikes2", default_x + difference * 0.8)
	layer_y("Spikes2", 0)
}
if (layer_exists("Spikes1")) {
	layer_x("Spikes1", default_x + difference * 0.5)
	layer_y("Spikes1", 0)
}