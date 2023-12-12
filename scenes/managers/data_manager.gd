extends Node

var data = {
	"CaughtKuns": 0
}

const file_path = 'user://savegame.save'

signal caught_kuns_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred('load_data')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_caught_kuns(num: int):
	data.CaughtKuns = num
	caught_kuns_changed.emit(data.CaughtKuns)
	save_data()

func add_caught_kuns():
	set_caught_kuns(data.CaughtKuns + 1)

func save_data():
	var save_game = FileAccess.open(file_path, FileAccess.WRITE)
	save_game.store_var(data)

func load_data():
	if (!FileAccess.file_exists(file_path)): return

	var save_game = FileAccess.open(file_path, FileAccess.READ)
	var save_data = save_game.get_var()
	set_caught_kuns(save_data.CaughtKuns)
