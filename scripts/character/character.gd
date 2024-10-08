class_name Character
extends Area2D
## Parent class for Player and Enemy

signal hit

@export var main_anim_sprite : AnimatedSprite2D
@export var main_collision : CollisionShape2D
@export var audio_death : AudioStreamPlayer2D

@export var mhp : int = 1
var total_time : float = 0;
var hp : int

var velocity = Vector2.ZERO

func _ready() -> void:
	reset_hp()
	pass

func _process(delta: float) -> void:	
	total_time += delta
	process_movement_input()
	process_movement(delta)
	process_animation()
	pass

func process_movement_input() -> void:
	velocity = Vector2.ZERO

func process_movement(delta) -> void:
	position += velocity * delta

func process_animation() -> void:
	if not main_anim_sprite:
		return
	var sprite_frames = main_anim_sprite.sprite_frames
	if velocity.x > 0 and sprite_frames.has_animation("right"):
		main_anim_sprite.play("right")
	elif velocity.x < 0 and sprite_frames.has_animation("left"):
		main_anim_sprite.play("left")
	elif sprite_frames.has_animation("idle"):
		main_anim_sprite.play("idle")

func reset_hp():
	hp = mhp

func take_damage(dmg : int):
	hp -= dmg

func check_death():
	if hp < 0:
		do_death()

func do_death():
	if audio_death:
		audio_death.play()

func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		hit.emit()
		take_damage(area.damage)
		area.on_hit()
		check_death()
