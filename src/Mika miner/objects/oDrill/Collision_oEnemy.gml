/// @description Insert description here
// You can write your code in this editor
if player.input_dig {
	knockback_player(0.8)
	with (other) {
		respond_to_knockback(other.id, other.player)
	}

}
