extends HBoxContainer

@onready var h_slider = $HSlider

@export var bus_index := 0

signal volume_changed(bus_index: int, value: int)

func _on_h_slider_value_changed(value):
	if value == 0:
		AudioServer.set_bus_mute(bus_index, true)
	else:
		AudioServer.set_bus_mute(bus_index, false)
		var db = _convert_percentage(value)
		AudioServer.set_bus_volume_db(bus_index, db)

	volume_changed.emit(bus_index, value)

func _convert_percentage(percentage: float) -> float:
	var c_scale = 20.0
	var divisor = 50.0
	return c_scale * (log(percentage / divisor) / log(10))
