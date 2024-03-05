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

var images: Array[Texture2D] = []

var row_size: int:
	get:
		return images.size() * HALF_SIZE

var state = States.STOP

var top_row: VBoxContainer:
	get:
		return row_1 if row_1.position.y < row_2.position.y else row_2

var bottom_row: VBoxContainer:
	get:
		return row_2 if row_1.position.y < row_2.position.y else row_1

signal stopped(index: int)

func _process(delta):
	match state:
		States.STOP:
			pass
		States.ROLLING:
			_roll(delta)

func row_init():
	for item in row_1.get_children():
		item.queue_free()

	for item in row_2.get_children():
		item.queue_free()

	for img in images:
		var texture_rect1 = TextureRect.new()

		texture_rect1.texture = img
		texture_rect1.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
		texture_rect1.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect1.use_parent_material = true

		var texture_rect2 = texture_rect1.duplicate(DUPLICATE_USE_INSTANTIATION)

		row_1.add_child(texture_rect1)
		row_2.add_child(texture_rect2)

	row_1.position.y = row_2.position.y - row_size

func run():
	state = States.ROLLING

func stop():
	_stop_roll()

func _stop_roll():
	var tween = create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT).set_parallel()
	var rdm = randi_range(1, images.size())
	var index = _get_index() - rdm
	var target_index: int# 经过处理的index，不会存在负数情况
	var final_y: float
	var distance: float
	var dur: float

	if index >= 0:
		target_index = index
		final_y = target_index * -HALF_SIZE + float(HALF_SIZE) / 2
		distance = -bottom_row.position.y + final_y
		# 计算停下来所需时间
		dur = distance / speed + 1
		tween.tween_property(bottom_row, "position:y", final_y, dur)
		tween.tween_property(top_row, "position:y", final_y - row_size, dur)
	else:
		target_index = images.size() + index
		final_y = target_index * -HALF_SIZE + float(HALF_SIZE) / 2
		distance = -top_row.position.y + final_y
		dur = distance / speed + 1
		tween.tween_property(top_row, "position:y", final_y, dur)
		tween.tween_property(bottom_row, "position:y", final_y + row_size, dur)

	state = States.STOP

	await tween.finished
	stopped.emit(target_index)

# 获取当前滚动中处于哪个项目，可能是负数
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
		bottom_row.position.y = top_row.position.y - row_size
