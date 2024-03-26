extends Node

@onready var debounce_timer = $DebounceTimer

const file_path = 'user://setting.cfg'

var data := SettingData.new()
var config = ConfigFile.new()

func _ready():
	load_setting()

func save_setting():
	config.set_value("Volumes", "music_volume", data.music_volume)
	config.set_value("Volumes", "sfx_volume", data.sfx_volume)

	if not debounce_timer.is_stopped():
		debounce_timer.stop()

	debounce_timer.start()

func load_setting():
	var err = config.load(file_path)

	if err != OK:
		return

	data.music_volume = config.get_value("Volumes", "music_volume", 50)
	data.sfx_volume = config.get_value("Volumes", "sfx_volume", 50)

	set_music_volume(data.music_volume)
	set_sfx_volume(data.sfx_volume)

func _on_debounce_timer_timeout():
	config.save(file_path)

func set_sfx_volume(value: int):
	data.sfx_volume = value
	_set_volume(2, value)

func set_music_volume(value: int):
	data.music_volume = value
	_set_volume(1, value)

func _set_volume(bus_index: int, value: float):
	if value == 0:
		AudioServer.set_bus_mute(bus_index, true)
	else:
		AudioServer.set_bus_mute(bus_index, false)
		var db = _convert_percentage(value)
		AudioServer.set_bus_volume_db(bus_index, db)

func _convert_percentage(percentage: float) -> float:
	var c_scale = 20.0
	var divisor = 50.0
	return c_scale * (log(percentage / divisor) / log(10))
