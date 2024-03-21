extends Node2D

@export var sprite: Sprite2D
@export var interval := .1
@export var duration := .5
@export var offset: Vector2

@export var disabled := false:
	set(val):
		disabled = val
		if val:
			_stop()
		else:
			_run()

var _tween: Tween

func _ready():
	if not disabled:
		_run()

func _run():
	_tween = create_tween().set_loops()
	_tween.tween_callback(_gen_trail).set_delay(interval)

func _stop():
	_tween.kill()

func _gen_trail():
	if disabled: return
	if sprite == null: return

	var sprite_duplicate = sprite.duplicate()
	var tween = create_tween()

	sprite_duplicate.global_position = global_position + offset
	sprite_duplicate.modulate = Color(randf(), randf(), randf())
	tween.tween_method(_tween_sprite.bind(sprite_duplicate), .5, 0, duration)
	get_tree().get_current_scene().add_child(sprite_duplicate)

	await tween.finished

	sprite_duplicate.queue_free()

func _tween_sprite(value: float, _sprite: Sprite2D):
	_sprite.modulate.a = value
