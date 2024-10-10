extends StageScript

var cd1 : float = 3.0
var cd2 : float = 10.0

@onready var enemy1 : PackedScene = preload("res://scripts/enemies/enemy_test.tscn")
@onready var enemy2 : PackedScene = preload("res://scripts/enemies/enemy_test_2.tscn")
@onready var enemy_fairy : PackedScene = preload("res://scripts/enemies/enemy_lesser_fairy.tscn")

func _ready() -> void:
	super()

func _process(delta: float) -> void:
	super(delta)
	cd1 -= delta
	cd2 -= delta
	if cd1 <= 0:
		for i in 5:
			var enemy = spawn_enemy(enemy_fairy, Vector2(randi_range(200,600), -100))
			enemy.velocity = Vector2(randi_range(-100,100), randi_range(50,200))
		cd1 += 5.0
	if cd2 <= 0:
		for i in 20:
			var enemy = spawn_enemy(enemy_fairy, Vector2(randi_range(100,700), -100))
			enemy.velocity = Vector2(randi_range(-100,100), randi_range(100,300))
		cd2 += 25.0
