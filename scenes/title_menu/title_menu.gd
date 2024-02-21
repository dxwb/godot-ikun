extends Node2D

@onready var parallax_background = $ParallaxBackground

func _ready():
	pass # Replace with function body.

func _process(delta):
	parallax_background.scroll_offset.x -= 50 * delta
