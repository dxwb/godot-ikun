extends PanelContainer

@onready var texture_rect = %TextureRect
@onready var label = %Label

func set_challenge(chal_data: Dictionary):
	texture_rect.texture = load(chal_data.texture)
	label.text = chal_data.title
