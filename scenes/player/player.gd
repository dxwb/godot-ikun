extends CharacterBody2D

@export var speed = 100.0

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree["parameters/playback"]
@onready var smokeParticle = $Smoke

func _physics_process(delta):
	var dir = Input.get_vector('walk_left', 'walk_right', 'walk_up', 'walk_down').normalized()
	velocity = dir * speed
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

#func _input(event):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#set_walk_particle(Vector2.UP)

func set_animation(moveInput):
	if (moveInput != Vector2.ZERO):
		animation_tree.set("parameters/idle/blend_position", moveInput)
		animation_tree.set("parameters/walk/blend_position", moveInput)

func pick_new_state(moveInput):
	if (moveInput != Vector2.ZERO):
		state_machine.travel('walk')
	else:
		state_machine.travel('idle')
