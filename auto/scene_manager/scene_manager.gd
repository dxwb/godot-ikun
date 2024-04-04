extends CanvasLayer

@onready var animation_player = $AnimationPlayer

var current_scene_name: StringName

func transition_in_scene(scene_name: StringName):
	play_transition_in()

	await animation_player.animation_finished

	change_scene(scene_name)

func transition_in_scene_to_packed(packed_scene: PackedScene):
	play_transition_in()

	await animation_player.animation_finished

	change_scene_to_packed(packed_scene)

func transition_out_scene(scene_name: StringName):
	play_transition_out()

	await animation_player.animation_finished

	change_scene(scene_name)

func transition_out_scene_to_packed(packed_scene: PackedScene):
	play_transition_out()

	await animation_player.animation_finished

	change_scene_to_packed(packed_scene)

func change_scene(scene_name: StringName):
	get_tree().change_scene_to_file(scene_name)

func change_scene_to_packed(packed_scene: PackedScene):
	get_tree().change_scene_to_packed(packed_scene)

func change_scene_async(scene_name: StringName):
	current_scene_name = scene_name
	transition_out_scene(Strings.LOADING_SCENE)

func play_transition_in():
	show()
	animation_player.play("transition")

func play_transition_out():
	show()
	animation_player.play_backwards("transition")

#func _add_a_scene_manually(scene: Node):
	#get_tree().root.add_child(scene)

func _on_animation_player_animation_finished(anim_name):
	hide()
