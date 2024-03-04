extends Control

@onready var panel_container = $PanelContainer
@onready var dialog_width = panel_container.size.x
@onready var viewport_width = get_viewport().get_visible_rect().size.x

func _ready():
	_init_position()

func open():
	visible = true

	var tween = create_tween()
	tween.tween_property(self, "position:x", viewport_width / 2, .25).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)

func _on_configm_button_pressed():
	var tween = create_tween()
	tween.tween_property(self, "position:x", viewport_width + dialog_width / 2, .25).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)

	await tween.finished
	_init_position()
	visible = false

func _init_position():
	position.x = -dialog_width / 2
