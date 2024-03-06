extends Node2D

@onready var loot_bag = %LootBag

signal interacted()

func _on_interactive_interacted():
	interacted.emit()
