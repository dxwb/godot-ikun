extends Area2D

signal received(sender)

func on_area_entered(sender):
	emit_signal("received", sender)
