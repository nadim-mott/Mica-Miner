if player.input_medium == "keyboard" {
	dir =  point_direction(x,y, mouse_x, mouse_y)
} else if player.input_joystick_v != 0 and player.input_joystick_h != 0 {
	dir = point_direction(0,0, player.input_joystick_h, player.input_joystick_v)
}
image_angle = dir
x = player.x
y = player.y
if dir % 360 > 90 and dir % 360 < 270 {
	image_yscale = -1
} else {
	image_yscale = 1
}
if player.input_dig {
	image_speed = 30
	audio_play_sound(sndBuzz,1,false,,,random_range(0.5,1))
} else {
	image_speed = 0
}

if !place_meeting(x,y,oWall) {
	player.hitting_direction = 0
}