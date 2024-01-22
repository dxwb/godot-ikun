extends Control
class_name DeathCountdownUI

@onready var label = $HBoxContainer/Label

func set_text(time: int):
	label.text = str(time)
