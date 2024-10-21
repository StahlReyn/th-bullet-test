extends MovementScript

@onready var bullet_circle : PackedScene = BulletUtils.scene_dict["circle_small_cross"]
@onready var scene_laser : PackedScene = BulletUtils.scene_dict["laser_basic"]
@onready var audio_shoot : AudioStream = preload("res://assets/audio/sfx/hit_noise_fade.wav")
@onready var script_rotation : GDScript = preload("res://data/movement/common/rotation_constant.gd")

@onready var bullet_chain : PackedScene = preload("res://data/bullets/laser/laser_curvy.tscn")

var player : Player
var audio_node : Node

var cd_shoot : float

var elapsed_time : float = 0.0
var section_time : float = 0.0

var cur_velocity : Vector2 = Vector2(0,0)
var part = 0

func _ready() -> void:
	player = GameUtils.get_player()
	call_deferred("setup_enemy")

func set_stat():
	if parent is Enemy:
		parent.mhp = 200
		parent.reset_hp()
		parent.drop_power = 0
		parent.drop_point = 15
		parent.drop_power_big = 1
		parent.drop_bomb_piece = 1

func setup_enemy():
	set_stat()
	audio_node = AudioStreamPlayer2D.new()
	audio_node.set_stream(audio_shoot)
	parent.add_child(audio_node)

func process_movement(delta: float) -> void:
	elapsed_time += delta
	section_time += delta
	cd_shoot -= delta
	
	match part:
		0:
			cur_velocity.y = 400
			check_part_cd(0.0)
			var cur_laser = spawn_laser(scene_laser, parent.global_position)
			cur_laser.set_node_follow(parent)
			var cur_script = cur_laser.add_movement_script(script_rotation)
			cur_script.rotation_speed = 1.0
			var chain_bullet = spawn_bullet(bullet_chain, parent.global_position + Vector2(0, 400))
			chain_bullet.velocity = Vector2(100,200)
		1:
			cur_velocity.y += -200 * delta
			check_part_cd(2.0)
		2:
			shoot_1()
			check_part_cd(3.0)
		3:
			cur_velocity.y += -300 * delta
			check_part_cd(10.0)
				
	parent.velocity = cur_velocity

func check_part_cd(time: float) -> void: ## How long next section last
	if section_time > time:
		part += 1
		section_time = 0.0
		print(part)

func shoot_1() -> void:
	if cd_shoot <= 0:
		bullet_pattern1(16, 1, PI/4)
		bullet_pattern1(16, -1, 3*PI/4)
		audio_node.play()
		cd_shoot = 0.02

func bullet_pattern1(speed, scale, offset) -> void:
	var angle = sin(elapsed_time * speed) * scale + offset
	var direction = Vector2(cos(angle),sin(angle))
	var bullet = spawn_bullet(bullet_circle, parent.position)
	bullet.velocity = direction * 300
	bullet.set_color(SpriteGroupBasicBullet.ColorType.BLUE, SpriteGroupBasicBullet.ColorVariant.LIGHT)

# bullet.global_position.direction_to(player.global_position)
