extends Node2D

@onready var slot_machine_ui = %SlotMachineUI

func _on_interactive_interacted():
	slot_machine_ui.open()
