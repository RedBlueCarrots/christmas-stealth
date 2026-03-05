extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	Global.respawn = Vector2(2221.0, 516)
	get_tree().change_scene_to_file("res://Scenes/Room2.tscn")


func _on_to_room_3_body_entered(body: Node2D) -> void:
	Global.respawn = Vector2(2222.0, 207)
	get_tree().change_scene_to_file("res://Scenes/Room2.tscn")


func _on_to_room_4_body_entered(body: Node2D) -> void:
	Global.respawn = Vector2(47, -175)
	get_tree().change_scene_to_file("res://Scenes/Room3.tscn")
