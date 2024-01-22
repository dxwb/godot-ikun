extends PanelContainer

@onready var label = $MarginContainer/HBoxContainer/Label

func _ready():
	DataManager.death_count_changed.connect(_on_death_count_changed)

func _process(delta):
	pass

func _on_death_count_changed(num: int):
	set_count_num(num)

func set_count_num(num: int):
	label.text = str(num)
