extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if name == "Win":
		$Label3.text = "Your time was: %.2fs" % (100000-Music.get_node("Timer").time_left)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	Global.reset()
	Music.get_node("Timer").start()
	get_tree().change_scene_to_file("res://Scenes/Room1.tscn")


func _on_button_2_pressed() -> void:
	get_tree().quit()
