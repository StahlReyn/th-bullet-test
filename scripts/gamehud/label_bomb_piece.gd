extends Label

func _process(delta: float) -> void:
	text = GameVariables.get_bomb_piece_display()
