extends Node

var data = {
	"CaughtKuns": 0,
	"DeathCount": 0
}

const file_path = 'user://savegame.save'

func _ready():
	call_deferred('load_data')

func set_caught_kuns(num: int):
	data.CaughtKuns = num
	save_data()

func add_caught_kuns():
	set_caught_kuns(data.CaughtKuns + 1)

func set_death_count(num: int):
	data.DeathCount = num
	save_data()

func add_death_count():
	set_death_count(data.DeathCount + 1)

func save_data():
	var save_game = FileAccess.open(file_path, FileAccess.WRITE)
	save_game.store_var(data)
	save_game.close()

func load_data():
	if (!FileAccess.file_exists(file_path)): return

	var save_game = FileAccess.open(file_path, FileAccess.READ)
	var save_data = save_game.get_var()

	data.CaughtKuns = save_data.CaughtKuns
	var _DeathCount = save_data.get("DeathCount")
	data.DeathCount = _DeathCount if _DeathCount != null else 0

	save_game.close()
