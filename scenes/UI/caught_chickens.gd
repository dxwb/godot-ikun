extends PanelContainer

@onready var label = $MarginContainer/HBoxContainer/Label

func set_kuns_num(num: int):
	label.text = str(num)
