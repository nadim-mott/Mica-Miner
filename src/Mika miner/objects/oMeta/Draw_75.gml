if global.debug_mode_is_on{
	if instance_exists(oRoomTracker){
		with oRoomTracker{
			draw_set_font(fntArial)
			draw_text(10,10,"Left side has a dead end:"+string(dead_end_left)+ ", Right side has a dead end:"+string(dead_end_right))
			draw_text(10,25,"Hall_x:"+string(hall_x)+ ", Hall_y:"+string(hall_y))
			draw_text(10,40,"Hall_entities" + string(current_hall.hall_entities))
		}
	}
}