extends Control

@export var disabled = false:
	set(value):
		disabled = value
		handler.mouse_default_cursor_shape = CURSOR_FORBIDDEN if value else CURSOR_POINTING_HAND

@onready var handler = %Handler
@onready var handler_texture = handler.texture_normal as AtlasTexture
@onready var items = [%SlotMachineItem, %SlotMachineItem2, %SlotMachineItem3]
@onready var play_sound = $Sounds/PlaySound

var running := false
var result: Array[int] = []

signal stopped(result: Array[int])
signal closed()

#var test = [
	#"res://assets/kun_pictures/01_1.jpg",
	#"res://assets/kun_pictures/02_3.jpg",
	#"res://assets/kun_pictures/04_3.jpg",
	#"res://assets/kun_pictures/05_4.jpg",
	#"res://assets/kun_pictures/07_1.jpg",
	#"res://assets/kun_pictures/08_2.jpg",
	#"res://assets/kun_pictures/09_4.jpg",
	#"res://assets/kun_pictures/11_4.jpg",
	#"res://assets/kun_pictures/13_1.jpg",
	#"res://assets/kun_pictures/14_2.jpg"
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

	play_sound.play()

func open():
	visible = true

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
