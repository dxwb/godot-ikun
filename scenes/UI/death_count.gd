extends PanelContainer

@onready var label = $MarginContainer/HBoxContainer/Label

func set_count_num(num: int):
	label.text = str(num)
