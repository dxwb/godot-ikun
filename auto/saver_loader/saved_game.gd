extends Resource
class_name SavedGame

# 赶鸡次数
@export var caught_kuns := 0

# 死亡次数
@export var death_count := 0

# 招鬼次数
@export var ghost_spawn_count := 0

# 已解锁的挑战
@export var challenges_completed: Array[StringName] = []

# 已收集的卡片
@export var collected_cards: Array[StringName] = []
