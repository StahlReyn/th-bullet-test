extends Label

var game_hud : GameHud
var game_main : GameMain 
var game_view : GameView 

func _ready() -> void:
	game_hud = get_parent()
	game_main = game_hud.get_parent()
	game_view = game_main.game_view

func _process(delta: float) -> void:
	var player = game_view.get_player()
	text = (
		"Time: " + str(game_view.game_time) + "\n" +
		"X: " + str(player.position.x) + "\n" +
		"Y: " + str(player.position.y) + "\n" +
		"Bullet Count: " + str(game_view.get_bullet_count()) + "\n" 
	)
