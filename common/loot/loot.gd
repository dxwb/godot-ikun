extends Node2D

@export var move_speed = 200

var target: Area2D
var loot_data: Dictionary

func _process(delta):
	_move_to_target(delta)

func _on_pick_up_receiver_received_entered(sender: Area2D):
	target = sender

func _move_to_target(delta):
	if target == null: return

	if global_position.distance_to(target.global_position) < 5:
		queue_free()
		return

	var direction = (target.global_position - global_position).normalized()
	global_position += direction * move_speed * delta
