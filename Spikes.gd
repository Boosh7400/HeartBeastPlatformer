extends Area2D


func _on_Spikes_body_entered(body):
	print(body.name)
	if body is Player:
		get_tree().reload_current_scene()
		body.queue_free()
