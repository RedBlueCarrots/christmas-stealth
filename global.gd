extends Node

var respawn := Vector2(1093.0, 725)
var magic := 0.1
var bag = false
var santae = true
var first = true
# Called when the node enters the scene tree for the first time.
func reset() -> void:
	respawn = Vector2(1093.0, 725)
	magic = 0.1
	bag = false
	santae = true
	first = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
