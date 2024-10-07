extends Label

var game_hud : GameHud
var game_main : GameMain 
var game_view : GameView 

func _ready() -> void:
	game_hud = get_parent()
	print("game_hud")
	print(game_hud)
	game_main = game_hud.get_parent()
	print(game_main)
	game_view = game_main.game_view
	print(game_view)

func _process(delta: float) -> void:
	var player = game_view.get_player()
	text = (
		"X: " + str(player.position.x) + "\n" +
		"Y: " + str(player.position.y) + "\n" 
	)
