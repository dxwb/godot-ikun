extends Area2D

@export var entered_receiver = ""

signal triggered(area)

func _on_area_entered(area):
	if area.name == entered_receiver:
		area.on_area_entered(self)
		emit_signal("triggered", area)
