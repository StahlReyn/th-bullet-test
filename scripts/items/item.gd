class_name Item
extends Area2D

enum Type {
	POWER,
	POINT,
	POWER_BIG,
	POWER_FULL,
	LIFE,
	BOMB,
}

@onready var sprite_node : AnimatedSprite2D = $AnimatedSprite2D

static var item_scene : PackedScene = preload("res://scripts/items/item.tscn")

var type : int = Type.POINT

var max_speed : float = 200
var down_speed : float = -100
var down_accel : float = 200

var spawn_velocity : Vector2
var spawn_time : float

var magnet_speed : float = 1000
var magnet_target : Node2D
var maximum_collect : bool = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	spawn_time -= delta
	if magnet_target:
		process_target_movement(delta)
	elif spawn_time > 0: # Gravity move when not spawning
		process_spawn_movement(delta)
	else:
		process_movement(delta)
	check_despawn()

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
			sprite_node.play("power")
		Type.POINT:
			sprite_node.play("point")
		Type.POWER_BIG:
			sprite_node.play("power_big")
		Type.POWER_FULL:
			sprite_node.play("power_full")
		Type.LIFE:
			sprite_node.play("life")
	
func do_collect() -> void:
	var item_display : ItemCollectDisplay = ItemCollectDisplay.item_scene.instantiate()
	var effect_container : EffectContainer = GameUtils.get_effect_container(self)
	item_display.top_level = true
	item_display.global_position = self.global_position
	effect_container.add_child(item_display)
	var point = get_point_value()
	if point > 0:
		item_display.set_text(str(point))
	if maximum_collect:
		item_display.set_maximum_style()
	call_deferred("queue_free")

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
