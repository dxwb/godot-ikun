extends Node2D

@onready var store_ui = %StoreUI
@onready var traded_sound = $Sounds/TradedSound

signal dialogue_opened()
signal dialogue_closed()
signal store_ui_closed()
signal traded(data: Dictionary)

var is_shopping = false

func _on_interactive_interacted():
	if is_shopping: return

	Dialogic.start('store')

	is_shopping = true
	dialogue_opened.emit()

	await Dialogic.timeline_ended

	_on_interactive_dialogue_close()

func _on_interactive_dialogue_close():
	dialogue_closed.emit()
	store_ui.open()

func _on_store_ui_closed():
	is_shopping = false
	store_ui_closed.emit()

func _on_store_ui_traded(data: Dictionary):
	traded.emit(data)
	traded_sound.play()
