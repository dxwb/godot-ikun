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

func _on_debounce_timer_timeout():
	config.save(file_path)
