/// @description Insert description here
// You can write your code in this editor
if other.input_grab and player == noone{
	other.input_grab = false
	instance_deactivate_object(other.drill)
	other.grabbed = self.id
	player = other.id 
	
}



