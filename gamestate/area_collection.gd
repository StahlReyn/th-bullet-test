class_name AreaCollection
extends Area2D

var appear_time : float = 0
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	appear_time -= delta
	if appear_time > 0:
		visible = true
		var color = self.get_modulate()
		color.a = -cos(appear_time * 2) * 0.5 + 0.5
		set_modulate(color)
	else:
		visible = false

func _on_area_entered(area: Area2D) -> void:
	print("Collection Enter")
	for item in GameUtils.get_point_items(self):
		item.magnet_target = GameUtils.get_player(self)
		item.maximum_collect = true

func _on_area_exited(area: Area2D) -> void:
	for item in GameUtils.get_point_items(self):
		item.magnet_target = null
		item.maximum_collect = false

func _on_gameview_game_start() -> void:
	appear_time = 7.0
	
	
