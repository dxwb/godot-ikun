extends Node2D

@onready var slot_machine_ui = %SlotMachineUI

signal ui_opened()
signal ui_closed()

func set_slot_images(images: Array[Texture2D]):
	slot_machine_ui.set_slot_images(images)

func _on_interactive_interacted():
	slot_machine_ui.open()
	ui_opened.emit()

func _on_slot_machine_ui_closed():
	ui_closed.emit()
