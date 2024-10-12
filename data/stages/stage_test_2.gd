extends StageScript

var cd1 : float = 3.0
var cd_script : float = 20.0

@onready var enemy_fairy : PackedScene = preload("res://data/enemies/enemy_lesser_fairy.tscn")

func _ready() -> void:
	super()

func _process(delta: float) -> void:
	super(delta)
	cd1 -= delta
	if cd1 <= 0:
		for i in 3:
			var enemy = spawn_enemy(enemy_fairy, Vector2(300, -100))
			enemy.velocity = Vector2(randi_range(-50,50), randi_range(50,150))
		cd1 += 0.1
