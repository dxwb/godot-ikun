extends Node2D

@onready var store = %Store
@onready var slot_machine = %SlotMachine

func _ready():
	_check_store_visible()
	_check_slot_machine_visible()

func _on_player_died():
	var death_count = SaverLoader.running_data.death_count + 1

	SaverLoader.running_data.death_count = death_count

	# 挑战计算
	ChallengeService.complete_challenge_by_group("BLOOD", death_count)

	_check_store_visible()

	SaverLoader.save_game()

func _on_kun_house_kun_entered(area):
	var caught_kuns = SaverLoader.running_data.caught_kuns + 1

	SaverLoader.running_data.caught_kuns = caught_kuns

	# 挑战计算
	ChallengeService.complete_challenge_by_group("KUNS", caught_kuns)

	_check_store_visible()

	SaverLoader.save_game()

func _on_enemy_spawner_enemy_spawned(enemy):
	var ghost_spawn_count = SaverLoader.running_data.ghost_spawn_count + 1

	SaverLoader.running_data.ghost_spawn_count = ghost_spawn_count

	# 挑战计算
	ChallengeService.complete_challenge_by_group("GHOST", ghost_spawn_count)

	_check_store_visible()

	SaverLoader.save_game()

func _on_snowman_player_hit():
	var snowman_hit_count = SaverLoader.running_data.snowman_hit_count + 1

	SaverLoader.running_data.snowman_hit_count = snowman_hit_count

	# 挑战计算
	ChallengeService.complete_challenge_by_group("SNOWMAN", snowman_hit_count)

	_check_store_visible()

	SaverLoader.save_game()

func _on_store_traded(data: Dictionary):
	SaverLoader.running_data.glod += data.amount
	SaverLoader.running_data.snowman_hit_count += data.snowman_hit_count
	SaverLoader.running_data.ghost_spawn_count += data.ghost_spawn_count
	SaverLoader.running_data.caught_kuns += data.caught_chickens
	SaverLoader.running_data.death_count += data.death_count

	# 挑战计算
	ChallengeService.complete_challenge_by_group("GLOD", SaverLoader.running_data.glod)

	if data.amount > 0:
		var traded_glod = SaverLoader.running_data.traded_glod + data.amount
		SaverLoader.running_data.traded_glod = traded_glod
		ChallengeService.complete_challenge_by_group("STORE", traded_glod)
	elif data.amount < 0:
		var play_slot_machine_glod = SaverLoader.running_data.play_slot_machine_glod + -data.amount
		SaverLoader.running_data.play_slot_machine_glod = play_slot_machine_glod
		ChallengeService.complete_challenge_by_group("SLOT_MACHINE", play_slot_machine_glod)

	SaverLoader.save_game()

	_check_slot_machine_visible()

func _on_slot_machine_init_slot_machine_played(cost):
	SaverLoader.running_data.glod -= cost
	SaverLoader.save_game()

func _check_store_visible():
	if SaverLoader.running_data.store_activated:
		store.visible = true
		return

	if (SaverLoader.running_data.caught_kuns > 0 and
		SaverLoader.running_data.death_count > 0 and
		SaverLoader.running_data.ghost_spawn_count > 0 and
		SaverLoader.running_data.snowman_hit_count > 0):
		store.visible = true
		ChallengeService.complete_challenge("hi_store")
		SaverLoader.running_data.store_activated = true

func _check_slot_machine_visible():
	if SaverLoader.running_data.slot_machine_activated:
		slot_machine.visible = true
		return

	if SaverLoader.running_data.glod > 0:
		slot_machine.visible = true
		ChallengeService.complete_challenge("hi_slot_machine")
		SaverLoader.running_data.slot_machine_activated = true
