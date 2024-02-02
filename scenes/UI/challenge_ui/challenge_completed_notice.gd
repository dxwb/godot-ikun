extends Control

@onready var texture_rect = %TextureRect
@onready var label = %Label

func _ready():
	ChallengeService.challenge_completed.connect(_on_challenge_completed)

func _exit_tree():
	ChallengeService.challenge_completed.disconnect(_on_challenge_completed)

func _on_challenge_completed(chal_data: Dictionary):
	texture_rect.texture = load(chal_data.texture)
	label.text = chal_data.title
