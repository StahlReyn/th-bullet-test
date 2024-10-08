class_name GameUtils

static var game_area : Vector2 = Vector2(768,896)

static func get_player(node : Node) -> Player:
	return node.get_tree().get_nodes_in_group("player")[0]

static func get_bullet_count(node : Node) -> int:
	return len(node.get_tree().get_nodes_in_group("bullet"))

static func get_game_area() -> Vector2:
	return game_area
