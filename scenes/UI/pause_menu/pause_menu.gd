extends Control

@export var icon: Texture2D

@onready var tab_container = $TabContainer

func _ready():
	tab_container.set_tab_icon(0, icon)
	tab_container.set_tab_title(0, "")

func _process(delta):
	pass
