class_name Character
extends Area2D
## Parent class for Player and Enemy

signal hit

@export_group("Nodes")
@export var main_sprite : Node2D
@export var main_collision : CollisionShape2D

@export_group("After Effects")
@export var death_effect_scene : PackedScene

@export_group("Stat")
@export var mhp : int = 1

var total_time : float = 0;
var hp : int

var velocity = Vector2.ZERO
var is_dead : bool = false

func _ready() -> void:
	reset_hp()

func _physics_process(delta: float) -> void:	
	total_time += delta
	process_movement(delta)
	update_animation()

func process_movement(delta) -> void:
	position += velocity * delta

# Passes self so script can also access other like velocity
func update_animation() -> void:
	if not main_sprite:
		return
	main_sprite.update_animation(self)

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
	if death_effect_scene:
		AfterEffect.add_effect(death_effect_scene, self)

func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		hit.emit()
		take_damage(area.damage)
		area.on_hit()
