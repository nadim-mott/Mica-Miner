// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function check_all_collisions(x_pos, y_pos, exceptions = noone){
	colliding_objects = [oWall, oPlayer]
	for (var i = 0 ; i < array_length(colliding_objects); i ++) {
		if (place_meeting_not_except(x_pos, y_pos, colliding_objects[i], exceptions)) return true
	}
	return false
}

function place_meeting_not_except(xx, yy, obj, excepts) {
	/*
		From https://www.reddit.com/r/gamemaker/comments/7529sl/adding_notme_to_place_meeting_for_a_place_meeting/
	*/
	if excepts == noone {
		return place_meeting(xx, yy, obj)
	} else {
		for(var i=0; i < instance_number(obj); i++) 
		{
		    var inst = instance_find(obj,i);
		    if !array_contains(excepts, inst.id) and (place_meeting(xx, yy, inst))
		    {return (true);}
		}
		return (false);
	}
}

function array_select_random(array){
	if array_length(array) = 0 return noone
	var selection = irandom(array_length(array)-1)
	return array[selection]
}
function array_remove_value(array, val) {
	for (var i = 0; i < array_length(array); i++) {
		if array[i] == val {
			array_delete(array, i, 1)
		}
	}
}

function get_nearest_player_distance(x, y) {
	var min_so_far = infinity
	var min_player = noone
	for (var i = 0; i < array_length(oPlayerTracker.players); i++) {
		if point_distance(oPlayerTracker.players[i].x, oPlayerTracker.players[i].y, x,y) < min_so_far {
			min_player = oPlayerTracker.players[i]
			min_so_far = point_distance(oPlayerTracker.players[i].x, oPlayerTracker.players[i].y, x,y)
		}
	}
	return min_so_far
}
function draw_text_outline(x, y, text, text_color, outline_color){ 
	var pcolor=draw_get_color();
	var outline_thickness = 4
	draw_set_color(outline_color);
	draw_text(x-outline_thickness, y, text);
	draw_text(x+outline_thickness, y, text);
	draw_text(x, y-outline_thickness, text);
	draw_text(x, y+outline_thickness, text);
 
	draw_set_color(text_color);

    draw_text(x, y, text);
	draw_set_color(pcolor)
}