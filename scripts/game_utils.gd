class_name GameUtils

static var game_area : Vector2 = Vector2(768,896)

static func get_player(node : Node) -> Player:
	return node.get_tree().get_nodes_in_group("player")[0]

static func get_bullet_count(node : Node) -> int:
	return len(node.get_tree().get_nodes_in_group("bullet"))

static func get_game_view(node : Node) -> GameView:
	return node.get_tree().get_nodes_in_group("game_view")[0]

static func get_bullet_container(node : Node) -> BulletContainer:
	return node.get_tree().get_nodes_in_group("bullet_container")[0]

static func get_effect_container(node : Node) -> EffectContainer:
	return node.get_tree().get_nodes_in_group("effect_container")[0]

static func get_item_container(node : Node) -> ItemContainer:
	return node.get_tree().get_nodes_in_group("item_container")[0]

static func get_image_container(node : Node) -> ImageContainer:
	return node.get_tree().get_nodes_in_group("image_container")[0]

static func get_point_items(node : Node) -> Array[Node]:
	return node.get_tree().get_nodes_in_group("item")

static func get_game_area() -> Vector2:
	return game_area

static func add_score(node: Node, value: int) -> void:
	get_game_view(node).score += value
