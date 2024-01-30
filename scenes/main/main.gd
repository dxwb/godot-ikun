extends Node

func _on_procedure_manager_begin_game():
	SceneManager.change_scene(Strings.GAME_SCENE)
