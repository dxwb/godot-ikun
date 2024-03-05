extends Node2D

@onready var path_follow_2d = $Path2D/PathFollow2D
@onready var sprite_2d = $Sprite2D

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		run()

func _process(delta):
	sprite_2d.global_position = path_follow_2d.global_position

func run():
	if visible: return

	visible = true

	var tween = create_tween()
	tween.tween_property(path_follow_2d, "progress_ratio", 1, 1)

	await tween.finished
	_reset()

func _reset():
	visible = false
	path_follow_2d.progress_ratio = 0
