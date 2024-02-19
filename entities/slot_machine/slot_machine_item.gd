extends Panel

@export var speed = 500

@onready var row_1 = $Row
@onready var row_2 = $Row2

enum States {
	STOP,
	ROLLING,
}

const SIZE := 120
@warning_ignore("integer_division")
const HALF_SIZE := SIZE / 2

#var items: Array[Dictionary] = []
var state = States.STOP

var top_row: VBoxContainer:
	get:
		return row_1 if row_1.position.y < row_2.position.y else row_2

var bottom_row: VBoxContainer:
	get:
		return row_2 if row_1.position.y < row_2.position.y else row_1

signal stopped(index: int)

func run():
	state = States.ROLLING

func stop():
	_stop_roll()

func _process(delta):
	match state:
		States.STOP:
			pass
		States.ROLLING:
			_roll(delta)

func _stop_roll():
	var tween = create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT).set_parallel()
	var index = _get_index() - randi_range(1, 4)
	var target_index: int
	var final_y: int
	var distance: float
	var dur: float

	if index >= 0:
		target_index = index
		final_y = target_index * -60 + 30
		distance = -bottom_row.position.y + final_y
		dur = distance / speed + 1
		tween.tween_property(bottom_row, "position:y", final_y, dur)
		tween.tween_property(top_row, "position:y", final_y - 300, dur)
	else:
		target_index = 5 + index
		final_y = target_index * -60 + 30
		distance = -top_row.position.y + final_y
		dur = distance / speed + 1
		tween.tween_property(top_row, "position:y", final_y, dur)
		tween.tween_property(bottom_row, "position:y", final_y + 300, dur)

	state = States.STOP

	await tween.finished
	stopped.emit(target_index)

# 获取当前滚动中处于哪个项目
func _get_index() -> int:
	@warning_ignore("integer_division")
	var index = ceili((bottom_row.position.y - HALF_SIZE / 2) / -HALF_SIZE)
	return index

func _roll(delta):
	var y_velocity = speed * delta
	row_1.position.y += y_velocity
	row_2.position.y += y_velocity
	_reset_row_y()

func _reset_row_y():
	if bottom_row.position.y >= SIZE:
		bottom_row.position.y = top_row.position.y - 300
