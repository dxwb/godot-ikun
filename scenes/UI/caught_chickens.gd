extends PanelContainer

@onready var label = $MarginContainer/HBoxContainer/Label

func _ready():
	DataManager.caught_kuns_changed.connect(_on_caught_kuns_changed)

func _process(delta):
	pass

func _on_caught_kuns_changed(num: int):
	set_kuns_num(num)

func set_kuns_num(num: int):
	label.text = str(num)
