extends MenuPanel

@export var card_scene: PackedScene

@onready var inventory = %Inventory
@onready var select_card = $Sounds/SelectCard

var ui_root: CanvasLayer

func _ready():
	ui_root = get_tree().get_first_node_in_group("ui_canvas_layer")

func render():
	var loots = BackpackManager.get_owned_loots()
	var slots: Array[Slot] = []
	for loot_id in loots:
		var loot_data = loots[loot_id]
		var slot = Slot.new()
		slot.data = loot_data
		slots.push_back(slot)

	inventory.slots = slots
	inventory.render()

func _on_inventory_slot_clicked(slot: Slot):
	var card = card_scene.instantiate()
	ui_root.add_child(card)
	card.call_deferred("set_card", slot.data)

	select_card.play()
