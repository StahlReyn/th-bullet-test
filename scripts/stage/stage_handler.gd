class_name StageHandler
extends Node

@export var script_stage : GDScript
var script_stage_inst : Node

func _ready() -> void:
	script_stage_inst = script_stage.new()
	add_child(script_stage_inst)

func _process(delta: float) -> void:
	pass
