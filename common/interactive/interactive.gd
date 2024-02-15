extends Node2D

@onready var label = $Label

var can_interactive = false

signal interacted()

func _unhandled_key_input(event):
	if not can_interactive: return

	if not event.is_action_pressed("interactive"): return

	interacted.emit()

func _on_area_2d_body_entered(body):
	label.show()
	can_interactive = true

func _on_area_2d_body_exited(body):
	label.hide()
	can_interactive = false
