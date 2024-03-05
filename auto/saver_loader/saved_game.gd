extends Resource
class_name SavedGame

# 赶鸡次数
@export var caught_kuns := 0

# 死亡次数
@export var death_count := 0

# 招鬼次数
@export var ghost_spawn_count := 0

# 撞击雪人次数
@export var snowman_hit_count := 0

# 已解锁的挑战
@export var challenges_completed: Array[StringName] = []

# 已收集的卡片
@export var collected_cards: Array[StringName] = []

# 商人是否已激活
@export var store_activated := false

# 是否已跟商人对话过
@export var store_interacted := false

# 老虎机是否已激活
@export var slot_machine_activated := false

# 当前拥有的金币
@export var glod := 0

# 累计交易的金币
@export var traded_glod := 0

# 累计摇奖的金币
@export var play_slot_machine_glod := 0
