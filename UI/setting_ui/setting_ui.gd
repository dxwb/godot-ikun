extends MarginContainer

@onready var music_volume_setting = %MusicVolumeSetting
@onready var vfx_volume_setting = %VFXVolumeSetting

func _ready():
	call_deferred("_init_setting")

func _init_setting():
	music_volume_setting.h_slider.value = SettingManager.data.music_volume
	vfx_volume_setting.h_slider.value = SettingManager.data.sfx_volume

func _on_volume_changed(bus_index, value):
	match bus_index:
		1:
			SettingManager.data.music_volume = value
		2:
			SettingManager.data.sfx_volume = value

	SettingManager.save_setting()
