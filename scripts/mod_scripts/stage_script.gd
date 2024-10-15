class_name StageScript
extends ModScript

func switch_script(script : GDScript) -> void:
	var handler : StageHandler = GameUtils.get_stage_handler()
	handler.replace_script(script)
	print("Switch Script")

func add_script(script : GDScript) -> void:
	var handler : StageHandler = GameUtils.get_stage_handler()
	handler.add_script(script)
	print("Switch Script")
