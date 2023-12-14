extends CharacterBody2D

@export var movement_speed = 120.0
@export var fireworksParticle: PackedScene

@onready var state_chart = $StateChart
@onready var movement = $Movement

var player = null

# 进入空闲状态
func _on_idle_state_entered():
	var transition_node = $"StateChart/Root/Idle/To Walking"
	transition_node.delay_seconds = randf_range(3.0, 5.0)

# 进入走路状态
func _on_walk_state_entered():
	var target = global_position + Vector2(randf_range(-50.0, 50.0), randf_range(-50.0, 50.0))
	movement.set_movement_target(target)

# 导航结束
func _on_navigation_agent_2d_navigation_finished():
	state_chart.send_event('walk_ended')

# 玩家进入警戒区域
func _on_area_2d_body_entered(body):
	player = body
	state_chart.send_event('player_entered')

# 玩家离开警戒区域
func _on_area_2d_body_exited(body):
	player = null
	state_chart.send_event('player_exited')

# 进入鸡窝
func enter_kun_house():
	DataManager.add_caught_kuns()
	queue_free()
	var fireworks: GPUParticles2D = fireworksParticle.instantiate()
	get_parent().add_child(fireworks)
	fireworks.global_position = global_position
	fireworks.emitting = true
