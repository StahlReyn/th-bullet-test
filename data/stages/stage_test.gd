extends StageScript

var cd1 : float = 1.0
var cd2 : float = 15.0

@onready var enemy1 : PackedScene = preload("res://scripts/character/enemy_test.tscn")
@onready var enemy2 : PackedScene = preload("res://scripts/character/enemy_test_2.tscn")

func _ready() -> void:
	super()

func _process(delta: float) -> void:
	super(delta)
	cd1 -= delta
	cd2 -= delta
	if cd1 <= 0:
		spawn_enemy(enemy1, Vector2(randi_range(100,500),randi_range(100,300)))
		cd1 += 3.0
	if cd2 <= 0:
		spawn_enemy(enemy2, Vector2(randi_range(100,500),randi_range(100,300)))
		cd2 += 15.0
