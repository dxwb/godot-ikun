extends Node2D

@export var disabled = false:
	set(value):
		disabled = value
		ui.disabled = value

@onready var world = %SlotMachineWorld
@onready var ui = %SlotMachineUI
@onready var glod_movement = %GlodMovement

signal ui_opened()
signal ui_closed()
signal roll_started()
signal roll_stoped(result: Array[int])

func set_slot_images(images: Array[Texture2D]):
	ui.set_slot_images(images)

func _on_slot_machine_world_interacted():
	ui.open()
	ui_opened.emit()

func _on_slot_machine_ui_closed():
	ui_closed.emit()

func _on_slot_machine_ui_started():
	glod_movement.run()
	roll_started.emit()

func _on_slot_machine_ui_stopped(result):
	roll_stoped.emit(result)
