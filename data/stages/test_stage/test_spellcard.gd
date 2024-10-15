extends SpellCard


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_spellcard()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_spellcard():
	super()
	spell_name = "[FIVE TIMES STACKER HOOOOOLY]"
	total_bonus = 10000000
	duration = 40.0
	count_capture = 0
	count_attempt = 0
	update_displayer()
