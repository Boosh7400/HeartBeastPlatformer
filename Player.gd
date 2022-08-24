extends KinematicBody2D
class_name Player

export(int) var JUMP_FORCE = -130
export(int) var MIN_JUMP_FORCE = -70
export(int) var MAX_SPEED = 50
export(int) var ACCELERATION = 10
export(int) var FRICTION = 10
export(int) var GRAVITY = 4
export(int) var FALL_GRAVITY = 4

var velocity = Vector2.ZERO

onready var animatedSprite = $AnimatedSprite

func _ready():
	#animatedSprite.frames = load("res://PlayerGreenSkin.tres")
	pass

func _physics_process(delta):
	apply_gravity()
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input.x == 0:
		apply_friction()
		animatedSprite.animation = "Idle"
	else:
		apply_acceleration(input.x)
		animatedSprite.animation = "Run"
		animatedSprite.flip_h = input.x > 0

	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_FORCE
	else:
		animatedSprite.animation = "Jump"
		if Input.is_action_just_released("ui_up") && velocity.y < MIN_JUMP_FORCE:
			velocity.y = MIN_JUMP_FORCE
			
		if velocity.y > 0:
			velocity.y += FALL_GRAVITY
			velocity.y = min(velocity.y, 200)

	var was_in_air = not is_on_floor()
	velocity = move_and_slide(velocity, Vector2.UP)
	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		animatedSprite.animation = "Run"
		animatedSprite.frame = 1

func apply_gravity():
	velocity.y +=GRAVITY

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)

func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MAX_SPEED*amount, ACCELERATION)
