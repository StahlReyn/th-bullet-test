extends Label

func _process(delta: float) -> void:
	text = GameVariables.get_point_value_display()
