extends SpellCard

func _ready() -> void:
	super()
	start_section()

func _physics_process(delta: float) -> void:
	super(delta)
	if get_time_left() < 35.0:
		end_section()

func start_section():
	super()
	spell_name = "[FIVE TIMES STACKER HOOOOOLY]"
	total_bonus = 10000000
	duration = 40.0
	count_capture = 0
	count_attempt = 0
	update_displayer()
