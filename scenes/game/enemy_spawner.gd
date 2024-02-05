extends Node

@export var enemy_packed_scene: PackedScene
@export var gradient: Array[int]

signal enemy_spawned(enemy: Enemy)

var kun_count = 0
var index = 0
var current_enemy: Enemy# 确保场景中只有一个敌人

# 实现本次小鸡进入鸡窝10只后，出现敌人
func on_kun_entered_to_house(area: Area2D):
	kun_count += 1

	# 赶鸡数量大于下一个梯度的一半时，敌人退出场景
	if current_enemy != null and kun_count >= gradient[index] / 2:
		current_enemy.leave_scene()
		current_enemy = null

	if kun_count == gradient[index]:
		var enemy = enemy_packed_scene.instantiate()
		enemy.global_position = get_random_position()
		get_tree().get_current_scene().call_deferred("add_child", enemy)

		current_enemy = enemy
		kun_count = 0

		if index + 1 < gradient.size():
			index += 1

		enemy_spawned.emit(enemy)

# 获取屏幕外随机坐标
func get_random_position():
	var viewport = get_viewport()
	var origin = viewport.global_canvas_transform.get_origin()
	var size = viewport.get_visible_rect().size
	# 屏幕外这个范围内随机生成
	var base_x = randi_range(30, 100) + origin.x
	var base_y = randi_range(30, 100) + origin.y
	# 在屏幕的右边或左边，上边或下边
	var arr = [-1, 1]
	var is_right = arr[randi_range(0, 1)] > 0
	var is_bottom = arr[randi_range(0, 1)] > 0
	var x = (base_x + size.x) if is_right else (base_x * -1)
	var y = (base_y + size.y) if is_bottom else (base_y * -1)

	return Vector2(x, y)
