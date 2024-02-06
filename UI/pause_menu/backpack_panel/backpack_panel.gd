extends MenuPanel

@onready var inventory = %Inventory

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
