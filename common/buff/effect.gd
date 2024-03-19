class_name Effect
extends Resource

var _stat: Stat

@export var key := ""
@export var value := 0.0

func apply(stat: Stat) -> void:
	_stat = stat
	_stat[key] += value

func unapply() -> void:
	_stat[key] -= value
