extends MenuPanel

@onready var grid_container = %GridContainer
@export var item_scene: PackedScene

func render_challenges():
	var challenges = DatatableManager.get_data("kun_pictures")

	for child in grid_container.get_children():
		child.queue_free()

	for chal_id in challenges:
		var chal_data = challenges[chal_id]
		var item = item_scene.instantiate()

		item.call_deferred("set_challenge", chal_data)
		grid_container.add_child(item)
