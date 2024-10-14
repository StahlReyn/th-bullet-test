extends Label

var player : Player

func _ready() -> void:
	player = GameUtils.get_player()

func _process(_delta: float) -> void:
	text = (
		"FPS: " + str(Engine.get_frames_per_second()  ) + "\n" +
		"Time: " + ("%.3f" % GameVariables.game_time) + "\n" +
		"X: " + ("%.3f" % player.position.x) + "\n" +
		"Y: " + ("%.3f" % player.position.y) + "\n\n" +
		"Bullet Count: " + str(GameUtils.get_bullet_count()) + "\n" +
		"Enemy Count: " + str(GameUtils.get_enemy_count()) + "\n" +
		"Item Count: " + str(GameUtils.get_item_count()) + "\n\n" +
		"Power: " + str(GameVariables.power) + "\n" +
		"Score: " + str(GameVariables.score) + "\n" +
		"Lives: " + str(GameVariables.lives) + "\n" +
		"Graze Count: " + str(GameVariables.graze) + "\n" 
	)
