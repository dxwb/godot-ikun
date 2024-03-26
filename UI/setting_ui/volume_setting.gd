extends HBoxContainer

signal volume_changed(value: int)

@onready var h_slider = $HSlider

func _on_h_slider_value_changed(value):
	volume_changed.emit(value)
