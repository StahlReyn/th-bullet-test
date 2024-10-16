class_name StageHandler
extends Node

var stage_data : StageData = preload("res://data/stages/test_stage/test_stage.tres")

var cur_stage_script : StageScript

func _ready() -> void:
	add_stage_script_from_data(stage_data) # This is temporary test

func _process(delta: float) -> void:
	check_finished_sections()

func add_stage_script_from_data(data : StageData) -> Node:
	var inst : StageScript = StageScript.new_stage_script_from_data(data)
	add_child(inst)
	cur_stage_script = inst
	print("Add Script Sequence")
	return inst

func check_finished_sections() -> void:
	for node1 in get_children():
		if node1 is StageScript: # Go through each Stage Script
			for node in node1.get_children(): # Stage script contains sections
				if node is SpellCard:
					if node.is_ending():
						var displayer : SpellCardDisplayer = GameUtils.get_spell_card_displayer()
						displayer.end_spellcard()
				if node is SectionScript:
					if node.is_ending():
						node.call_deferred("queue_free")
			

static func current_add_stage_script(script : GDScript) -> void:
	var handler : StageHandler = GameUtils.get_stage_handler()
	handler.add_stage_script(script)
