// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_entity(x,y,hall, grabbable, layer = "grabbables", struct = {}){
	var hall_x = hall.x_coord
	var hall_y = hall.y_coord
	struct.hall = hall
	array_push(oRoomTracker.hall_entities[hall_x,hall_y], instance_create_layer(x,y, layer, grabbable, struct))
}