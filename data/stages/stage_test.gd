extends StageScript

@onready var enemy_fairy : PackedScene = preload("res://data/enemies/enemy_lesser_fairy.tscn")
@onready var bullet_circle : PackedScene = preload("res://data/bullets/bullet_test.tscn")

@onready var movement_script_1 : GDScript = preload("res://data/movement/movement_test.gd")
@onready var movement_script_2 : GDScript = preload("res://data/movement/movement_test_2.gd")

@onready var title_card : PackedScene = preload("res://data/title_cards/title_card_test.tscn")
@onready var next_script : GDScript = preload("res://data/stages/stage_test_2.gd")

var cd1 : float = 3.0
var count1 : int = 10
var cd1_loop : float = 0.0
var cd1_count_loop : int = 0

var cd2 : float = 0.0

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
	cd2 -= delta
	
	if count1 <= 0:
		cd1_loop = 0.0
		count1 = 10
		cd1 += 5.0
		cd1_count_loop += 1
	if cd1 <= 0:
		cd1_loop -= delta
		while cd1_loop <= 0 and count1 > 0:
			var enemy = spawn_enemy(enemy_fairy, Vector2(randi_range(200,500), -100))
			if cd1_count_loop % 2 == 1:
				enemy.add_movement_script(movement_script_2)
			else:
				enemy.add_movement_script(movement_script_1)
			count1 -= 1
			cd1_loop += 0.2
	if cd2 <= 0:
		var bullet = spawn_bullet(bullet_circle)
		bullet.position.x = cos(time_elapsed * 2) * 50 + 700
		bullet.position.y = -50
		bullet.velocity.y = 200
		cd2 += 0.1
