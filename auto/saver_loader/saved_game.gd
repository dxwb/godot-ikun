extends Resource
class_name SavedGame

# 赶鸡次数
@export var caught_kuns := 0:
	set(val):
		caught_kuns = val
		_emit("caught_kuns", val)

# 死亡次数
@export var death_count := 0:
	set(val):
		death_count = val
		_emit("death_count", val)

# 招鬼次数
@export var ghost_spawn_count := 0:
	set(val):
		ghost_spawn_count = val
		_emit("ghost_spawn_count", val)

# 撞击雪人次数
@export var snowman_hit_count := 0:
	set(val):
		snowman_hit_count = val
		_emit("snowman_hit_count", val)

# 已解锁的挑战
@export var challenges_completed: Array[StringName] = []:
	set(val):
		challenges_completed = val
		_emit("challenges_completed", val)

# 已收集的卡片
@export var collected_cards: Array[StringName] = []:
	set(val):
		collected_cards = val
		_emit("collected_cards", val)

# 商人是否已激活
@export var store_activated := false:
	set(val):
		store_activated = val
		_emit("store_activated", val)

# 是否已跟商人对话过
@export var store_interacted := false:
	set(val):
		store_interacted = val
		_emit("store_interacted", val)

func set_store_interacted_true():
	store_interacted = true

# 老虎机是否已激活
@export var slot_machine_activated := false:
	set(val):
		slot_machine_activated = val
		_emit("slot_machine_activated", val)

# 当前拥有的金币
@export var glod := 0:
	set(val):
		glod = val
		_emit("glod", val)

# 累计交易的金币
@export var traded_glod := 0:
	set(val):
		traded_glod = val
		_emit("traded_glod", val)

# 累计摇奖的金币
@export var play_slot_machine_glod := 0:
	set(val):
		play_slot_machine_glod = val
		_emit("play_slot_machine_glod", val)

func subscribe(property_key: String, fn: Callable):
	var signal_name = _get_signal_name(property_key)

	_add_signal(signal_name)
	connect(signal_name, fn)

func _get_signal_name(property_key: String) -> String:
	return property_key + "_changed"

func _emit(property_key: String, value: Variant):
	var signal_name = _get_signal_name(property_key)

	_add_signal(signal_name)
	emit_signal(signal_name, value)

func _add_signal(signal_name: String):
	if not has_user_signal(signal_name):
		add_user_signal(signal_name)
