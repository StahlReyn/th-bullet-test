extends MovementScript

@onready var bullet_circle : PackedScene = BulletUtils.scene_dict["circle_small"]
@onready var audio_shoot : AudioStream = preload("res://assets/audio/sfx/hit_noise_fade.wav")

var player : Player
var cd_shoot : float

func _ready() -> void:
	player = GameUtils.get_player()
	cd_shoot = 1.0

func process_movement(delta: float) -> void:
	cd_shoot -= delta
	
	parent.velocity.x = cos(parent.total_time * 3) * 300
	parent.velocity.y = sin(parent.total_time * 3) * 300 + 100
	
	if cd_shoot <= 0:
		var direction : Vector2 = Vector2.ZERO
		var total = 16
		var i = 0
		while i < total:
			direction.x = cos(TAU * i/total)
			direction.y = sin(TAU * i/total)
			var bullet = spawn_bullet(bullet_circle, parent.position)
			bullet.set_color((i % 2) * 3 + 1, SpriteGroupBasicBullet.ColorVariant.LIGHT)
			bullet.velocity = direction * 300
			i += 1
		AudioManager.play_audio(audio_shoot)
		cd_shoot += 2.0

# bullet.global_position.direction_to(player.global_position)
