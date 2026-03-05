class_name Elf extends CharacterBody2D
const GRAV = 1800
@export var speed = 70
@export var training := false
@export var trained_sequence := ""
const JUMP = 500
var move_data: Array[Array] = []

var dirx := 1
var next_instruction := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not training:
		parse_move_data()

func parse_move_data():
	trained_sequence = trained_sequence.replace("(", "[")
	trained_sequence = trained_sequence.replace(")", "]")
	for inst in JSON.parse_string(trained_sequence):
		move_data.append([Vector2(inst[0][0], inst[0][1]), inst[1]])

func check_training():
	if Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP
		move_data.append([position, "J"])
		print(move_data)
	if Input.is_action_just_pressed("left"):
		dirx = -1
		move_data.append([position, "L"])
		print(move_data)
	if Input.is_action_just_pressed("right"):
		dirx = 1
		move_data.append([position, "R"])
		print(move_data)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func check_move_data():
	var next_spot = move_data[next_instruction]
	if position.distance_squared_to(next_spot[0]) < 25:
		if next_spot[1] == "J":
			velocity.y = -JUMP
		elif next_spot[1] == "L":
			dirx = -1
		else:
			dirx = 1
		next_instruction += 1
		next_instruction %= move_data.size()

func _physics_process(delta: float) -> void:
	if training:
		check_training()
	else:
		check_move_data()
	velocity.x = speed * dirx
	velocity.y += delta*GRAV
	move_and_slide()
	check_anims()


func check_anims():
	if speed == 0:
		$AnimatedSprite2D.play("idle")
		return
	if velocity.x < -10:
		$AnimatedSprite2D.flip_h = true
		if has_node("ViewingArea"):
			$ViewingArea.scale.x = -1
	if velocity.x > 10:
		$AnimatedSprite2D.flip_h = false
		if has_node("ViewingArea"):
			$ViewingArea.scale.x = 1
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
	elif abs(velocity.x) > 10:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")
