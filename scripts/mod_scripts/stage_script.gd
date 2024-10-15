class_name StageScript
extends ModScript
## StageScripts manages a list of Sections and Spellcards

var section_list = []

func add_section_script(script: GDScript) -> SectionScript:
	var inst : Node = script.new()
	add_child(inst)
	section_list.push_front(inst)
	print("Add Section Script")
	return inst
