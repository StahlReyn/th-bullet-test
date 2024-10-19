class_name SectionDialogueScript
extends SectionScript
## For section where character talks
## Section ending is called from Dialogue Displayer

var dialogue_set : DialogueSet

func _ready() -> void:
	super()

func _physics_process(delta: float) -> void:
	super(delta)

func start_section() -> void:
	super()
	var displayer : DialogueDisplayer = GameUtils.get_dialogue_displayer()
	displayer.start_dialogue()

func update_displayer() -> void:
	var displayer : DialogueDisplayer = GameUtils.get_dialogue_displayer()
	displayer.set_dialogue_script(self)

func get_dialogue_set() -> DialogueSet:
	return dialogue_set

func get_dialogue_actions() -> Array[DialogueAction]:
	return get_dialogue_set().dialogue_actions

func get_dialogue_action(index : int) -> DialogueAction:
	return get_dialogue_actions()[index]

func get_dialogue_action_count() -> int:
	return len(get_dialogue_actions())
