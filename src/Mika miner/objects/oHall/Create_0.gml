//entrances:
enum SIDES {
	UP,
	DOWN,
	LEFT,
	RIGHT
}


//room size:
var hall_width = num_horizontal_tiles * sprite_get_width(sWall)
var hall_height =  num_vertical_tiles * sprite_get_height(sWall)
	
x = x_coord * hall_width
y = y_coord * hall_height
xx = x + (num_horizontal_tiles + 1) * sprite_get_width(sWall)
yy = y + (num_vertical_tiles + 1) * sprite_get_width(sWall)
	
var curr_x = x
var curr_y = y

// ----- Spread size-----
var test_spread_chance = 1
//top entrance
//if array_contains(entrances,sides.up) {
//	var tl_right_spread = (num_horizontal_tiles/2) - 2
//	var tr_left_spread = (num_horizontal_tiles/2) - 2
//} else {
//	tl_right_spread = num_horizontal_tiles
//	tr_left_spread = num_horizontal_tiles
//}
////bottom entrance
//if array_contains(entrances,sides.down) {
//	var bl_right_spread = (num_horizontal_tiles/2) - 2
//	var br_left_spread = (num_horizontal_tiles/2) - 2
//} else {
//	bl_right_spread = num_horizontal_tiles
//	br_left_spread = num_horizontal_tiles
//}
////left entrance
//if array_contains(entrances,sides.left) {
//	var tl_down_spread = (num_vertical_tiles/2) - 2
//	var bl_up_spread = (num_vertical_tiles/2) - 2
//} else {
//	tl_down_spread = num_vertical_tiles
//	bl_up_spread = num_vertical_tiles
//}
////right entrance
//if array_contains(entrances,sides.right) {
//	var tr_down_spread = (num_vertical_tiles/2) - 2
//	var br_up_spread = (num_vertical_tiles/2) - 2
//} else {
//	tr_down_spread = num_vertical_tiles
//	br_up_spread = num_vertical_tiles
//}
var tl_right_spread = (num_horizontal_tiles/2) - 2
var tr_left_spread = (num_horizontal_tiles/2) - 2
var bl_right_spread = (num_horizontal_tiles/2) - 2
var br_left_spread = (num_horizontal_tiles/2) - 2
var tl_down_spread = (num_vertical_tiles/2) - 2
var bl_up_spread = (num_vertical_tiles/2) - 2
var tr_down_spread = (num_vertical_tiles/2) - 2
var br_up_spread = (num_vertical_tiles/2) - 2

instance_create_layer(x,y,"walls",oSpreadableWall,{
	right_spread_max: tl_right_spread,
	down_spread_max: tl_down_spread,
	spread_chance: test_spread_chance,
	hall: id
})
instance_create_layer(xx - sprite_get_width(sWall),y,"walls",oSpreadableWall,{
	left_spread_max: tr_left_spread,
	down_spread_max: tr_down_spread,
	spread_chance: test_spread_chance,
	hall: id
})
instance_create_layer(x,yy - sprite_get_width(sWall),"walls",oSpreadableWall,{
	right_spread_max: bl_right_spread,
	up_spread_max: bl_up_spread,
	spread_chance: test_spread_chance,
	hall: id
})
instance_create_layer(xx - sprite_get_width(sWall), yy-sprite_get_width(sWall),"walls",oSpreadableWall,{
	left_spread_max: br_left_spread,
	up_spread_max: br_up_spread,
	spread_chance: test_spread_chance,
	hall: id
})


//add ceilings and floors
for(var i = 0; i <= num_horizontal_tiles; i++) {
	if (i < (num_horizontal_tiles/2) - 2 or i > (num_horizontal_tiles/2) + 2 or !array_contains(entrances,SIDES.UP)){
		//ceilings
		instance_create_layer(curr_x, y,"walls", oSpreadableWall, {
			down_spread_max: min(tr_down_spread, tl_down_spread),
			spread_chance: test_spread_chance,
			hall : id})
	} else {
		instance_create_layer(curr_x, y - sprite_get_width(sWall),"walls", oWall, {hall : id})
	}
	if (i < (num_horizontal_tiles/2) - 2 or i > (num_horizontal_tiles/2) + 2 or !array_contains(entrances,SIDES.DOWN)){
		//floors
		instance_create_layer(curr_x, y + hall_height, "walls", oSpreadableWall, {
			up_spread_max: min(bl_up_spread, br_up_spread),
			spread_chance: test_spread_chance,
			bouncy_chance: 0.4,
			hall : id})
	} else {
		instance_create_layer(curr_x, y + hall_height,"walls", oBreakableWall, {hall : id})
	}
		
		
	curr_x += sprite_get_width(sWall)
}
for(var j = 0; j <= num_vertical_tiles; j++) {
	if (j < (num_vertical_tiles/2) - 2 or j > (num_vertical_tiles/2) + 2 or !array_contains(entrances,SIDES.LEFT)){
		//left wall
		instance_create_layer(x, curr_y,"walls", oSpreadableWall, {
			right_spread_max: min(tl_right_spread, bl_right_spread),
			spread_chance: test_spread_chance,
			hall : id})
	} else if came_from != SIDES.LEFT{
		instance_create_layer(x, curr_y,"walls", oBreakableWall, {hall : id})
	}
	if (j < (num_vertical_tiles/2) - 2 or j > (num_vertical_tiles/2) + 2 or !array_contains(entrances,SIDES.RIGHT)){
		//right wall
		instance_create_layer(x + hall_width, curr_y , "walls", oSpreadableWall, {
			left_spread_max: min(tr_left_spread, br_left_spread),
			spread_chance: test_spread_chance,
			hall : id})
	} else if came_from != SIDES.RIGHT{
		instance_create_layer(x + hall_width, curr_y , "walls", oBreakableWall, {hall : id})
	}
		
	curr_y += sprite_get_height(sWall)
}

//----- Add placeables -----:
//horizontal loop:
hall_entities = array_create(0)

var curr_x_placeable = x
for (var hor = 0; hor <= num_horizontal_tiles; hor++) {
	//vertical loop:
	var curr_y_placeable = y
	for (var vert = 0; vert <= num_vertical_tiles; vert ++) {
		instance_create_layer(curr_x_placeable, curr_y_placeable, "meta", oPlaceable, {hall: id})
		curr_y_placeable += sprite_get_height(sWall)
	}
	curr_x_placeable += sprite_get_width(sWall)
}
function deactive_all_entities() {
	for (var i = 0; i < array_length(hall_entities); i++) {
		instance_deactivate_object(hall_entities[i])
	}
}
function activate_all_entities() {
	for (var j = 0; j < array_length(hall_entities); j++) {
		instance_activate_object(hall_entities[j])
	}
}
