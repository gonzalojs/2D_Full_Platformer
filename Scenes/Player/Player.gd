extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 35
const MAXFALLSPEED = 200
const MAXSPEED = 200
const JUMPFORCE = 420
const ACCEL = 50

var motion = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	if Input.is_action_pressed("RIGHT"):
		motion.x += ACCEL
	elif Input.is_action_pressed("LEFT"):
		motion.x -= ACCEL
	else:
		motion.x = lerp(motion.x, 0, 0.2)
	
	if is_on_floor():
		if Input.is_action_just_pressed("JUMP"):
			motion.y = -JUMPFORCE
	
	motion = move_and_slide(motion, UP)
