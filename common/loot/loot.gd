extends Node2D

@export var move_speed = 200

@onready var pick_up_receiver = $PickUpReceiver

var target: Area2D
var loot_data: Dictionary

func _ready():
	throw()

func _process(delta):
	_move_to_target(delta)

func _on_pick_up_receiver_received_entered(sender: Area2D):
	target = sender

func _move_to_target(delta):
	if target == null: return

	if global_position.distance_to(target.global_position) < 5:
		BackpackManager.add_loot(loot_data)
		queue_free()
		return

	var direction = (target.global_position - global_position).normalized()
	global_position += direction * move_speed * delta

func throw():
	var tween = create_tween()

	tween.tween_property(self, "position:y", position.y - 10, .1).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y", position.y, .1).set_ease(Tween.EASE_IN)

	await tween.finished
	
	pick_up_receiver.visible = true
