extends Node
class_name LootBag

@export var loot_scene: PackedScene

func drop():
	var loot_data = _get_random_loot()
	# 概率判断
	var f = randf()
	var droprate = loot_data.droprate / 100

	if f <= droprate:
		var loot = loot_scene.instantiate()

		loot.loot_data = loot_data
		loot.global_position = owner.global_position

		get_tree().get_current_scene().call_deferred("add_child", loot)

func _get_random_loot() -> Dictionary:
	var loots = DatatableManager.get_data("cards") as Dictionary
	var size = loots.size()
	var keys = loots.keys()
	var index = randi_range(0, size - 1)

	return loots[keys[index]]
