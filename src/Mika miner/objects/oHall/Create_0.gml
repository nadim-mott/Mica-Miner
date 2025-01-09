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
xx = x + (num_horizontal_tiles) * sprite_get_width(sWall)
yy = y + (num_vertical_tiles) * sprite_get_width(sWall)
	
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
if !array_contains(entrances, SIDES.LEFT) {
	door_height_left = 0
	
}
if !array_contains(entrances, SIDES.RIGHT) {
	door_height_right = 0
	
}
if !array_contains(entrances, SIDES.UP) {
	door_width_ceiling = 0
	
}
if !array_contains(entrances, SIDES.DOWN) {
	door_width_floor = 0
	
}


if does_spread {
	var tl_right_spread = door_level_ceiling - 1
	var tr_left_spread = num_horizontal_tiles - door_level_ceiling - door_width_ceiling - 1
	var bl_right_spread = door_level_floor - 1
	var br_left_spread = num_horizontal_tiles - door_level_floor - door_width_floor - 1
	var tl_down_spread = door_level_left -1
	var bl_up_spread = num_vertical_tiles - door_level_left - door_height_left - 1
	var tr_down_spread = door_level_right -1
	var br_up_spread = num_vertical_tiles - door_level_right - door_height_right - 1 
} else {
	var tl_right_spread = 0
	var tr_left_spread = 0
	var bl_right_spread = 0
	var br_left_spread = 0
	var tl_down_spread = 0
	var bl_up_spread = 0
	var tr_down_spread = 0
	var br_up_spread = 0
	
}



instance_create_layer(x,y,"walls",oSpreadableWall,{
	right_spread_max: tl_right_spread,
	down_spread_max: tl_down_spread,
	spread_chance: test_spread_chance,
	hall: id
})
instance_create_layer(xx,y,"walls",oSpreadableWall,{
	left_spread_max: tr_left_spread,
	down_spread_max: tr_down_spread,
	spread_chance: test_spread_chance,
	hall: id
})
instance_create_layer(x,yy,"walls",oSpreadableWall,{
	right_spread_max: bl_right_spread,
	up_spread_max: bl_up_spread,
	spread_chance: test_spread_chance,
	hall: id
})
instance_create_layer(xx , yy,"walls",oSpreadableWall,{
	left_spread_max: br_left_spread,
	up_spread_max: br_up_spread,
	spread_chance: test_spread_chance,
	hall: id
})


//add ceilings and floors
for(var i = 0; i <= num_horizontal_tiles; i++) {
	if (i < door_level_ceiling or i > door_level_ceiling + door_width_ceiling or !array_contains(entrances,SIDES.UP)){
		//ceilings
		instance_create_layer(curr_x, y - sprite_get_width(sWall) * ceiling_collapsed,"walls", oSpreadableWall, {
			down_spread_max: (tr_down_spread * (i > door_level_ceiling + door_width_ceiling) + tl_down_spread * (i < door_level_ceiling)) * !ceiling_collapsed,
			spread_chance: test_spread_chance,
			hall : id})
	} else {
		instance_create_layer(curr_x, y - sprite_get_width(sWall),"walls", oWall, {hall : id})
	}
	if (i < door_level_floor or i > door_level_floor + door_width_floor or !array_contains(entrances,SIDES.DOWN)){
		//floors
		if liquid == noone {
			instance_create_layer(curr_x, y + hall_height, "walls", oSpreadableWall, {
				up_spread_max: bl_up_spread * (i < door_level_floor) + br_up_spread * (i > door_level_floor + door_width_floor),
				spread_chance: test_spread_chance,
				bouncy_chance: 0.4,
				hall : id})
		} else {
			instance_create_layer(curr_x, y + hall_height, "walls", oSpreadableWall, {
				up_spread_max: min(bl_up_spread, br_up_spread),
				spread_chance: test_spread_chance,
				bouncy_chance: 0,
				breakable_chance: 0,
				hall : id})
			
		}
	} else {
		instance_create_layer(curr_x, y + hall_height,"walls", oBreakableWall, {hall : id})
	}
		
		
	curr_x += sprite_get_width(sWall)
}
for(var j = 0; j <= num_vertical_tiles; j++) {
	if (j < door_level_left or j > door_level_left + door_height_left or !array_contains(entrances,SIDES.LEFT)){
		//left wall
		instance_create_layer(x, curr_y,"walls", oSpreadableWall, {
			right_spread_max: tl_right_spread * (j < door_level_left) + bl_right_spread * (j > door_level_left + door_height_left),
			spread_chance: test_spread_chance,
			hall : id})
	} else if came_from != SIDES.LEFT{
		instance_create_layer(x, curr_y,"walls", oBreakableWall, {hall : id})
	}
	if (j < door_level_right or j > door_level_right + door_height_right or !array_contains(entrances,SIDES.RIGHT)){
		//right wall
		instance_create_layer(x + hall_width, curr_y , "walls", oSpreadableWall, {
			left_spread_max: tr_left_spread * (j < door_level_right) + br_left_spread * (j > door_level_right + door_height_right),
			spread_chance: test_spread_chance,
			hall : id})
	} else if came_from != SIDES.RIGHT{
		instance_create_layer(x + hall_width, curr_y , "walls", oBreakableWall, {hall : id})
	}
		
	curr_y += sprite_get_height(sWall)
}
//---- Add Platforms for lava: -----
if liquid != noone {
	lava_level = (num_vertical_tiles - 2 - max(door_height_left + door_level_left, door_level_right + door_height_right) + 1)
	lava_level_y = yy - lava_level * sprite_get_width(sLava)

	with(instance_create_layer(x- 0.5*sprite_get_width(sWall),lava_level_y,"lava", liquid)) {
		image_xscale = (other.xx - other.x) / sprite_get_width(sprite_index)
		image_yscale = (other.yy - y) / sprite_get_height(sLava)
	}
	if waterfall {
		with(instance_create_layer(x + (door_level_ceiling - 0.5)*sprite_get_width(sWall), y - 5 ,"lava", liquid)) {
		image_xscale = (other.door_width_ceiling + 1)  * sprite_get_width(sWall) / sprite_get_width(sprite_index)
		image_yscale = (other.lava_level_y + 10 - other.y) / sprite_get_height(sLava)
		}
		
	}

	if liquid == oLava {
		instance_create_layer(x+ 7*sprite_get_width(sWall) , lava_level_y, "walls", oSpreadableWall, {
			left_spread_max: 2,
			spread_chance: 1,
			right_spread_max: 2
	
		})
		instance_create_layer(x+ 14*sprite_get_width(sWall) , lava_level_y, "walls", oSpreadableWall, {
			left_spread_max: 2,
			spread_chance: 1,
			right_spread_max: 2
	
		})
		instance_create_layer(x+sprite_get_width(sWall) , lava_level_y, "walls", oSpreadableWall, {
			left_spread_max: 1,
			spread_chance: 1,
			right_spread_max: 1
	
		})
		instance_create_layer(xx-sprite_get_width(sWall), lava_level_y, "walls", oSpreadableWall, {
			left_spread_max: 1,
			spread_chance: 1,
			right_spread_max: 1
	
		})
	}
	lava_level = irandom(num_vertical_tiles - 2 - max(door_height_left + door_level_left, door_level_right + door_height_right) + 1)
} else {
	lava_level_y = yy
	
}

if shop {
	
	
	
}

//----- Add placeables -----:
//horizontal loop:
hall_entities = []


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
