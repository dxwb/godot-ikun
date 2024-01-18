extends NavigationMovement

@onready var animation_player = $"../AnimationPlayer"

var lastMoveInput: Vector2

func set_animation(moveInput: Vector2):
	if (moveInput != Vector2.ZERO):
		animation_player.play("walk_right" if moveInput.x > 0 else "walk_left")
		lastMoveInput = moveInput
	else:
		animation_player.play("idle_right" if lastMoveInput.x > 0 else "idle_left")
