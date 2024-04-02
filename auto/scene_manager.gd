extends Node

var current_scene_name: StringName

func change_scene(scene_name: StringName):
	get_tree().change_scene_to_file(scene_name)

func change_scene_to_packed(packed_scene: PackedScene):
	get_tree().change_scene_to_packed(packed_scene)

func change_scene_async(scene_name: StringName):
	current_scene_name = scene_name
	change_scene(Strings.LOADING_SCENE)

#func _add_a_scene_manually(scene: Node):
	#get_tree().root.add_child(scene)
