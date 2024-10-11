class_name Item
extends AnimatedSprite2D

enum Type {
	POWER,
	POINT,
	POWER_BIG,
	POWER_FULL,
	LIFE,
	BOMB,
}

static var item_scene : PackedScene = preload("res://scripts/items/item.tscn")
static var audio_collect : AudioStream = preload("res://assets/audio/sfx/click_collect.wav")
static var audio_collect_big : AudioStream = preload("res://assets/audio/sfx/item_get.wav")

static var max_speed : float = 200
static var down_speed : float = -100
static var down_accel : float = 200

static var magnet_range_squared : float = 40000
static var collect_range_squared : float = 360
static var collect_line_y : float = 300
static var magnet_speed : float = 1000

var type : int = Type.POINT
var spawn_velocity : Vector2
var spawn_time : float

var magnet_target : Node2D
var maximum_collect : bool = false
var distance_squared : float

func _ready() -> void:
	magnet_target = GameUtils.get_player(self)
	pass

func _process(delta: float) -> void:
	spawn_time -= delta
	if magnet_target:
		distance_squared = global_position.distance_squared_to(magnet_target.global_position)
	else:
		distance_squared = 100000
	if distance_squared < collect_range_squared:
		do_collect()
	elif is_magnetic():
		process_target_movement(delta)
	elif is_spawning(): # Gravity move when not spawning
		process_spawn_movement(delta)
	else:
		process_movement(delta)
	check_despawn()

func is_magnetic() -> bool:
	if not magnet_target: # Sometimes self is Nil when A lot happens
		return false
	return distance_squared < magnet_range_squared or magnet_target.position.y < collect_line_y

func is_spawning() -> bool:
	return spawn_time > 0

func process_movement(delta: float) -> void:
	down_speed += down_accel * delta
	down_speed = min(down_speed, max_speed)
	position.y += down_speed * delta

func process_spawn_movement(delta: float) -> void:
	position += spawn_velocity * delta
	
func process_target_movement(delta: float) -> void:
	var direction = magnet_target.global_position - self.global_position
	direction = direction.normalized()
	self.position += direction * magnet_speed * delta
	
func set_random_spawn_velocity(speed : float, time : float):
	self.spawn_time = randf_range(0, time)
	var direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	self.spawn_velocity = direction * speed

func set_type(type : int) -> void:
	self.type = type
	set_sprite()
	
func set_sprite() -> void:
	match type:
		Type.POWER:
			play("power")
		Type.POINT:
			play("point")
		Type.POWER_BIG:
			play("power_big")
		Type.POWER_FULL:
			play("power_full")
		Type.LIFE:
			play("life")
	
func do_collect() -> void:
	do_point_display()
	if magnet_target is Player:
		GameUtils.add_score(self, get_point_value())
		magnet_target.add_power(get_power_value())
	call_deferred("queue_free")

func do_point_display() -> void:
	var item_display : ItemCollectDisplay = ItemCollectDisplay.item_scene.instantiate()
	var effect_container : EffectContainer = GameUtils.get_effect_container(self)
	item_display.top_level = true
	if magnet_target:
		item_display.global_position = magnet_target.global_position
		item_display.global_position.x -= 28
	effect_container.add_child(item_display)
	var point = get_point_value()
	if point > 0:
		item_display.set_text(str(point))
	if maximum_collect:
		item_display.set_maximum_style()

func check_despawn() -> void:
	if position.y > 1200:
		call_deferred("queue_free")

func get_point_value() -> int:
	match type:
		Type.POWER:
			return 10
		Type.POINT:
			if maximum_collect:
				return 20000
			var pos_y = GameUtils.get_player(self).position.y
			return 20000 - int(pos_y * 10) # Further Up (Lower Y), higher point
		Type.POWER_BIG:
			return 100
		Type.POWER_FULL:
			return 1000
	return 0

func get_power_value() -> int:
	match type:
		Type.POWER:
			return 1
		Type.POWER_BIG:
			return 100
		Type.POWER_FULL:
			return 500
	return 0
