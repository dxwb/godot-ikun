extends Node

func _ready():
	ProcedureManager.begin_game.connect(_on_procedure_manager_begin_game)

func _on_procedure_manager_begin_game():
	SceneManager.change_scene(Strings.TITLE_MENU_SCENE)
