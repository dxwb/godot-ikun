extends PanelContainer

@onready var title = %Title
@onready var sub_title = %SubTitle
@onready var texture_rect = %TextureRect
@onready var description = %Description

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			queue_free()

func set_challenge(chal_data: Dictionary):
	title.text = chal_data.title
	sub_title.text = chal_data.note
	texture_rect.texture = load(chal_data.texture)
	description.text = chal_data.condition
