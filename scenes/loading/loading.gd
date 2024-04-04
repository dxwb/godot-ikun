extends Node2D

@onready var progress_bar = %ProgressBar

var scene_path: StringName
var progress: Array
var update := 0.0

func _ready():
	scene_path = SceneManager.current_scene_name
	ResourceLoader.load_threaded_request(scene_path)

func _process(delta):
	ResourceLoader.load_threaded_get_status(scene_path, progress)

	if progress_bar.value >= 100:
		var packed_scene = ResourceLoader.load_threaded_get(scene_path)
		SceneManager.change_scene_to_packed(packed_scene)
		SceneManager.play_transition_in()

	if progress[0] > update:
		update = progress[0]

	if progress_bar.value < update * 100:
		progress_bar.value += delta * 100
