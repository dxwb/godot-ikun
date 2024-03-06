extends Control

@export var disabled = false:
	set(value):
		disabled = value
		handler.mouse_default_cursor_shape = CURSOR_FORBIDDEN if value else CURSOR_POINTING_HAND

@onready var handler = %Handler
@onready var disabled_tip = %DisabledTip
@onready var handler_texture = handler.texture_normal as AtlasTexture
@onready var items = [%SlotMachineItem, %SlotMachineItem2, %SlotMachineItem3]
@onready var play_sound = $Sounds/PlaySound

var running := false
var result: Array[int] = []

signal started()
signal stopped(result: Array[int])
signal opened()
signal closed()

#var test = [
	#"res://assets/card_textures/01_1.jpg",
	#"res://assets/card_textures/02_3.jpg",
	#"res://assets/card_textures/04_3.jpg",
	#"res://assets/card_textures/05_4.jpg",
	#"res://assets/card_textures/07_1.jpg",
	#"res://assets/card_textures/08_2.jpg",
	#"res://assets/card_textures/09_4.jpg",
	#"res://assets/card_textures/11_4.jpg",
	#"res://assets/card_textures/13_1.jpg",
	#"res://assets/card_textures/14_2.jpg"
#]
#func _ready():
	#var images: Array[Texture2D] = []
#
	#for t in test:
		#var texture = load(t)
		#images.push_back(texture)
#
	#set_slot_images(images)

func run():
	if running: return

	handler_texture.region.position = Vector2(92, 0)
	running = true
	result = []

	var tween = create_tween()
	var duration = randf_range(1, 3)

	for i in items.size():
		var item = items[i]
		item.run()
		tween.tween_callback(item.stop).set_delay(duration if i == 0 else 0.5)

	started.emit()
	play_sound.play()

func open():
	visible = true
	opened.emit()

func close():
	visible = false

func set_slot_images(images: Array[Texture2D]):
	for item in items:
		item.images = images
		item.row_init()

func _on_handler_pressed():
	if disabled: return

	run()

func _on_slot_machine_item_stopped(index):
	result.push_back(index)

	if result.size() == 3:
		handler_texture.region.position = Vector2.ZERO
		running = false
		stopped.emit(result)

func _on_close_button_pressed():
	close()
	closed.emit()

func _on_handler_mouse_entered():
	if not disabled: return

	var tween = create_tween()
	disabled_tip.visible = true
	tween.tween_property(disabled_tip, "modulate:a", 1, .1)

func _on_handler_mouse_exited():
	if not disabled_tip.visible: return

	var tween = create_tween()
	tween.tween_property(disabled_tip, "modulate:a", 0, .1)

	await tween.finished

	disabled_tip.visible = false
