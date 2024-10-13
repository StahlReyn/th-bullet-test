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
var is_dead : bool = false

func _ready() -> void:
	reset_hp()

func _process(delta: float) -> void:	
	total_time += delta
	process_movement(delta)
	update_animation(velocity)

func process_movement(delta) -> void:
	position += velocity * delta

func update_animation(velocity: Vector2) -> void:
	pass

func reset_hp():
	hp = mhp

func take_damage(dmg : int):
	hp -= dmg
	check_death()

func check_death():
	if hp <= 0 and not is_dead:
		do_death()

func do_death():
	is_dead = true
	if audio_death:
		audio_death.play()

func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		hit.emit()
		take_damage(area.damage)
		area.on_hit()
