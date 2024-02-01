extends Node

@onready var death_count_ui:  = $"../CanvasLayer/CountUI/DeathCount"
@onready var caught_chickens_ui = $"../CanvasLayer/CountUI/CaughtChickens"

func _ready():
	init()

func _on_player_died():
	var death_count = SaverLoader.running_data.death_count + 1

	SaverLoader.running_data.death_count = death_count
	death_count_ui.set_num(death_count)

	# 挑战计算
	ChallengeService.complete_challenge("first_blood")

	SaverLoader.save_game()

func _on_kun_house_kun_entered(area):
	var caught_kuns = SaverLoader.running_data.caught_kuns + 1

	SaverLoader.running_data.caught_kuns = caught_kuns
	caught_chickens_ui.set_num(caught_kuns)

	# 挑战计算
	ChallengeService.complete_challenge("first_kun")

	SaverLoader.save_game()

func init():
	caught_chickens_ui.set_num(SaverLoader.running_data.caught_kuns)
	death_count_ui.set_num(SaverLoader.running_data.death_count)
