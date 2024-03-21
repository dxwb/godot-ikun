class_name Effect
extends Resource

var _stat: Stat

@export var key := ""
@export var value := 0.0
@export_file("*.tscn") var scene_to_be_added := ""
@export var scene_params: Dictionary

var _scene: PackedScene
var _instance: Node

func apply(stat: Stat) -> void:
	_stat = stat
	_stat[key] += value

	if scene_to_be_added != "":
		_scene = load(scene_to_be_added)
		_instance = _scene.instantiate()

		# 传参给场景
		for k in scene_params:
			_instance[k] = scene_params[k]

		_stat.holder.add_child(_instance)

func unapply() -> void:
	_stat[key] -= value

	if _instance != null:
		_instance.queue_free()
