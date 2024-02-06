extends ScrollContainer
class_name Inventory

@export var slots: Array[Slot]
@export var slot_ui_scene: PackedScene

@onready var grid_container = %GridContainer

func render():
	for item in grid_container.get_children():
		item.queue_free()

	for slot in slots:
		var slot_ui = slot_ui_scene.instantiate()

		grid_container.add_child(slot_ui)

		slot_ui.call_deferred("set_texture", load(slot.data.texture))
