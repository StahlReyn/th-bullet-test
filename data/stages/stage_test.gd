extends StageScript

@onready var enemy_fairy : PackedScene = preload("res://data/enemies/enemy_lesser_fairy.tscn")
@onready var enemy_fairy2 : PackedScene = preload("res://data/enemies/enemy_lesser_fairy_test.tscn")

@onready var movement_script_2 : GDScript = preload("res://data/movement/movement_test_2.gd")

@onready var title_card : PackedScene = preload("res://data/title_cards/title_card_test.tscn")
@onready var next_script : GDScript = preload("res://data/stages/stage_test_2.gd")



var cd1 : float = 3.0
var count1 : int = 10
var cd1_loop : float = 0.0
var cd1_count_loop : int = 0

var cd_script : float = 100.0

func _ready() -> void:
	spawn_title_card(title_card, Vector2(500,300))
	super()

func _process(delta: float) -> void:
	super(delta)

	cd_script -= delta
	if cd_script <= 0:
		switch_script(next_script)

	cd1 -= delta
	
	if count1 <= 0:
		cd1_loop = 0.0
		count1 = 10
		cd1 += 5.0
		cd1_count_loop += 1
	if cd1 <= 0:
		cd1_loop -= delta
		while cd1_loop <= 0 and count1 > 0:
			var enemy = spawn_enemy(enemy_fairy2, Vector2(randi_range(200,500), -100))
			if cd1_count_loop % 2 == 1:
				enemy.add_movement_script(movement_script_2)
			count1 -= 1
			cd1_loop += 0.2
