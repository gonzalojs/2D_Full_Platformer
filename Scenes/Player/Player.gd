extends KinematicBody2D

onready var sprite = $Sprite
onready var animation = $AnimationPlayer

const UP = Vector2(0, -1)
const GRAVITY = 35
const MAXFALLSPEED = 200
const MAXSPEED = 200
const JUMPFORCE = 420
const ACCEL = 50

var motion = Vector2()
var facing_right = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	if facing_right == true:
		sprite.scale.x = 1
	else:
		sprite.scale.x = -1
		
	
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	if Input.is_action_pressed("RIGHT"):
		motion.x += ACCEL
		facing_right = true
		animation.play("Run")
	elif Input.is_action_pressed("LEFT"):
		motion.x -= ACCEL
		facing_right = false
		animation.play("Run")
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		animation.play("Idle")
	
	if is_on_floor():
		if Input.is_action_just_pressed("JUMP"):
			motion.y = -JUMPFORCE
	
	if !is_on_floor():
		if motion.y < 0:
			animation.play("Jump")
		elif motion.y > 0:
			animation.play("Fall")
	
	motion = move_and_slide(motion, UP)
