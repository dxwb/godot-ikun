extends Control

@onready var tab_container = %TabContainer
@onready var challenge_panel = %ChallengePanel

func _ready():
	var _children = tab_container.get_children()
	for i in _children.size():
		tab_container.set_tab_title(i, "")
		tab_container.set_tab_icon(i, _children[i].icon)

func _unhandled_key_input(event):
	if event.is_action("ui_cancel") && event.is_pressed():
		if visible:
			close()
		else:
			open()

func open():
	show()
	get_tree().paused = true
	challenge_panel.render_challenges()

func close():
	hide()
	get_tree().paused = false

func _on_close_button_pressed():
	close()