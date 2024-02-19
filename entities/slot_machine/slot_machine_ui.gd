extends Control

@onready var handler = %Handler
@onready var handler_texture = handler.texture_normal as AtlasTexture

func run():
	handler_texture.region.position = Vector2(92, 0)
	#handler_texture.region.position = Vector2.ZERO

func open():
	visible = true

func close():
	visible = false

func _on_handler_pressed():
	run()
