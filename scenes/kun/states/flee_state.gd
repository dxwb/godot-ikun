extends Node2D

@onready var movement = $"../Movement"
@onready var ray_cast_2d = $RayCast2D
@onready var timer = $Timer

const ANGLE_CONE_OF_VISION = deg_to_rad(120.0)
const MAX_VIEW_DISTANCE = 20
const ANGLE_BETWEEN_RAYS = deg_to_rad(5.0)

func _on_timer_timeout():
	movement.set_movement_target(find_target())

# 进入逃离状态
func _on_flee_state_entered():
	timer.start()
	movement.set_movement_target(find_target())

func _on_flee_state_exited():
	timer.stop()

# 寻找逃跑目标点
func find_target():
	var dir = get_direction()
	return owner.global_position + dir * randf_range(30, 50)

# 获取逃跑目标方向
func get_direction():
	# 玩家与kun的反方向
	var dir: Vector2 = (owner.global_position - owner.player.global_position).normalized()
	var flee_dir = null

	# 检测视椎体中是否有路走
	var rad = 0
	while (rad <= ANGLE_CONE_OF_VISION / 2):
		var offset_dir = dir.rotated(rad)
		set_ray_cast_point(offset_dir)

		# 没有碰撞时，设定为逃跑方向
		if (!ray_cast_2d.is_colliding()):
			flee_dir = offset_dir
			break

		var minus_offset_dir = dir.rotated(-rad)
		set_ray_cast_point(offset_dir)

		# 没有碰撞时，设定为逃跑方向
		if (!ray_cast_2d.is_colliding()):
			flee_dir = minus_offset_dir
			break

		rad += ANGLE_BETWEEN_RAYS

	# flee_dir为空，说明在视椎体内没有路走，另寻他路
	if (flee_dir == null):
		while (rad <= deg_to_rad(360.0) / 2):
			var offset_dir = dir.rotated(rad)
			set_ray_cast_point(offset_dir)

			# 没有碰撞时，设定为逃跑方向
			if (!ray_cast_2d.is_colliding()):
				flee_dir = offset_dir
				break

			var minus_offset_dir = dir.rotated(-rad)
			set_ray_cast_point(offset_dir)

			# 没有碰撞时，设定为逃跑方向
			if (!ray_cast_2d.is_colliding()):
				flee_dir = minus_offset_dir
				break

			rad += ANGLE_BETWEEN_RAYS

	# 如果四面八方没有路，等死
	if (flee_dir == null):
		flee_dir = Vector2.ZERO

	return flee_dir.normalized()

# 设置射线的目标点
func set_ray_cast_point(offset_dir):
	ray_cast_2d.target_position = offset_dir * MAX_VIEW_DISTANCE
	ray_cast_2d.force_raycast_update()
