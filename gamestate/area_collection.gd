class_name AreaCollection
extends Area2D

func _on_area_entered(area: Area2D) -> void:
	print("Collection Enter")
	for item in GameUtils.get_point_items(self):
		item.magnet_target = GameUtils.get_player(self)
		item.maximum_collect = true

func _on_area_exited(area: Area2D) -> void:
	for item in GameUtils.get_point_items(self):
		item.magnet_target = null
		item.maximum_collect = false
