extends Node2D

var target: Area2D

func _process(delta):
	pass

func _on_pick_up_receiver_received_entered(sender: Area2D):
	target = sender
