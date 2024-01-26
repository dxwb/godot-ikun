extends Node

const file_path = 'user://savegame.tres'
var running_data := SavedGame.new()

func _ready():
	load_game()

func save_game():
	ResourceSaver.save(running_data, file_path)

func load_game():
	if not FileAccess.file_exists(file_path): return

	var saved_game = load(file_path) as SavedGame

	if saved_game == null: return

	running_data = saved_game
