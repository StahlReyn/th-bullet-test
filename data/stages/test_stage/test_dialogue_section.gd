extends SectionDialogueScript

@onready var set_1 : DialogueSet = preload("res://data/stages/test_stage/test_dialogue_set_1.tres")

func _ready() -> void:
	super()
	start_section()

func _physics_process(delta: float) -> void:
	super(delta)

func start_section():
	dialogue_set = set_1
	update_displayer()
	super()
