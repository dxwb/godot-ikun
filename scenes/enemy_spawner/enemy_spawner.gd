extends Node

@export var enemy_packed_scene: PackedScene

var kun_count = 0

# 实现本次小鸡进入鸡窝10只后，出现敌人
func on_kun_entered_to_house(area: Area2D):
	kun_count += 1

	if kun_count == 1:
		var enemy = enemy_packed_scene.instantiate()
		enemy.global_position = get_random_position()
		get_tree().get_current_scene().call_deferred("add_child", enemy)

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
