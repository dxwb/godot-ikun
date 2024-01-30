extends Node

func change_scene(sceneName: StringName):
	get_tree().change_scene_to_file(sceneName)

#func _add_a_scene_manually(scene: Node):
	#get_tree().root.add_child(scene)
