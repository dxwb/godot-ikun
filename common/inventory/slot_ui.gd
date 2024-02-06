extends PanelContainer

@onready var texture_rect = $TextureRect

signal click()

func set_texture(texture: Texture2D):
	texture_rect.texture = texture

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			click.emit()
