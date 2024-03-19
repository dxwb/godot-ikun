extends CanvasLayer

@onready var glod_count_ui = %GlodCount
@onready var death_count_ui:  = %DeathCount
@onready var caught_chickens_ui = %CaughtChickens
@onready var ghost_spawn_count_ui = %GhostSpawnCount
@onready var snowman_hit_count_ui = %SnowmanHitCount

func _ready():
	SaverLoader.running_data.subscribe("glod", _on_glod_changed)
	SaverLoader.running_data.subscribe("death_count", _on_death_count_changed)
	SaverLoader.running_data.subscribe("ghost_spawn_count", _on_ghost_spawn_count_changed)
	SaverLoader.running_data.subscribe("snowman_hit_count", _on_snowman_hit_count_changed)
	SaverLoader.running_data.subscribe("caught_kuns", _on_caught_kuns_changed)
	_on_glod_changed(SaverLoader.running_data.glod)
	_on_death_count_changed(SaverLoader.running_data.death_count)
	_on_ghost_spawn_count_changed(SaverLoader.running_data.ghost_spawn_count)
	_on_snowman_hit_count_changed(SaverLoader.running_data.snowman_hit_count)
	_on_caught_kuns_changed(SaverLoader.running_data.caught_kuns)

func _on_glod_changed(value: int):
	glod_count_ui.set_num(value)

func _on_death_count_changed(value: int):
	death_count_ui.set_num(value)

func _on_ghost_spawn_count_changed(value: int):
	ghost_spawn_count_ui.set_num(value)

func _on_snowman_hit_count_changed(value: int):
	snowman_hit_count_ui.set_num(value)

func _on_caught_kuns_changed(value: int):
	caught_chickens_ui.set_num(value)
