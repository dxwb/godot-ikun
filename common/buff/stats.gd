extends Node
class_name Stat

var effects: Array[Effect] = []

# 移动速度
@export var stat_speed := 0.0
@export var stat_percent_speed := 0.0

# 捕虫网
@export var bug_net := 0

@onready var holder = get_parent()

func add_effect(effect: Effect):
	effects.push_back(effect)
	effect.apply(self)

func remove_effect(effect: Effect):
	effects.erase(effect)
	effect.unapply()
