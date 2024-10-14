extends Label

func _process(delta: float) -> void:
	text = GameVariables.get_graze_display()
