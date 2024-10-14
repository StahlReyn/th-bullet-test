extends Label

func _process(delta: float) -> void:
	text = GameVariables.get_life_piece_display()
