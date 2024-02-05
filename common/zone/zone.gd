extends Area2D

@export var entered_receiver = ""

signal entered(area: Area2D)

signal exited(area: Area2D)

func _on_area_entered(area: Area2D):
	if area.name == entered_receiver:
		area.on_area_entered(self)
		emit_signal("entered", area)

func _on_area_exited(area: Area2D):
	if area.name == entered_receiver:
		area.on_area_exited(self)
		emit_signal("exited", area)
