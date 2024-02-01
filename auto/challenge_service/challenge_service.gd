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
