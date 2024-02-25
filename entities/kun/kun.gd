extends CharacterBody2D
class_name Kun

@export var fireworksParticle: PackedScene

@onready var state_chart = $StateChart
@onready var movement = $Movement
@onready var flee_area = $FleeArea
@onready var kun_house_receiver = $KunHouseReceiver
@onready var scare_sound = $Sounds/ScareSound

var player = null
var leave_home_target: Vector2

# 进入空闲状态
func _on_idle_state_entered():
	var transition_node = $"StateChart/Root/Idle/To Walking"
	transition_node.delay_seconds = randf_range(3.0, 5.0)

var is_walking = false

# 进入走路状态
func _on_walk_state_entered():
	var target = global_position + Vector2(randf_range(-50.0, 50.0), randf_range(-50.0, 50.0))
	movement.set_movement_target(target)
	is_walking = true

# 导航结束
func _on_navigation_agent_2d_navigation_finished():
	if is_walking:
		is_walking = false
		state_chart.send_event('walk_ended')

# 玩家进入警戒区域
func _on_area_2d_body_entered(body):
	player = body
	state_chart.send_event('player_entered')
	scare_sound.play()

# 玩家离开警戒区域
func _on_area_2d_body_exited(body):
	player = null
	state_chart.send_event('player_exited')

# 进入鸡窝
func on_kun_house_received(area: Area2D):
	queue_free()
	var fireworks: GPUParticles2D = fireworksParticle.instantiate()
	get_parent().add_child(fireworks)
	fireworks.global_position = global_position
	fireworks.emitting = true

# 进入出逃状态
func enter_leave_home():
	state_chart.send_event('leave_home_entered')

# 逃出鸡窝
func _leave_kun_house(pos: Vector2):
	# 逃出时不应被进入鸡窝的area检测到
	kun_house_receiver.monitorable = false
	# 不应检测玩家
	flee_area.monitoring = false
	# 设置出逃目标点
	leave_home_target = pos
	call_deferred('enter_leave_home')

func leave_kun_house(pos: Vector2):
	call_deferred('_leave_kun_house', pos)

# 逃出到目标地点，恢复组件状态
func leave_kun_house_finished():
	kun_house_receiver.monitorable = true
	flee_area.monitoring = true
