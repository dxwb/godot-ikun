extends Node

@onready var death_count_ui:  = $"../CanvasLayer/CountUI/DeathCount"
@onready var caught_chickens_ui = $"../CanvasLayer/CountUI/CaughtChickens"

func _ready():
	_init_ui()

func _on_player_died():
	var death_count = SaverLoader.running_data.death_count + 1

	SaverLoader.running_data.death_count = death_count
	death_count_ui.set_num(death_count)

	# 挑战计算
	ChallengeService.complete_challenge_by_group("BLOOD", death_count)

	SaverLoader.save_game()

func _on_kun_house_kun_entered(area):
	var caught_kuns = SaverLoader.running_data.caught_kuns + 1

	SaverLoader.running_data.caught_kuns = caught_kuns
	caught_chickens_ui.set_num(caught_kuns)

	# 挑战计算
	ChallengeService.complete_challenge_by_group("KUNS", caught_kuns)

	SaverLoader.save_game()

func _on_enemy_spawner_enemy_spawned(enemy):
	var ghost_spawn_count = SaverLoader.running_data.ghost_spawn_count + 1

	SaverLoader.running_data.ghost_spawn_count = ghost_spawn_count
	#caught_chickens_ui.set_num(caught_kuns)

	# 挑战计算
	ChallengeService.complete_challenge_by_group("GHOST", ghost_spawn_count)

	SaverLoader.save_game()

func _init_ui():
	caught_chickens_ui.set_num(SaverLoader.running_data.caught_kuns)
	death_count_ui.set_num(SaverLoader.running_data.death_count)
