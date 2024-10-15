class_name StageHandler
extends Node

var script_stage : GDScript = preload("res://data/stages/test_stage/test_stage.gd")
var cur_stage_script : StageScript

func _ready() -> void:
	cur_stage_script = add_stage_script(script_stage) # This is temporary test

func _process(delta: float) -> void:
	pass

func add_stage_script(script : GDScript) -> Node:
	var inst : Node = script.new()
	add_child(inst)
	cur_stage_script = inst
	print("Add Script")
	return inst

static func current_add_stage_script(script : GDScript) -> void:
	var handler : StageHandler = GameUtils.get_stage_handler()
	handler.add_stage_script(script)
