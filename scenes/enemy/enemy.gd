extends CharacterBody2D

@onready var movement = $Movement

var timer = 1.0
var player: Player

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _process(delta):
	if timer < 0:
		movement.set_movement_target(player.global_position)

	timer -= delta
