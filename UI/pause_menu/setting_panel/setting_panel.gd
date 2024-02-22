extends MenuPanel

signal scene_before_leave()

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_button_pressed():
	scene_before_leave.emit()
	SceneManager.change_scene(Strings.TITLE_MENU_SCENE)
