extends ScrollContainer
class_name Inventory

@export var slots: Array[Slot]
@export var slot_ui_scene: PackedScene

@onready var grid_container = %GridContainer

signal slot_clicked(slot: Slot)

func render():
	for item in grid_container.get_children():
		item.queue_free()

	for slot in slots:
		var slot_ui = slot_ui_scene.instantiate()

		grid_container.add_child(slot_ui)

		slot_ui.click.connect(_on_slot_ui_click.bind(slot))
		slot_ui.call_deferred("set_texture", load(slot.data.texture))

func _on_slot_ui_click(slot: Slot):
	slot_clicked.emit(slot)
