extends Node

@onready var slot_machine = %SlotMachine

const COST = 25

signal slot_machine_played(cost: int)

var rewards: Array[Dictionary] = []

func _ready():
	call_deferred("_init_slot_machine")

func _init_slot_machine():
	var cards = DatatableManager.get_data("cards")
	var images: Array[Texture2D] = []

	for key in cards:
		var card = cards[key]
		var texture = load(card.texture)
		images.push_back(texture)
		rewards.push_back(card)

	slot_machine.set_slot_images(images)

func _on_slot_machine_ui_opened():
	_init_slot_machine()
	slot_machine.disabled = SaverLoader.running_data.glod < COST

func _on_slot_machine_roll_stoped(result):
	_on_slot_machine_ui_opened()

	var reward_index = _get_reward_index(result)

	if reward_index == null: return

	var getting_card = rewards[reward_index]

	# 是否已拥有此卡片
	if SaverLoader.running_data.collected_cards.has(getting_card.name_id):
		slot_machine_played.emit(-COST * 2)
	else:
		slot_machine.loot_bag.drop_loot(getting_card)

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
