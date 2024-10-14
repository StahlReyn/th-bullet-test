extends HBoxContainer

var icon_array : Array[Node]

func _ready() -> void:
	var i : int = 1
	while i <= GameVariables.lives_max:
		var node = IconPieces.create_icon(IconPieces.Type.LIFE, i)
		add_child(node)
		icon_array.push_back(node)
		i += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
