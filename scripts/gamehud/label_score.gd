extends Label

func _process(delta: float) -> void:
	text = GameVariables.get_score_display()
