extends Node

@onready var navigation_agent_2d = $"../NavigationAgent2D"
@onready var animation_tree = $"../AnimationTree"
@onready var state_machine = animation_tree["parameters/playback"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if navigation_agent_2d.is_navigation_finished():
		pick_new_state(Vector2.ZERO)
		set_animation(Vector2.ZERO)
		return

	var current_agent_position: Vector2 = owner.global_position
	var next_path_position: Vector2 = navigation_agent_2d.get_next_path_position()
	var dir = current_agent_position.direction_to(next_path_position)

	owner.velocity = dir * owner.movement_speed
	owner.move_and_slide()
	
	pick_new_state(dir)
	set_animation(dir)

func set_movement_target(movement_target: Vector2):
	navigation_agent_2d.target_position = movement_target

func set_animation(moveInput: Vector2):
	if (moveInput != Vector2.ZERO):
		animation_tree.set("parameters/idle/blend_position", moveInput.x)
		animation_tree.set("parameters/walk/blend_position", moveInput.x)

func pick_new_state(moveInput):
	if (moveInput != Vector2.ZERO):
		state_machine.travel('walk')
	else:
		state_machine.travel('idle')
