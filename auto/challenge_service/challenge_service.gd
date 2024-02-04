extends Node

@export var challenges: Dictionary

signal challenge_completed(chal_data: Dictionary)

# 完成挑战
func complete_challenge(chal_id: StringName):
	if SaverLoader.running_data.challenges_completed.has(chal_id): return

	var chal_data: Dictionary = challenges[chal_id]

	SaverLoader.running_data.challenges_completed.push_back(chal_id)
	SaverLoader.save_game()

	challenge_completed.emit(chal_data)

func complete_challenge_by_group(group_name: StringName, value: int):
	var chals = get_challenge_by_group(group_name)
	for chal_data in chals:
		if value >= chal_data.value:
			complete_challenge(chal_data.ID)

func get_challenge_by_group(group_name: StringName) -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	var chals = DatatableManager.get_data("challenges")

	for chal_id in chals:
		var chal_data = chals[chal_id]
		if chal_data.group == group_name:
			result.push_back(chal_data)

	return result
