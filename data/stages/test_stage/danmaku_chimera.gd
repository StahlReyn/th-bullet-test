extends SpellCard
# Based on Nue Houjuu's spellcard "Danmaku Chimera"
# Spawn a line of line-bullet all around in circle,
# Bullet changes to circle-bullet, 
# Bullet rotates around the center/boss, swapping between left/right
# Bullet changes back to line-bullet, then continue outward trajectory
# Continue on loop 

enum State {
	IDLE,
	SPAWNING,
	SPINNING,
}

@onready var enemy_boss : PackedScene = preload("res://data/enemies/enemy_lesser_fairy_boss.tscn")

@onready var bullet_line : PackedScene = BulletUtils.scene_dict["partial_laser_small"]
@onready var bullet_circle : PackedScene = BulletUtils.scene_dict["circle_medium"]

@onready var audio_shoot : AudioStream = preload("res://assets/audio/sfx/hit_noise_fade.wav")

@onready var script_expiry : GDScript = preload("res://data/movement/common/expiry_timer.gd")
@onready var blend_add = preload("res://data/canvas_material/blend_additive.tres")

var bullet_chimera_list_1 : Array[Bullet] = [] # Two sets as one goes another direction
var bullet_chimera_list_2 : Array[Bullet] = []
var boss : Enemy
var state : int = State.IDLE
var state_timer : float = 3.0

var cd1 : float = 2.0
var shot_count_1 : int = 0

var bullet_base_speed : float = 320
var bullet_spin_speed : float = 0.4 # rad / s
var cur_spin_speed : float = 0.0
var time_rotating : float = 0.0
var line_count : int = 16
var rotation_amount : float = PI/4
var spin_time : float = 2.0
var spawn_time : float = 1.0

func _ready() -> void:
	super()
	start_section()
	switch_state(State.IDLE, 1.0)
	boss = spawn_enemy(enemy_boss, Vector2(380,400))
	boss.do_check_despawn = false
	boss.do_free_on_death = false
	boss.mhp = 1000;
	boss.reset_hp()
	boss.drop_power = 40
	boss.drop_point = 20
	boss.drop_life_piece = 1

func _physics_process(delta: float) -> void:
	super(delta)
	state_timer -= delta
	#cd1 -= delta
	process_state()
	match state:
		State.SPINNING:
			rotate_bullets(delta)

func end_condition() -> bool:
	return time_active >= duration

func end_section() -> void:
	super()
	
func start_section():
	super()
	spell_name = "Nue Sign \"Danmaku Chimera\""
	total_bonus = 25000000
	duration = 40.0
	update_displayer()

func spawn_bullet_line():
	var angle_offset = 0 # (shot_count_1 % 2) * PI/16
	for circle_i in range(10):
		var bullet_list = BulletUtils.spawn_circle(
			bullet_line,
			boss.position,
			bullet_base_speed,
			line_count,
			angle_offset,
		)
		for i in bullet_list.size():
			var bullet : Bullet = bullet_list[i]
			if circle_i % 2 == 0:
				bullet_chimera_list_1.append(bullet)
			else:
				bullet_chimera_list_2.append(bullet)
			bullet.set_color(SpriteGroupBasicBullet.ColorType.BLUE)
			bullet.delay_time = circle_i * 0.1
			set_bullet_style(bullet)
	shot_count_1 += 1

func set_bullet_style(bullet: Entity) -> void:
	bullet.despawn_padding = 500  # increase padding as rotate move offscreen far
	bullet.material = blend_add
	bullet.set_color(SpriteGroupBasicBullet.ColorType.BLUE)

func process_state() -> void:
	if state_timer < 0:
		match state:
			State.IDLE: 
				switch_state(State.SPAWNING, spawn_time)
				spawn_bullet_line() # When switch spawn
			State.SPAWNING:
				switch_state(State.SPINNING, spin_time)
				stop_bullets()
				time_rotating = 0.0
			State.SPINNING:
				switch_state(State.SPAWNING, spawn_time)
				continue_bullets()
				spawn_bullet_line()

func stop_bullets() -> void:
	print("CHIMERA - Stop Bullet")
	clean_bullet_list()

	var new_list_1 : Array[Bullet] = []
	for bullet in bullet_chimera_list_1:
		var new_bullet = ModScript.spawn_bullet(bullet_circle, bullet.position)
		new_bullet.velocity = Vector2(0,0)
		set_bullet_style(new_bullet)
		new_list_1.append(new_bullet)
		bullet.call_deferred("queue_free")
	bullet_chimera_list_1 = new_list_1
	
	var new_list_2 : Array[Bullet] = []
	for bullet in bullet_chimera_list_2:
		var new_bullet = ModScript.spawn_bullet(bullet_circle, bullet.position)
		new_bullet.velocity = Vector2(0,0)
		set_bullet_style(new_bullet)
		new_list_2.append(new_bullet)
		bullet.call_deferred("queue_free")
	bullet_chimera_list_2 = new_list_2

func rotate_bullets(delta: float) -> void:
	# print("CHIMERA - Rotate Bullet")
	clean_bullet_list()
	time_rotating += delta
	var angle_spin = sin(time_rotating * PI / spin_time) * 0.0077
	
	for bullet in bullet_chimera_list_1:
		bullet.position = rotate_around_point(bullet.position, boss.position, angle_spin)
	for bullet in bullet_chimera_list_2:
		bullet.position = rotate_around_point(bullet.position, boss.position, -angle_spin)
	
func continue_bullets() -> void:
	print("CHIMERA - Continue Bullet")
	clean_bullet_list()
	var new_list_1 : Array[Bullet] = []
	for bullet in bullet_chimera_list_1:
		var direction = bullet.position.direction_to(boss.position)
		var new_bullet = ModScript.spawn_bullet(bullet_line, bullet.position)
		new_bullet.velocity = -direction * bullet_base_speed
		set_bullet_style(new_bullet)
		new_list_1.append(new_bullet)
		bullet.call_deferred("queue_free")
	bullet_chimera_list_1 = new_list_1
	
	var new_list_2 : Array[Bullet] = []
	for bullet in bullet_chimera_list_2:
		var direction = bullet.position.direction_to(boss.position)
		var new_bullet = ModScript.spawn_bullet(bullet_line, bullet.position)
		new_bullet.velocity = -direction * bullet_base_speed
		set_bullet_style(new_bullet)
		new_list_2.append(new_bullet)
		bullet.call_deferred("queue_free")
	bullet_chimera_list_2 = new_list_2

func clean_bullet_list() -> void:
	var old_list_1 = bullet_chimera_list_1
	bullet_chimera_list_1 = []
	for item in old_list_1:
		if is_instance_valid(item):
			bullet_chimera_list_1.append(item)
	
	var old_list_2 = bullet_chimera_list_2
	bullet_chimera_list_2 = []
	for item in old_list_2:
		if is_instance_valid(item):
			bullet_chimera_list_2.append(item)

func switch_state(state: int, state_timer: float):
	self.state = state
	self.state_timer = state_timer

func rotate_around_point(point1: Vector2, point2: Vector2, angle: float) -> Vector2:
	var diff = point1 - point2
	return diff.rotated(angle) + point2


static func ease_angle(start: float, end: float, value: float) -> float:
	end -= start
	return -end * 0.5 * (cos(PI * value) - 1) + start
