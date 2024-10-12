class_name AreaCollection
extends Area2D

var appear_time : float = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if appear_time > 0:
		appear_time -= delta
		visible = true
		var color = self.get_modulate()
		color.a = -cos(appear_time * 2) * 0.5 + 0.5
		set_modulate(color)
	else:
		visible = false

func _on_area_entered(area: Area2D) -> void:
	for item in GameUtils.get_point_items():
		item.magnet_target = GameUtils.get_player()
		item.maximum_collect = true

func _on_area_exited(area: Area2D) -> void:
	for item in GameUtils.get_point_items():
		item.magnet_target = null
		item.maximum_collect = false

func _on_gameview_game_start() -> void:
	appear_time = 7.0
	
	
