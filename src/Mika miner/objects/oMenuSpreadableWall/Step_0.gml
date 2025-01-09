/// @description Insert description here
// You can write your code in this editor







// Inherit the parent event
event_inherited();
if y >= -64 {
	instance_create_layer(x,y + (64 + 480),"walls",oMenuSpreadableWall,{
		left_spread_max: left_spread_max,
		right_spread_max: right_spread_max,
		up_spread_max: up_spread_max,
		down_spread_max: down_spread_max,
		spread_chance: spread_chance,
		origin: [x,y],
		vspeed: vspeed
	})
	instance_destroy()
}
