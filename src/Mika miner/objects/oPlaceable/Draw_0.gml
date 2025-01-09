if global.debug_mode_is_on {
	image_alpha = 0.5
	draw_self()
	draw_set_font(fntArial)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text(x,y,descriptor)
}