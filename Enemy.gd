extends KinematicBody2D

var direction = Vector2.RIGHT
var velocity =  Vector2.ZERO

onready var LedgeCheckLeft = $LedgeCheckLeft
onready var LedgeCheckRight = $LedgeCheckRight
onready var sprite = $AnimatedSprite

func _physics_process(delta):
	var wall = is_on_wall()
	var ledge = not LedgeCheckLeft.is_colliding() or not LedgeCheckRight.is_colliding()
	if wall or ledge:
		direction *= -1
	
	sprite.flip_h = direction.x > 0
	velocity = direction * 25
	move_and_slide(velocity, Vector2.UP)
