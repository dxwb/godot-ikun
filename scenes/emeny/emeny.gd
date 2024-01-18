extends CharacterBody2D

@export var player: Player

@onready var movement = $Movement

var timer = 1.0

func _process(delta):
	if timer < 0:
		movement.set_movement_target(player.global_position)

	timer -= delta
