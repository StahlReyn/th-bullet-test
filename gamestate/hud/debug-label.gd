extends Label

var game_view : GameView 
var player : Player

func _ready() -> void:
	game_view = GameUtils.get_game_view(self)
	player = GameUtils.get_player(self)

func _process(_delta: float) -> void:
	text = (
		"FPS: " + str(Engine.get_frames_per_second()  ) + "\n" +
		"Time: " + str(game_view.game_time) + "\n" +
		"X: " + str(player.position.x) + "\n" +
		"Y: " + str(player.position.y) + "\n" +
		"Bullet Count: " + str(GameUtils.get_bullet_count(self)) + "\n\n" +
		"Power: " + str(player.power) + "\n" +
		"Score: " + str(game_view.score) + "\n" +
		"Graze Count: " + str(game_view.graze_count) + "\n" 
	)
