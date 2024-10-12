class_name Enemy
extends Character

@export_group("Drops")
@export var drop_spawn_speed : float = 1000.0
@export var drop_spawn_time : float = 0.1
@export var drop_power : int = 0
@export var drop_point : int = 0
@export var drop_power_big : int = 0
@export var drop_power_full : int = 0
@export var drop_bomb : int = 0
@export var drop_life : int = 0

@export_group("Animation")
@export var animation_player : AnimationPlayer

func _ready() -> void:
	super()
	if animation_player:
		animation_player.play("default")

func _process(delta: float) -> void:
	super(delta)
	check_despawn()

func process_animation() -> void:
	if not main_anim_sprite:
		return
	var sprite_frames = main_anim_sprite.sprite_frames
	if abs(velocity.x) * 0.5 > abs(velocity.y) and sprite_frames.has_animation("side"):
		main_anim_sprite.play("side")
	elif abs(velocity.x) * 3.0 > abs(velocity.y) and sprite_frames.has_animation("diagonal"):
		main_anim_sprite.play("diagonal")
	elif sprite_frames.has_animation("default"):
		main_anim_sprite.play("default")
	main_anim_sprite.flip_h = velocity.x < 0

func check_despawn() -> void:
	if position.x > 1000 or position.x < -200 or position.y > 1000 or position.y < -300:
		queue_free()

func do_death():
	super()
	drop_items()
	queue_free()

func drop_items():
	var item_container : ItemContainer = GameUtils.get_item_container(self)
	drop_item_type(item_container, Item.Type.POWER, drop_power)
	drop_item_type(item_container, Item.Type.POINT, drop_point)
	drop_item_type(item_container, Item.Type.POWER_BIG, drop_power_big)
	drop_item_type(item_container, Item.Type.POWER_FULL, drop_power_full)

func drop_item_type(item_container: ItemContainer, type: int, count: int):
	for i in count:
		var item : Item = Item.item_scene.instantiate()
		item.top_level = true
		item.global_position = self.global_position
		item.set_random_spawn_velocity(drop_spawn_speed, drop_spawn_time)
		item_container.call_deferred("add_child", item)
		item.call_deferred("set_type", type)
	
