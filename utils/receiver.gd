extends Area2D
class_name Receiver

signal received_entered(sender: Area2D)

signal received_exited(sender: Area2D)

func on_area_entered(sender: Area2D):
	emit_signal("received_entered", sender)

func on_area_exited(sender: Area2D):
	emit_signal("received_exited", sender)
