extends CharacterBody2D
const GRAV = 1800
const ACCEL = 2000
const FRICT = 0.008
const JUMP = 600
const TELE_DIST = 200

var saved_vel = Vector2.RIGHT
var locked_vel = Vector2.RIGHT

var can_tele := true
var has_bag := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func recal_raycasts():
	var target = locked_vel.normalized()
	$Inner.position = target
	for i in range(TELE_DIST, 0, -20):
		$Inner.position = target*i
		$Inner.force_shapecast_update()
		if not $Inner.is_colliding():
			break
	$Sprite2D.position = $Inner.position

func _process(delta: float) -> void:
	$Bag.visible = has_bag

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var inp_dir =Input.get_axis("left", "right")
	velocity.x += inp_dir*ACCEL*delta
	velocity.x*=pow(FRICT, delta)
	if inp_dir == 0.0:
		velocity.x*=pow(FRICT, delta)
	velocity.y += GRAV*delta
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP
	check_anims()
	move_and_slide()
	if velocity.length_squared() > 100:
		saved_vel = velocity
	if Input.is_action_just_pressed("teleport"):
		locked_vel = saved_vel
		$Sprite2D.visible = true
	recal_raycasts()
	if Input.is_action_just_released("teleport"):
		position += $Sprite2D.position
		$Sprite2D.visible = false
	if Input.is_action_just_pressed("kidnap"):
		for elf in $Kidnap.get_overlapping_bodies():
			if not has_bag:
				has_bag = true
				elf.queue_free()

func check_anims():
	if velocity.x < -30:
		$AnimatedSprite2D.flip_h = true
		$Bag.scale.x = -2
	if velocity.x > 30:
		$AnimatedSprite2D.flip_h = false
		$Bag.scale.x = 2
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
	elif abs(velocity.x) > 30:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle_front")
