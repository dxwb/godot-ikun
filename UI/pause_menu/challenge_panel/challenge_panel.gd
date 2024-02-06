extends MenuPanel

@export var item_scene: PackedScene

@onready var grid_container = %GridContainer

func render():
	var challenges = DatatableManager.get_data("challenges")

	for child in grid_container.get_children():
		child.queue_free()

	for chal_id in challenges:
		var chal_data = challenges[chal_id]
		var item = item_scene.instantiate()

		grid_container.add_child(item)

		var check = SaverLoader.running_data.challenges_completed.has(chal_id)
		item.call_deferred("set_challenge", chal_data)
		item.call_deferred("set_check", check)
