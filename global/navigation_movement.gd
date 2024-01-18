extends Node
class_name NavigationMovement

@onready var navigation_agent_2d = $"../NavigationAgent2D"

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
	pass

func pick_new_state(moveInput: Vector2):
	pass
