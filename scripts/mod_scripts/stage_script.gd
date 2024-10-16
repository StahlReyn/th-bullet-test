class_name StageScript
extends ModScript
## StageScripts manages a list of Sections and Spellcards

var section_sequence : SectionSequence
var section_count : int = 0
var added_section_list : Array[SectionScript] = []

func _ready() -> void:
	super()
	do_next_script()

static func new_stage_script_from_sequence(section_sequence : SectionSequence) -> StageScript:
	var inst : StageScript = new()
	inst.section_sequence = section_sequence
	print("New StageScript from Sequence")
	return inst

func add_section_script(script: GDScript) -> SectionScript:
	var section : SectionScript = script.new()
	add_child(section)
	added_section_list.push_front(section)
	section.set_stage_parent(self)
	print("Add Section Script")
	return section

func is_section_available() -> bool:
	for section in added_section_list:
		if section.is_ending():
			continue
		return false # If ANY is not ending, meaning some ongoing, meaning false
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
	return section_sequence.section_list
