extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func crush():
	$Elf.visible = true
	var newt = Timer.new()
	add_child(newt)
	newt.one_shot = true
	newt.start()
	await newt.timeout
	var tw = get_tree().create_tween()
	tw.tween_property(Global, "magic", Global.magic+0.3, 3)
	tw.play()
	$AnimatedSprite2D.play("Crush")
	$GPUParticles2D.emitting = true
	$GPUParticles2D2.emitting = true
	newt.wait_time = 1.2
	newt.start()
	await newt.timeout
	$Elf.visible = false
	if Global.magic <= 0.4:
		Dialogic.start("transform")
	elif Global.magic <= 0.7:
		Dialogic.start("teleport")
	else:
		Dialogic.start("win")
		await Dialogic.timeline_ended
		get_tree().change_scene_to_file("res://win.tscn")


func _on_body_entered(body: Node2D) -> void:
	if body.has_bag:
		body.has_bag = false
		crush()
