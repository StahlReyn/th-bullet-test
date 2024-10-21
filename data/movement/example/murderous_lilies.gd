extends MovementScript
## On collide with wall, spawns a large laser
## Spawns 4 curvy lasers (stream of bullets)
## Many Circle bullets accelerating upwards (opposite) spread side

@onready var laser = BulletUtils.scene_dict["laser_basic"]
@onready var bullet = BulletUtils.scene_dict["circle_medium"]
@onready var stream = BulletUtils.scene_dict["circle_medium"]
@onready var stream_movement = preload("res://data/movement/common/movement_sine.gd")
@onready var accel_movement = preload("res://data/movement/common/acceleration_constant.gd")

@onready var blend_add = preload("res://data/canvas_material/blend_additive.tres")
@onready var hit_sound = preload("res://assets/audio/sfx/bullet_big_noisy.wav")

func _ready() -> void:
	call_deferred("setup")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setup() -> void:
	parent.connect("hit_wall", _on_hit_wall)

func _on_hit_wall() -> void:
	print("Lily Hit Wall")
	parent as Bullet
	# laser
	var cur_laser = spawn_laser(laser, parent.position)
	cur_laser.rotation = -PI/2
	cur_laser.target_size.y = 100
	cur_laser.switch_state(Laser.State.STATIC, 2.0)
	cur_laser.material = blend_add
	
	var audio_node = AudioStreamPlayer2D.new()
	audio_node.set_stream(hit_sound)
	cur_laser.add_child(audio_node)
	audio_node.play()
	# Stream
	for stream_num in range(4):
		var amp_mult = 1
		var base_velocity_x = 0
		if stream_num == 0:
			base_velocity_x = -150
		elif stream_num == 3:
			base_velocity_x = 150
		if stream_num < 2:
			amp_mult = -1
		for i in range(60):
			var cur_bullet = spawn_bullet(stream, parent.position)
			cur_bullet.delay_time = i * 0.02
			cur_bullet.material = blend_add
			var cur_script = cur_bullet.add_movement_script(stream_movement)
			cur_script.frequency.x = 3
			cur_script.amplitude.x = 200 * amp_mult
			cur_script.phase_offset.x = PI/2
			cur_script.base_velocity = Vector2(base_velocity_x, -500)
	# Spray
	for i in range(40):
		var cur_bullet = spawn_bullet(stream, parent.position)
		cur_bullet.delay_time = i * 0.02
		cur_bullet.material = blend_add
		cur_bullet.velocity.y = randf_range(0, 100)
		cur_bullet.velocity.x = randf_range(-150, 150)
		var cur_script = cur_bullet.add_movement_script(accel_movement)
		cur_script.acceleration = Vector2(0, -150)
	# Remove self
	call_deferred("queue_free")

#@export var frequency : Vector2 = Vector2(1,1) ##rad / sec
#@export var amplitude : Vector2 = Vector2(100,100) ##(of velocity)
#@export var phase_offset : Vector2 = Vector2(0,0) ##rad
#@export var base_velocity : Vector2 = Vector2(0,0)
