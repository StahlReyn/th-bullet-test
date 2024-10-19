class_name DialogueDisplayer
extends Node2D

var cur_dialogue_script : SectionDialogueScript
var cur_dialogue_action : DialogueAction
var cur_action_index : int = 0

var portrait_dict : Dictionary = {}

@onready var node_balloon = $DialogueBalloon

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("bomb"):
		next_dialogue_action_input()

func next_dialogue_action_input():
	if not cur_dialogue_script:
		print("No dialogue section yet")
	elif check_end_dialogue():
		end_dialogue()
	else:
		while true:
			next_dialogue()
			update_portrait()
			if not cur_dialogue_action.auto:
				break
					
func check_end_dialogue() -> bool:
	return cur_action_index >= cur_dialogue_script.get_dialogue_action_count()

func next_dialogue() -> void:
	print("NEXT DIALOGUE: ", cur_action_index)
	cur_dialogue_action = cur_dialogue_script.get_dialogue_action(cur_action_index)
	cur_action_index += 1
	if cur_dialogue_action is DialogueLine:
		node_balloon.set_display_text(cur_dialogue_action.text)
	else:
		node_balloon.set_display_text("")

func start_dialogue() -> void:
	reset_anim()
	next_dialogue_action_input()

func end_dialogue() -> void:
	print("END DIALOG")
	for id in portrait_dict:
		var portrait : PortraitSet = portrait_dict[id]
		portrait.set_initial_position()
	cur_dialogue_script.end_section()
	cur_dialogue_script = null
	cur_dialogue_action = null
	portrait_dict = {}

func set_dialogue_script(section : SectionDialogueScript):
	cur_dialogue_script = section

func reset_anim():
	pass

func update_portrait():
	if cur_dialogue_action is DialogueLine:
		if portrait_dict.has(cur_dialogue_action.id):
			# if no portrait, assume same and just update animation
			if cur_dialogue_action.portrait == null:
				update_portrait_anim()
			else:
				create_portrait()
		else: # If is empty create
			create_portrait()

func update_portrait_anim():
	var portrait = portrait_dict[cur_dialogue_action.id]
	DialogueLine.update_portrait_anim(portrait, cur_dialogue_action)

func create_portrait():
	if cur_dialogue_action is DialogueLine:
		var new_portrait : PortraitSet = DialogueLine.new_set_from_line(cur_dialogue_action)
		add_child(new_portrait)
		if portrait_dict.has(cur_dialogue_action.id):
			portrait_dict[cur_dialogue_action.id].queue_free()
		portrait_dict[cur_dialogue_action.id] = new_portrait
		print(portrait_dict)
