/// @description Insert description here
// You can write your code in this editor

arrow_dis_from_player += 0.5
if (arrow_dis_from_player >= 30) arrow_dis_from_player = 20
if player != noone {
	
	var arrow_x = player.x + lengthdir_x(arrow_dis_from_player, dir)
	var arrow_y = player.y + lengthdir_y(arrow_dis_from_player, dir)
	draw_sprite_ext(sAimArrow, 0,arrow_x, arrow_y, 1, 1, dir, player.color, 1)
}
draw_self()


