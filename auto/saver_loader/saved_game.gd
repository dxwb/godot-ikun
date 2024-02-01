extends Resource
class_name SavedGame

# 赶鸡次数
@export var caught_kuns := 0

# 死亡次数
@export var death_count := 0

@export var challenges_completed: Array[StringName] = []
