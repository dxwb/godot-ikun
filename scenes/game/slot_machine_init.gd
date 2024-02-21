extends Node

@onready var slot_machine = %SlotMachine

const COST = 25

signal slot_machine_played(cost: int)

var rewards: Array[Dictionary] = []

func _ready():
	var cards = DatatableManager.get_data("cards")
	var images: Array[Texture2D] = []

	for key in cards:
		var card = cards[key]
		var texture = load(card.texture)
		images.push_back(texture)
		rewards.push_back(card)

	slot_machine.set_slot_images(images)

func _on_slot_machine_ui_opened():
	slot_machine.disabled = SaverLoader.running_data.glod < COST

func _on_slot_machine_roll_stoped(result):
	_on_slot_machine_ui_opened()

	var reward_index = _get_reward_index(result)

	if reward_index == null: return
	
	print("获得奖励")
	print(rewards[reward_index])

func _get_reward_index(arr: Array[int]):
	var tmp = []
	for i in arr:
		if tmp.has(i):
			return i
		else:
			tmp.push_back(i)

	return null

func _on_handler_pressed():
	if SaverLoader.running_data.glod < COST:
		print("钱不够")
		return

	slot_machine_played.emit(COST)
