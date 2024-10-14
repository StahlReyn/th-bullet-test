class_name IconPieces
extends Control

enum Type {
	LIFE,
	BOMB
}

static var scene_heart : PackedScene = preload("res://scripts/gamehud/icon_heart.tscn")
@export var sprite_icon : Sprite2D

var cur_type : int
var cur_num : int ## What the icon is displaying, 1 is first heart, etc.

static func create_icon(type: int, num: int) -> IconPieces:
	var node : Node
	if type == Type.LIFE:
		node = scene_heart.instantiate()
	node.cur_type = type
	node.cur_num = num
	return node

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	match cur_type:
		Type.LIFE:
			update_sprite(
				GameVariables.lives, 
				GameVariables.life_pieces,
				GameVariables.life_pieces_max,
			)
		Type.BOMB:
			update_sprite(
				GameVariables.bombs, 
				GameVariables.bomb_pieces,
				GameVariables.bomb_pieces_max,
			)

func update_sprite(full_part: int, pieces: int, pieces_max: int) -> void:
	if cur_num <= full_part: 
		sprite_icon.set_frame(0) # full sprite comes first
	elif cur_num == full_part - 1 and pieces > 0: 
		sprite_icon.set_frame(pieces) # piece sprite is after full
	else:
		sprite_icon.set_frame(pieces_max) # empty sprite is at the end
