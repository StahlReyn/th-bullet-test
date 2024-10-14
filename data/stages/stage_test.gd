extends StageScript

@onready var enemy_fairy : PackedScene = preload("res://data/enemies/enemy_lesser_fairy.tscn")
@onready var bullet_circle : PackedScene = preload("res://data/bullets/bullet_test.tscn")

@onready var movement_script_1 : GDScript = preload("res://data/movement/movement_test.gd")
@onready var movement_script_2 : GDScript = preload("res://data/movement/movement_test_2.gd")
@onready var movement_script_3 : GDScript = preload("res://data/movement/movement_test_3.gd")
@onready var movement_script_4 : GDScript = preload("res://data/movement/movement_test_4.gd")

@onready var title_card : PackedScene = preload("res://data/title_cards/title_card_test.tscn")
@onready var next_script : GDScript = preload("res://data/stages/stage_test_2.gd")

var cd1 : float = 3.0
var count1 : int = 10
var cd1_loop : float = 0.0
var cd1_count_loop : int = 0

var cd2 : float = 0.0
var cd_big : float = 0.0
var cd_count : int = 0

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
	cd_big -= delta
	cd_big -= delta
	
	if count1 <= 0:
		cd1_loop = 0.0
		count1 = 10
		cd1 += 5.0
		cd1_count_loop += 1
	if cd1 <= 0:
		cd1_loop -= delta
		while cd1_loop <= 0 and count1 > 0:
			var enemy = spawn_enemy(enemy_fairy, Vector2(randi_range(150,400), -100))
			if cd1_count_loop % 3 == 2:
				enemy.add_movement_script(movement_script_1)
				enemy.main_sprite.set_type(SpriteGroupFairy.Type.YELLOW)
			elif cd1_count_loop % 3 == 1:
				enemy.add_movement_script(movement_script_2)
				enemy.main_sprite.set_type(SpriteGroupFairy.Type.RED)
			else:
				enemy.add_movement_script(movement_script_1)
				enemy.main_sprite.set_type(SpriteGroupFairy.Type.GREEN)
			count1 -= 1
			cd1_loop += 0.2
	if cd2 <= 0:
		var bullet1 = spawn_bullet(bullet_circle)
		bullet1.position.x = cos(time_elapsed * 2) * 50 + 700
		bullet1.position.y = -50
		bullet1.velocity.y = 200
		var bullet2 = spawn_bullet(bullet_circle)
		bullet2.position.x = -cos(time_elapsed * 2) * 50 + 50
		bullet2.position.y = -50
		bullet2.velocity.y = 200
		cd2 += 0.1
	if cd_big <= 0:
		print("BIG FAIRY ", cd_count)
		if cd_count % 2 == 0:
			var enemy = spawn_enemy(enemy_fairy, Vector2(400, -100))
			enemy.add_movement_script(movement_script_3)
			enemy.main_sprite.set_type(SpriteGroupFairy.Type.BLUE)
		else:
			var positions = [
				Vector2(200, -100), 
				Vector2(600, -100)
			]
			for pos in positions:
				var enemy = spawn_enemy(enemy_fairy, pos)
				enemy.add_movement_script(movement_script_4)
				enemy.main_sprite.set_type(SpriteGroupFairy.Type.YELLOW)
		cd_big += 20
		cd_count += 1
