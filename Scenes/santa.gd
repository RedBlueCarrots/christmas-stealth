extends CharacterBody2D
const GRAV = 1800
const ACCEL = 2000
const FRICT = 0.008
const JUMP = 600
const TELE_DIST = 200

var saved_vel = Vector2.RIGHT
var locked_vel = Vector2.RIGHT

var can_tele := false
var has_bag := false
var can_rein := true
var is_santa := true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	has_bag = Global.bag
	is_santa = Global.santae
	position =  Global.respawn

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
	can_tele = Global.magic >= 0.7
	can_rein = Global.magic >= 0.4 
	$Bag.visible = has_bag
	Global.bag = has_bag
	Global.santae = is_santa
	$AnimatedSprite2D.visible = is_santa
	$AnimatedSprite2D2.visible = !is_santa

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	$CollisionShape2D.disabled = !is_santa
	$CollisionShape2D2.disabled = is_santa
	var inp_dir =Input.get_axis("left", "right")
	var xtra = 1.0
	if !is_santa:
		xtra = 1.3
	velocity.x += inp_dir*ACCEL*delta*xtra
	velocity.x*=pow(FRICT, delta)
	if inp_dir == 0.0:
		velocity.x*=pow(FRICT, delta)
	velocity.y += GRAV*delta
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP
		if not is_santa:
			velocity.y = -JUMP*0.6
	check_anims()
	move_and_slide()
	if velocity.length_squared() > 100:
		saved_vel = velocity
	var axis = Input.get_vector("left", "right", "jump", "down")
	if axis != Vector2.ZERO:
		locked_vel = axis
	if Input.is_action_just_pressed("teleport") and is_santa and can_tele:
		$Sprite2D.visible = true
	recal_raycasts()
	if Input.is_action_just_released("teleport") and is_santa and can_tele:
		position += $Sprite2D.position
		$Sprite2D.visible = false
	if Input.is_action_just_pressed("kidnap"):# and is_santa:
		for elf in $Kidnap.get_overlapping_bodies():
			if not has_bag:
				has_bag = true
				Global.respawn = position
				elf.queue_free()
	if Input.is_action_just_pressed("trans") and can_rein:# and not has_bag:
		is_santa = !is_santa

func check_anims():
	if velocity.x < -30:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D2.flip_h = true
		$Bag.scale.x = -2
	if velocity.x > 30:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D2.flip_h = false
		$Bag.scale.x = 2
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
		$AnimatedSprite2D2.play("jump")
	elif abs(velocity.x) > 30:
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D2.play("run")
	else:
		$AnimatedSprite2D.play("idle_front")
		$AnimatedSprite2D2.play("idle_front")

func reset():
	get_tree().reload_current_scene()
