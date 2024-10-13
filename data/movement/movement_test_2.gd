extends MovementScript

@onready var bullet_circle : PackedScene = preload("res://data/bullets/bullet_test.tscn")

var player : Player
var cd1 : float

func _ready() -> void:
	player = GameUtils.get_player()
	cd1 = 1.0

func process_movement(delta: float) -> void:
	cd1 -= delta
	parent.velocity.x = cos(parent.total_time * 3) * 300
	parent.velocity.y = sin(parent.total_time * 3) * 300 + 100
	if cd1 <= 0:
		var direction : Vector2 = Vector2.ZERO
		var max = 32
		var i = 0
		while i < max:
			direction.x = cos(TAU * i/max)
			direction.y = sin(TAU * i/max)
			var bullet = spawn_bullet(bullet_circle, parent.position)
			bullet.velocity = direction * 300
			i += 1
		cd1 += 1.0

# bullet.global_position.direction_to(player.global_position)
