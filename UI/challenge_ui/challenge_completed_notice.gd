extends Control

@export var display_duration: float = 3.0

@onready var panel_container = %PanelContainer
@onready var texture_rect = %TextureRect
@onready var label = %Label
@onready var timer = $Timer

var chal_queue: Array[Dictionary] = []
var animation_running := false

signal slide_out_ended()

func _ready():
	ChallengeService.challenge_completed.connect(_on_challenge_completed)

func _exit_tree():
	ChallengeService.challenge_completed.disconnect(_on_challenge_completed)

func _on_challenge_completed(chal_data: Dictionary):
	chal_queue.push_back(chal_data)
	_each_display()

func _each_display():
	if animation_running: return

	animation_running = true
	show()

	while chal_queue.size() > 0:
		await _display(chal_queue.pop_front())

	animation_running = false
	hide()

func _display(chal_data: Dictionary):
	texture_rect.texture = load(chal_data.texture)
	label.text = chal_data.title
	# 播放动画
	var tween = create_tween()
	var pos = panel_container.position

	tween.tween_property(panel_container, 'position', Vector2(pos.x, 10.0), .5)

	await tween.finished

	timer.start(display_duration)

	await timer.timeout

	var tween2 = create_tween()
	tween2.tween_property(panel_container, 'position', pos, .5)

	await tween2.finished

	slide_out_ended.emit()
