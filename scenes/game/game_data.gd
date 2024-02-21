extends Node

@onready var glod_count_ui = %GlodCount
@onready var death_count_ui:  = %DeathCount
@onready var caught_chickens_ui = %CaughtChickens
@onready var ghost_spawn_count_ui = %GhostSpawnCount
@onready var snowman_hit_count_ui = %SnowmanHitCount

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
	ghost_spawn_count_ui.set_num(ghost_spawn_count)

	# 挑战计算
	ChallengeService.complete_challenge_by_group("GHOST", ghost_spawn_count)

	SaverLoader.save_game()

func _on_snowman_player_hit():
	var snowman_hit_count = SaverLoader.running_data.snowman_hit_count + 1

	SaverLoader.running_data.snowman_hit_count = snowman_hit_count
	snowman_hit_count_ui.set_num(snowman_hit_count)

	# 挑战计算
	ChallengeService.complete_challenge_by_group("SNOWMAN", snowman_hit_count)

	SaverLoader.save_game()

func _init_ui():
	glod_count_ui.set_num(SaverLoader.running_data.glod)
	caught_chickens_ui.set_num(SaverLoader.running_data.caught_kuns)
	death_count_ui.set_num(SaverLoader.running_data.death_count)
	ghost_spawn_count_ui.set_num(SaverLoader.running_data.ghost_spawn_count)
	snowman_hit_count_ui.set_num(SaverLoader.running_data.snowman_hit_count)

func _on_store_traded(data: Dictionary):
	var glod = SaverLoader.running_data.glod + data.amount
	var snowman_hit_count = SaverLoader.running_data.snowman_hit_count + data.snowman_hit_count
	var ghost_spawn_count = SaverLoader.running_data.ghost_spawn_count + data.ghost_spawn_count
	var caught_kuns = SaverLoader.running_data.caught_kuns + data.caught_chickens
	var death_count = SaverLoader.running_data.death_count + data.death_count

	SaverLoader.running_data.glod = glod
	SaverLoader.running_data.snowman_hit_count = snowman_hit_count
	SaverLoader.running_data.ghost_spawn_count = ghost_spawn_count
	SaverLoader.running_data.caught_kuns = caught_kuns
	SaverLoader.running_data.death_count = death_count

	glod_count_ui.set_num(glod)
	caught_chickens_ui.set_num(caught_kuns)
	death_count_ui.set_num(death_count)
	ghost_spawn_count_ui.set_num(ghost_spawn_count)
	snowman_hit_count_ui.set_num(snowman_hit_count)

	SaverLoader.save_game()

func _on_slot_machine_init_slot_machine_played(cost):
	SaverLoader.running_data.glod -= cost
	glod_count_ui.set_num(SaverLoader.running_data.glod)

	SaverLoader.save_game()
