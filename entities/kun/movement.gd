extends NavigationMovement

@onready var animation_tree = $"../AnimationTree"
@onready var state_machine = animation_tree["parameters/playback"]

func set_animation(moveInput: Vector2):
	if (moveInput != Vector2.ZERO):
		state_machine.travel('walk')
		animation_tree.set("parameters/idle/blend_position", moveInput.x)
		animation_tree.set("parameters/walk/blend_position", moveInput.x)
	else:
		state_machine.travel('idle')
