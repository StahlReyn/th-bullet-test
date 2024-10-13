class_name StageHandler
extends Node

@export var script_stage : GDScript
var cur_script : Node

func _ready() -> void:
	cur_script = add_script(script_stage) # This is temporary test

func _process(delta: float) -> void:
	pass

func add_script(script : GDScript) -> Node:
	var inst : Node = script.new()
	add_child(inst)
	cur_script = inst
	return inst

func replace_script(script : GDScript) -> Node:
	cur_script.queue_free()
	var inst : Node = script.new()
	cur_script = inst
	add_child(inst)
	return inst
