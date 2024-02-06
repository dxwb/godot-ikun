extends MenuPanel

@export var item_scene: PackedScene
@export var card_scene: PackedScene

@onready var grid_container = %GridContainer

var ui_root: CanvasLayer

func _ready():
	ui_root = get_tree().get_first_node_in_group("ui_canvas_layer")

func render():
	var challenges = DatatableManager.get_data("challenges")

	for child in grid_container.get_children():
		child.queue_free()

	for chal_id in challenges:
		var chal_data = challenges[chal_id]
		var item = item_scene.instantiate()

		item.click.connect(_on_challenge_item_click.bind(chal_data))
		grid_container.add_child(item)

		var check = SaverLoader.running_data.challenges_completed.has(chal_id)
		item.call_deferred("set_challenge", chal_data)
		item.call_deferred("set_check", check)

func _on_challenge_item_click(chal_data: Dictionary):
	var card = card_scene.instantiate()

	ui_root.add_child(card)

	card.call_deferred("set_challenge", chal_data)
