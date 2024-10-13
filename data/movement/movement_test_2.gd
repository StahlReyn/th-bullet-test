extends MovementScript

@onready var bullet_circle : PackedScene = preload("res://data/bullets/bullet_test.tscn")

var player : Player
var cd_shoot : float

func _ready() -> void:
	player = GameUtils.get_player()
	cd_shoot = 1.0

func process_movement(delta: float) -> void:
	cd_shoot -= delta
	
	parent.velocity.x = cos(parent.total_time * 3) * 300
	parent.velocity.y = sin(parent.total_time * 3) * 300 + 100
	
	if cd_shoot <= 0:
		var direction : Vector2 = Vector2.ZERO
		var max = 16
		var i = 0
		while i < max:
			direction.x = cos(TAU * i/max)
			direction.y = sin(TAU * i/max)
			var bullet = spawn_bullet(bullet_circle, parent.position)
			bullet.velocity = direction * 300
			i += 1
		cd_shoot += 2.0

# bullet.global_position.direction_to(player.global_position)
