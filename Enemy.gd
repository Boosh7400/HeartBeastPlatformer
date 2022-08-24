extends KinematicBody2D

var direction = Vector2.RIGHT
var velocity =  Vector2.ZERO


func _physics_process(delta):
	var wall = is_on_wall()
	if wall:
		direction *= -1
	velocity = direction * 25
	move_and_slide(velocity, Vector2.UP)
