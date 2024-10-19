class_name StageScript
extends ModScript
## StageScripts manages a list of Sections and Spellcards

var stage_data : StageData
var section_count : int = 0
var added_section_list : Array[SectionScript] = []

func _ready() -> void:
	super()
	do_next_script()

static func new_stage_script_from_data(stage_data : StageData) -> StageScript:
	var inst : StageScript = new()
	inst.stage_data = stage_data
	print("New StageScript from Sequence")
	return inst

func add_section_script(script: GDScript) -> SectionScript:
	var section : SectionScript = script.new()
	add_child(section)
	added_section_list.push_front(section)
	section.set_stage_parent(self)
	print("+ Add Section Script")
	return section

func is_section_available() -> bool:
	for section in added_section_list:
		if not section.can_move_next_section():
			return false # If ANY script saying to wait, wait
	return true

func on_section_end() -> void:
	do_next_script()

func do_next_script() -> void:
	print("SECTION: ", section_count)
	if section_count < len(get_section_list()):
		add_section_script(get_section_list()[section_count])
		section_count += 1
	else:
		print("Reached final in sequence")

func get_section_list() -> Array[GDScript]:
	return stage_data.section_list
