class_name Enemy
extends Area2D

@export var mhp : int = 10
var total_time : float = 0;
var hp : int

func _ready() -> void:
	hp = mhp

func _process(delta: float) -> void:
	total_time += delta
