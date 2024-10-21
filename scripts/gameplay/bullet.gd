class_name Bullet
extends Entity

@export_group("Visuals")
@export var main_sprite : Sprite2D
@export var bullet_hit_effect_scene : PackedScene
@export var rotation_based_on_velocity : bool = true
@export_group("Gameplay")
@export var damage : int = 1
@export var penetration : int = 1

func _init() -> void:
	super()
	monitorable = true
	monitoring = false
	
func _ready() -> void:
	super()

func _physics_process(delta: float) -> void:
	super(delta)

func process_movement(delta) -> void:
	super(delta)
	if rotation_based_on_velocity:
		rotation = velocity.angle()

func on_hit():
	super()
	if hit_count >= penetration:
		if bullet_hit_effect_scene:
			AfterEffect.add_effect(bullet_hit_effect_scene, self)
		call_deferred("queue_free")

func set_color(type: int, variant: int) -> void:
	if main_sprite is SpriteGroupBasicBullet:
		main_sprite.set_color(type, variant)
	else:
		push_warning("Cannot set color to non-sprite group bullets")

func set_random_color(variant: int) -> void:
	if main_sprite is SpriteGroupBasicBullet:
		main_sprite.set_random_color(variant)
	else:
		push_warning("Cannot set color to non-sprite group bullets")
