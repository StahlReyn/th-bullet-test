class_name StageScript
extends ModScript

var time_elapsed : float = 0.0

func _ready() -> void:
	time_elapsed = 0.0

func _process(delta: float) -> void:
	time_elapsed += delta

func switch_script(script : GDScript) -> void:
	var handler : StageHandler = GameUtils.get_stage_handler()
	handler.replace_script(script)
	print("Switch Script")
