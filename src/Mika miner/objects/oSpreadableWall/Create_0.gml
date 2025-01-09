if random(1) < bouncy_chance{
	spread_object = oBouncy
} else if random(1) < breakable_chance{
	if random(1) < mika_chance {
		spread_object = oMika
	}
	else {
		spread_object = oBreakableWall
	}
}
if left_spread_max > 0 and irandom(spread_chance) == 0 {
	instance_create_layer(x - sprite_get_width(sWall),y,"walls", spread_object,{
		left_spread_max: left_spread_max - 1,
		right_spread_max: 0,
		up_spread_max: up_spread_max,
		down_spread_max: down_spread_max,
		spread_chance: spread_chance,
		origin: [x,y],
		vspeed: vspeed
	})
}
if right_spread_max > 0 and irandom(spread_chance) == 0 {
	instance_create_layer(x + sprite_get_width(sWall),y,"walls",spread_object,{
		left_spread_max: 0,
		right_spread_max: right_spread_max - 1,
		up_spread_max: up_spread_max,
		down_spread_max: down_spread_max,
		spread_chance: spread_chance,
		origin: [x,y],
		vspeed: vspeed
	})
}
if up_spread_max > 0 and irandom(spread_chance) == 0 {
	instance_create_layer(x,y-sprite_get_width(sWall),"walls",spread_object,{
		left_spread_max: left_spread_max,
		right_spread_max: right_spread_max,
		up_spread_max: up_spread_max - 1,
		down_spread_max: 0,
		spread_chance: spread_chance,
		origin: [x,y],
		vspeed: vspeed
	})
}
if down_spread_max > 0 and irandom(spread_chance) == 0 {
	instance_create_layer(x,y+sprite_get_width(sWall),"walls",spread_object,{
		left_spread_max: left_spread_max,
		right_spread_max: right_spread_max,
		up_spread_max: 0,
		down_spread_max: down_spread_max - 1,
		spread_chance: spread_chance,
		origin: [x,y],
		vspeed: vspeed
	})
}
// write this cleaner
mouse_touching = false

