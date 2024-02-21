extends Node2D

@onready var parallax_background = $ParallaxBackground

func _ready():
	pass # Replace with function body.

func _process(delta):
	parallax_background.scroll_offset.x -= 50 * delta

func _on_start_button_pressed():
	SceneManager.change_scene(Strings.GAME_SCENE)

func _on_setting_button_pressed():
	pass # Replace with function body.

func _on_exit_button_pressed():
	get_tree().quit()
