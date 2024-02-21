extends Control

@onready var handler = %Handler
@onready var handler_texture = handler.texture_normal as AtlasTexture
@onready var items = [%SlotMachineItem, %SlotMachineItem2, %SlotMachineItem3]

var running := false
var result: Array[int] = []

signal stopped(result: Array[int])
signal closed()

func run():
	if running: return

	handler_texture.region.position = Vector2(92, 0)
	running = true
	result = []

	var tween = create_tween()

	for i in items.size():
		var item = items[i]
		item.run()
		tween.tween_callback(item.stop).set_delay(3.0 if i == 0 else 0.5)

func open():
	visible = true

func close():
	visible = false

func set_slot_images(images: Array[Texture2D]):
	for item in items:
		item.images = images
		item.row_init()

func _on_handler_pressed():
	run()

func _on_slot_machine_item_stopped(index):
	result.push_back(index)

	if result.size() == 3:
		handler_texture.region.position = Vector2.ZERO
		running = false
		print(result)
		stopped.emit(result)

func _on_close_button_pressed():
	close()
	closed.emit()
