extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		visible = !visible
		get_tree().paused = visible


func _on_button_pressed() -> void:
	visible = !visible
	get_tree().paused = visible


func _on_button_2_pressed() -> void:
	visible = !visible
	get_tree().paused = visible
	Global.reset()
	Music.get_node("Timer").start()
	get_tree().change_scene_to_file("res://Scenes/Room1.tscn")


func _on_button_3_pressed() -> void:
	get_tree().quit()
