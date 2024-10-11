extends StageScript

var cd1 : float = 3.0
var cd2 : float = 10.0

@onready var enemy_fairy : PackedScene = preload("res://data/enemies/enemy_lesser_fairy.tscn")
@onready var title_card : PackedScene = preload("res://data/title_cards/title_card_test.tscn")

func _ready() -> void:
	spawn_title_card(title_card, Vector2(500,300))
	super()

func _process(delta: float) -> void:
	super(delta)
	cd1 -= delta
	cd2 -= delta
	title_card
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
