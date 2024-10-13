extends MovementScript

@onready var bullet_circle : PackedScene = preload("res://data/bullets/bullet_test.tscn")

var player : Player
var cd_shoot : float
var cd_delay : float
var elapsed_time : float = 0.0
var down_velocity = 450

func _ready() -> void:
	player = GameUtils.get_player()
	cd_shoot = 2.0
	call_deferred("set_hp", 100)

func set_hp(value : int):
	if parent is Enemy:
		parent.mhp = value
		parent.reset_hp()

func process_movement(delta: float) -> void:
	elapsed_time += delta
	cd_shoot -= delta
	cd_delay -= delta
	
	parent.velocity.y = down_velocity
	down_velocity -= 180 * delta
	
	if cd_shoot <= 0:
		bullet_pattern1(16, 1, PI/4)
		bullet_pattern1(16, -1, 3*PI/4)
		cd_shoot += 0.02

func bullet_pattern1(speed, scale, offset):
	var angle = sin(elapsed_time * speed) * scale + offset
	var direction = Vector2(cos(angle),sin(angle))
	var bullet = spawn_bullet(bullet_circle, parent.position)
	bullet.velocity = direction * 300

# bullet.global_position.direction_to(player.global_position)
