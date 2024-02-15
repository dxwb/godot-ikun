extends CharacterBody2D
class_name Player

@export var speed = 100.0

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree["parameters/playback"]
@onready var smokeParticle = $Smoke
@onready var bloodParticle = $Blood
@onready var current_speed = speed

var disabled_move = false

signal died()

var is_alive = true
var birth_point: Vector2

func _ready():
	birth_point = global_position

func _physics_process(delta):
	if not is_alive: return

	if disabled_move: return

	var dir = Input.get_vector('walk_left', 'walk_right', 'walk_up', 'walk_down').normalized()
	velocity = dir * current_speed
	move_and_slide()
	pick_new_state(dir)
	set_animation(dir)
	set_walk_particle(dir)
	set_smoke_z_index(dir)

func set_smoke_z_index(moveInput):
	if (smokeParticle.emitting):
		smokeParticle.z_index = 0 if moveInput.y >= 0 else 1

func set_walk_particle(moveInput):
	smokeParticle.emitting = moveInput != Vector2.ZERO

func set_animation(moveInput):
	if (moveInput != Vector2.ZERO):
		animation_tree.set("parameters/idle/blend_position", moveInput)
		animation_tree.set("parameters/walk/blend_position", moveInput)

func pick_new_state(moveInput):
	if (moveInput != Vector2.ZERO):
		state_machine.travel('walk')
	else:
		state_machine.travel('idle')

func _on_hurt_receiver_hurted():
	dead()
	emit_signal("died")

func dead():
	is_alive = false
	bloodParticle.emitting = true
	state_machine.travel('dead')
	set_collision_layer_value(2, false)
	set_walk_particle(Vector2.ZERO)

# 复活
func resuscitate():
	is_alive = true
	set_collision_layer_value(2, true)
	global_position = birth_point
