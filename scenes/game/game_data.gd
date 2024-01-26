extends Node

@onready var caught_chickens = $"../CanvasLayer/CountUI/CaughtChickens"
@onready var death_count:  = $"../CanvasLayer/CountUI/DeathCount"

func _ready():
	init()

func _on_player_died():
	SaverLoader.running_data.death_count += 1
	SaverLoader.save_game()
	death_count.set_count_num(SaverLoader.running_data.death_count)

func _on_kun_house_kun_entered(area):
	SaverLoader.running_data.caught_kuns += 1
	SaverLoader.save_game()
	caught_chickens.set_kuns_num(SaverLoader.running_data.caught_kuns)

func init():
	caught_chickens.set_kuns_num(SaverLoader.running_data.caught_kuns)
	death_count.set_count_num(SaverLoader.running_data.death_count)
