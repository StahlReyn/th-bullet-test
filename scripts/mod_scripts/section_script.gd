class_name SectionScript
extends ModScript
## For sections in regular stage or boss non-spells
## Can be divided if there need chapter bonuses, like Touhou 15 and onwards

var duration : float = 40.0 ## Duration of section, mostly for boss spellcard + non-spell
var do_end : bool = false

func _ready() -> void:
	super()

func _process(delta: float) -> void:
	super(delta)

func start_section() -> void:
	pass

func end_section() -> void:
	print("END SECTION")
	do_end = true

func is_ending() -> bool:
	return do_end

func get_time_left() -> float:
	return duration - time_active
