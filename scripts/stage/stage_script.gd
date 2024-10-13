class_name StageScript
extends Node

var time_elapsed : float = 0.0

func _ready() -> void:
	time_elapsed = 0.0

func _process(delta: float) -> void:
	time_elapsed += delta

func spawn_enemy(scene : PackedScene, pos : Vector2 = Vector2(0,0)) -> Enemy:
	var enemy_container = get_enemy_container()
	var enemy : Enemy = scene.instantiate()
	enemy.global_position = pos
	enemy_container.add_child(enemy)
	return enemy

func spawn_bullet(scene : PackedScene, pos : Vector2 = Vector2(0,0)) -> Bullet:
	var container = GameUtils.get_bullet_container()
	var bullet : Bullet = scene.instantiate()
	bullet.global_position = pos
	container.add_child(bullet)
	return bullet

func get_enemy_container() -> Node:
	return get_parent().get_parent()

func get_stage_handler() -> StageHandler:
	return get_parent()

func switch_script(script : GDScript) -> void:
	var handler : StageHandler = get_stage_handler()
	handler.replace_script(script)
	print("Switch Script")
	
func spawn_image(image : Texture2D, pos : Vector2 = Vector2(0,0)) -> Sprite2D:
	var sprite = Sprite2D.new()
	var container = GameUtils.get_image_container()
	sprite.texture = image
	sprite.top_level = true
	sprite.global_position = pos
	container.add_child(sprite)
	return sprite

func spawn_title_card(scene : PackedScene, pos : Vector2 = Vector2(0,0)) -> TitleCard:
	var image_container = GameUtils.get_image_container()
	var image : TitleCard = scene.instantiate()
	image.top_level = true
	image.global_position = pos
	image_container.add_child(image)
	return image
