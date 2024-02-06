extends PanelContainer

@export var check = false

@onready var texture_rect = %TextureRect
@onready var title = %Title
@onready var condition = %Condition

const ITEM_CHECK_STYLE = preload("res://UI/pause_menu/challenge_panel/item_check_style.tres")
const ITEM_UNCHECK_STYLE = preload("res://UI/pause_menu/challenge_panel/item_uncheck_style.tres")

signal click()

func _ready():
	set_check(check)

func _on_gui_input(event):
	if not check: return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			click.emit()

func set_challenge(chal_data: Dictionary):
	texture_rect.texture = load(chal_data.texture)
	title.text = chal_data.title
	condition.text = chal_data.condition

func set_check(value: bool):
	check = value

	if value:
		set("theme_override_styles/panel", ITEM_CHECK_STYLE)
		modulate = Color.WHITE
		condition.set("theme_override_colors/font_color", Color(.6, .6, .6))
	else:
		set("theme_override_styles/panel", ITEM_UNCHECK_STYLE)
		modulate = Color(.6, .6, .6)
		condition.set("theme_override_colors/font_color", Color.WHITE)
