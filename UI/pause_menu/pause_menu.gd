extends Control

@onready var tab_container = %TabContainer

var tab_children: Array[Node]

func _ready():
	tab_children = tab_container.get_children()
	for i in tab_children.size():
		tab_container.set_tab_title(i, "")
		tab_container.set_tab_icon(i, tab_children[i].icon)

func _unhandled_key_input(event):
	if event.is_action("ui_cancel") && event.is_pressed():
		if visible:
			close()
		else:
			open()

func _on_tab_container_tab_changed(tab: int):
	tab_children[tab].render()

func open():
	show()
	get_tree().paused = true
	tab_children[0].render()

func close():
	hide()
	get_tree().paused = false

func _on_close_button_pressed():
	close()
