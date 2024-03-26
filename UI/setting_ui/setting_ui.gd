extends MarginContainer

@onready var music_volume_setting = %MusicVolumeSetting
@onready var vfx_volume_setting = %VFXVolumeSetting

func _ready():
	call_deferred("_init_setting")

func _init_setting():
	music_volume_setting.h_slider.value = SettingManager.data.music_volume
	vfx_volume_setting.h_slider.value = SettingManager.data.sfx_volume

func _on_music_volume_setting_volume_changed(value):
	SettingManager.set_music_volume(value)

func _on_vfx_volume_setting_volume_changed(value):
	SettingManager.set_sfx_volume(value)
