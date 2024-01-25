extends Node

@onready var caught_chickens = $"../CanvasLayer/CountUI/CaughtChickens"
@onready var death_count:  = $"../CanvasLayer/CountUI/DeathCount"

func _ready():
	call_deferred("init")

func _on_player_died():
	DataManager.add_death_count()
	death_count.set_count_num(DataManager.data.DeathCount)

func _on_kun_house_kun_entered(area):
	DataManager.add_caught_kuns()
	caught_chickens.set_kuns_num(DataManager.data.CaughtKuns)

func init():
	caught_chickens.set_kuns_num(DataManager.data.CaughtKuns)
	death_count.set_count_num(DataManager.data.DeathCount)
