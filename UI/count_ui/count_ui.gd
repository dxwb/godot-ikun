extends PanelContainer

@onready var texture_rect = $MarginContainer/HBoxContainer/TextureRect
@onready var label = $MarginContainer/HBoxContainer/Label

func set_num(num: int):
	label.text = str(num)
