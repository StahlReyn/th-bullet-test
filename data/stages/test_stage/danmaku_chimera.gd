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

var bullet_chimera_list : Array[Bullet] = []
var boss : Enemy
var state : int = State.IDLE
var state_timer : float = 3.0

var cd1 : float = 2.0
var shot_count_1 : int = 0

var bullet_base_speed : float = 320
var line_count : int = 16

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
	var angle_offset = (shot_count_1 % 2) * PI/16
	for i in range(10):
		var bullet_list = BulletUtils.spawn_circle(
			bullet_line,
			boss.position,
			bullet_base_speed,
			line_count,
			angle_offset,
		)
		for bullet : Bullet in bullet_list:
			bullet_chimera_list.append(bullet)
			bullet.set_color(SpriteGroupBasicBullet.ColorType.BLUE)
			bullet.delay_time = i * 0.08
			set_bullet_style(bullet)
	shot_count_1 += 1

func set_bullet_style(bullet: Entity) -> void:
	bullet.material = blend_add
	bullet.set_color(SpriteGroupBasicBullet.ColorType.BLUE)

func process_state() -> void:
	if state_timer < 0:
		match state:
			State.IDLE: 
				switch_state(State.SPAWNING, 1.0)
				spawn_bullet_line() # When switch spawn
			State.SPAWNING:
				switch_state(State.SPINNING, 4.0)
				stop_bullets()
			State.SPINNING:
				switch_state(State.SPAWNING, 1.0)
				continue_bullets()
				spawn_bullet_line()

func stop_bullets() -> void:
	print("CHIMERA - Stop Bullet")
	clean_bullet_list()
	for bullet in bullet_chimera_list:
		bullet.velocity = Vector2(0,0)

func continue_bullets() -> void:
	print("CHIMERA - Continue Bullet")
	clean_bullet_list()
	for bullet in bullet_chimera_list:
		var direction = bullet.position.direction_to(boss.position)
		bullet.velocity = -direction * bullet_base_speed

func clean_bullet_list() -> void:
	var old_list = bullet_chimera_list
	bullet_chimera_list = []
	for item in old_list:
		if is_instance_valid(item):
			bullet_chimera_list.append(item)

func switch_state(state: int, state_timer: float):
	self.state = state
	self.state_timer = state_timer
