class_name ModScript
extends Node
## This is script that's inserted to change behavior
## Ranging from Stages, Spell Cards, Enemies, and Bullets

var time_elapsed : float = 0.0 ## Timer since script is on_ready
var time_active : float = 0.0 ## Timer that ticks only when active

var enabled : bool = true ## Is enabled

func _ready() -> void:
	time_elapsed = 0.0
	time_active = 0.0

func _process(delta: float) -> void:
	time_elapsed += delta
	if enabled:
		time_active += delta
	
func spawn_enemy(scene : PackedScene, pos : Vector2 = Vector2(0,0)) -> Enemy:
	var enemy_container = GameUtils.get_enemy_container()
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
