extends StageScript

@onready var section_1 : GDScript = preload("res://data/stages/test_stage/test_section_1.gd")
@onready var section_2 : GDScript = preload("res://data/stages/test_stage/test_section_2.gd")

@onready var spell_card_1 : GDScript = preload("res://data/stages/test_stage/test_spellcard.gd")

@onready var title_card : PackedScene = preload("res://data/title_cards/title_card_test.tscn")

var cd1 : float = 3.0
var count1 : int = 0

func _ready() -> void:
	super()
	#spawn_title_card(title_card, Vector2(500,300))
	add_section_script(section_1)

func _process(delta: float) -> void:
	super(delta)
	cd1 -= delta
	if cd1 < 0.0 and count1 < 2:
		add_section_script(spell_card_1)
		cd1 += 10
		count1 += 1
