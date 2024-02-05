extends Node
class_name LootBag

func drop():
	var loot_data = _get_random_loot()
	# 概率判断
	var f = randf()
	var droprate = loot_data.droprate / 100

	if f <= droprate:
		print(loot_data)

func _get_random_loot() -> Dictionary:
	var loots = DatatableManager.get_data("cards") as Dictionary
	var size = loots.size()
	var keys = loots.keys()
	var index = randi_range(0, size - 1)

	return loots[keys[index]]
