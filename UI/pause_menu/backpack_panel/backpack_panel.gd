extends MenuPanel

@export var card_scene: PackedScene

@onready var content = %Content
@onready var inventory = %Inventory
@onready var select_card = $Sounds/SelectCard
@onready var empty_label = %EmptyLabel

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

	if slots.size() > 0:
		content.size_flags_horizontal = SIZE_SHRINK_BEGIN
		content.size_flags_vertical = SIZE_SHRINK_BEGIN
		empty_label.visible = false
		inventory.visible = true
		inventory.slots = slots
		inventory.render()
	else:
		content.size_flags_horizontal = SIZE_EXPAND_FILL
		content.size_flags_vertical = SIZE_EXPAND_FILL
		empty_label.visible = true
		inventory.visible = false

func _on_inventory_slot_clicked(slot: Slot):
	var card = card_scene.instantiate()
	ui_root.add_child(card)
	card.call_deferred("set_card", slot.data)

	select_card.play()
