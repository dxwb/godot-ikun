extends Node

@onready var slot_machine = %SlotMachine

func _ready():
	var cards = DatatableManager.get_data("cards")
	var images: Array[Texture2D] = []

	for key in cards:
		var card = cards[key]
		var texture = load(card.texture)
		images.push_back(texture)

	slot_machine.set_slot_images(images)
