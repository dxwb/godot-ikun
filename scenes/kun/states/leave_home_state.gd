extends Node2D

@onready var kun = $".."
@onready var movement = $"../Movement"
@onready var state_chart = $"../StateChart"

var active = false

func _on_leave_home_state_entered():
	active = true
	movement.set_movement_target(kun.leave_home_target)


func _on_navigation_agent_2d_navigation_finished():
	if active:
		active = false
		kun.leave_kun_house_finished()
		state_chart.send_event('leave_home_ended')
