extends CharacterBody2D

var speed = 40
var GRAV = 1800
var xdir = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if $Right.is_colliding():
		xdir = -1
	elif $Left.is_colliding():
		xdir = 1
	$AnimatedSprite2D.flip_h = xdir != 1
	velocity.x = speed * xdir
	velocity.y += delta*GRAV
	move_and_slide()
	if abs(velocity.x) > 10:
		$AnimatedSprite2D.play("run")
