extends CharacterBody2D
class_name Enemy

@export var movement_speed = 50.0

@onready var animation_player = $AnimationPlayer

var player: Player
var lastMoveInput: Vector2
# 出生点
var birth_point: Vector2
var is_chasing = true

func _ready():
	birth_point = global_position
	player = get_tree().get_first_node_in_group("player")
	player.died.connect(_on_player_died)

func _physics_process(delta):
	var direction = Vector2.ZERO

	if not is_chasing:
		direction = (birth_point - global_position).normalized()
	elif player.global_position.distance_to(global_position) > 5.0:
		direction = (player.global_position - global_position).normalized()

	velocity = direction * movement_speed
	move_and_slide()
	set_animation(direction)

func set_animation(moveInput: Vector2):
	if (moveInput != Vector2.ZERO):
		animation_player.play("walk_right" if moveInput.x > 0 else "walk_left")
		lastMoveInput = moveInput
	else:
		animation_player.play("idle_right" if lastMoveInput.x > 0 else "idle_left")

func _on_player_died():
	leave_scene()

func leave_scene():
	is_chasing = false

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
