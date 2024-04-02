extends Node2D

@onready var parallax_background = $ParallaxBackground
@onready var setting_dialog = $CanvasLayer/SettingDialog

func _process(delta):
	parallax_background.scroll_offset.x -= 50 * delta

func _on_start_button_pressed():
	SceneManager.change_scene_async(Strings.GAME_SCENE)

func _on_setting_button_pressed():
	setting_dialog.open()

func _on_exit_button_pressed():
	get_tree().quit()
