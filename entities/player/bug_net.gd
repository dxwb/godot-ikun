extends Node2D

func _process(delta):
	rotate(-PI * delta)

func _on_area_2d_body_entered(body):
	pass # Replace with function body.
