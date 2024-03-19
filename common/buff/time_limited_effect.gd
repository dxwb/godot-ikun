extends Effect
class_name TimeLimitedEffect

@export var duration := 0.0

func apply(stat: Stat) -> void:
	super.apply(stat)
	await _stat.get_tree().create_timer(duration).timeout
	_stat.remove_effect(self)
