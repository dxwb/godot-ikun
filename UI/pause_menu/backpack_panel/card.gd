extends PanelContainer

@onready var title = %Title
@onready var sub_title = %SubTitle
@onready var texture_rect = %TextureRect
@onready var description = %Description

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			queue_free()

func set_card(card_data: Dictionary):
	title.text = card_data.title
	sub_title.text = card_data.rarity
	texture_rect.texture = load(card_data.texture)
	description.text = card_data.note
