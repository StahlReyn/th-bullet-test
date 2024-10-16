class_name DialogueDisplayer
extends Node2D

var cur_dialogue_script : SectionDialogueScript
var cur_dialogue_line : DialogueLine
var cur_line : int = 0

@onready var node_balloon = $DialogueBalloon

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		if not cur_dialogue_script:
			print("No dialogue section yet")
		elif check_end_dialogue():
			end_dialogue()
		else:
			next_dialogue()

func check_end_dialogue() -> bool:
	return cur_line >= cur_dialogue_script.get_dialogue_line_count()

func next_dialogue() -> void:
	print("NEXT DIALOGUE: ", cur_line)
	cur_dialogue_line = cur_dialogue_script.get_dialogue_line(cur_line)
	cur_line += 1
	node_balloon.set_display_text(cur_dialogue_line.text)

func start_dialogue() -> void:
	reset_anim()

func end_dialogue() -> void:
	print("END DIALOG")
	cur_dialogue_script.end_section()
	cur_dialogue_script = null

func set_dialogue_script(section : SectionDialogueScript):
	cur_dialogue_script = section

func reset_anim():
	pass
