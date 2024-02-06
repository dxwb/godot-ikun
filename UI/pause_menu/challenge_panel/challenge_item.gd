extends PanelContainer

@export var check = false

@onready var texture_rect = %TextureRect
@onready var label = %Label

const ITEM_CHECK_STYLE = preload("res://UI/pause_menu/challenge_panel/item_check_style.tres")
const ITEM_UNCHECK_STYLE = preload("res://UI/pause_menu/challenge_panel/item_uncheck_style.tres")

signal click()

func _ready():
	set_check(check)

func _on_mouse_entered():
	if not check: return

	z_index = 1
	var tween := create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), .1)

func _on_mouse_exited():
	if not check: return

	z_index = 0
	var tween := create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), .1)

func _on_gui_input(event):
	if not check: return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			click.emit()

func _on_resized():
	pivot_offset = size / 2

func set_challenge(chal_data: Dictionary):
	texture_rect.texture = load(chal_data.texture)
	label.text = chal_data.title

func set_check(value: bool):
	check = value

	if value:
		set("theme_override_styles/panel", ITEM_CHECK_STYLE)
		modulate = Color.WHITE
		mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND
	else:
		set("theme_override_styles/panel", ITEM_UNCHECK_STYLE)
		modulate = Color(.6, .6, .6)
		mouse_default_cursor_shape = CursorShape.CURSOR_ARROW
