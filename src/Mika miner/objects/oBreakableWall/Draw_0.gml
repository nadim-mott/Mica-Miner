var random_offsety = 0
var random_offsetx = 0
if cool_down > 0 {
	random_offsetx = random(5)
	random_offsety = random(5)
	draw_sprite(sBreakableWall,image_index,x+random_offsetx,y+random_offsety)
} else {
	event_inherited()
}


