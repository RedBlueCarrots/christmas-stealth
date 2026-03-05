extends Elf
#[[(530.734, 588.9337), "L"], [(472.3987, 588.9337), "J"], [(401.2406, 556.9337), "J"], [(68.00028, 524.9984), "R"]]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(-15, 16):
		var newr := RayCast2D.new()
		$ViewingArea.add_child(newr)
		newr.target_position = Vector2.RIGHT.rotated(deg_to_rad(i*2.2))*225
	update_poly()
	super()

func update_poly():
	var newpoly : PackedVector2Array = []
	newpoly.append(Vector2.ZERO)
	for rc:RayCast2D in $ViewingArea.get_children():
		if rc.is_colliding():
			newpoly.append(rc.get_collision_point()-global_position)
			if rc.get_collider().is_in_group("Santa") and get_tree() and get_tree().get_first_node_in_group("Santa").has_bag:
				rc.get_collider().reset()
		else:
			newpoly.append(rc.target_position*rc.get_parent().scale)
	$Polygon2D.set_polygon(newpoly)
	$Polygon2D.visible = !get_tree() or get_tree().get_first_node_in_group("Santa").has_bag


func _physics_process(delta: float) -> void:
	super(delta)
	update_poly()
	if velocity.length() < 1:
		velocity.y = -40
