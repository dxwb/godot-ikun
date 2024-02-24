extends Node

func add_loot(loot_data: Dictionary):
	SaverLoader.running_data.collected_cards.push_back(loot_data.name_id)

	if SaverLoader.running_data.collected_cards:
		ChallengeService.complete_challenge_by_group("CARD", SaverLoader.running_data.collected_cards.size())

	SaverLoader.save_game()

func get_owned_loots() -> Dictionary:
	var loots = DatatableManager.get_data("cards")
	var result: Dictionary = {}

	for loot_id in loots:
		var loot_data = loots[loot_id]
		if SaverLoader.running_data.collected_cards.has(loot_id):
			result[loot_id] = loot_data

	return result

func get_unowned_loots() -> Dictionary:
	var loots = DatatableManager.get_data("cards")
	var result: Dictionary = {}

	for loot_id in loots:
		var loot_data = loots[loot_id]
		if not SaverLoader.running_data.collected_cards.has(loot_id):
			result[loot_id] = loot_data

	return result
