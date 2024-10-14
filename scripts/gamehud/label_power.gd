extends Label

func _process(delta: float) -> void:
	text = GameVariables.get_power_display()
