extends SpellCard

func _ready() -> void:
	super()
	start_section()

func _physics_process(delta: float) -> void:
	super(delta)

func end_condition() -> bool:
	return get_time_left() < 35.0
	#return time_active >= duration

func start_section():
	super()
	spell_name = "SPC_TEST"
	total_bonus = 10000000
	duration = 40.0
	count_capture = 0
	count_attempt = 0
	update_displayer()
