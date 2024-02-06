extends PanelContainer

@onready var texture_rect = $TextureRect

signal click()

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			click.emit()

func _on_mouse_entered():
	var tween = create_tween()
	tween.tween_property(texture_rect, "scale", Vector2(1.1, 1.1), .1)

func _on_mouse_exited():
	var tween = create_tween()
	tween.tween_property(texture_rect, "scale", Vector2(1, 1), .1)

func _on_texture_rect_resized():
	texture_rect.pivot_offset = texture_rect.size / 2

func set_texture(texture: Texture2D):
	texture_rect.texture = texture

