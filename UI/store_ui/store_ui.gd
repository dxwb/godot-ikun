extends Control

@onready var caught_chickens_ui = %StoreItem/SpinBox
@onready var ghost_spawn_count_ui = %StoreItem2/SpinBox
@onready var death_count_ui = %StoreItem3/SpinBox
@onready var snowman_hit_count_ui = %StoreItem4/SpinBox
@onready var label = %Label

var caught_chickens_price = 5
var ghost_spawn_count_price = 10
var death_count_price = 20
var snowman_hit_count_price = 2

var caught_chickens_amount = 0
var ghost_spawn_count_amount = 0
var death_count_amount = 0
var snowman_hit_count_amount = 0

signal traded(amount: float)
signal closed()

func _ready():
	caught_chickens_ui.value_changed.connect(_on_caught_chicken_changed)
	ghost_spawn_count_ui.value_changed.connect(_on_ghost_spawn_count_changed)
	death_count_ui.value_changed.connect(_on_death_count_changed)
	snowman_hit_count_ui.value_changed.connect(_on_snowman_hit_count_changed)

func _on_snowman_hit_count_changed(value: float):
	snowman_hit_count_amount = value * snowman_hit_count_price
	set_total_amount()

func _on_death_count_changed(value: float):
	death_count_amount = value * death_count_price
	set_total_amount()

func _on_ghost_spawn_count_changed(value: float):
	ghost_spawn_count_amount = value * ghost_spawn_count_price
	set_total_amount()

func _on_caught_chicken_changed(value: float):
	caught_chickens_amount = value * caught_chickens_price
	set_total_amount()

func set_total_amount():
	label.text = "=" + str(caught_chickens_amount + ghost_spawn_count_amount + death_count_amount + snowman_hit_count_amount)

func _set_max_value():
	caught_chickens_ui.max_value = SaverLoader.running_data.caught_kuns
	ghost_spawn_count_ui.max_value = SaverLoader.running_data.ghost_spawn_count
	death_count_ui.max_value = SaverLoader.running_data.death_count
	snowman_hit_count_ui.max_value = SaverLoader.running_data.snowman_hit_count

func _reset_value():
	caught_chickens_ui.set_value(0)
	ghost_spawn_count_ui.set_value(0)
	death_count_ui.set_value(0)
	snowman_hit_count_ui.set_value(0)

func _on_button_pressed():
	traded.emit(caught_chickens_amount + ghost_spawn_count_amount + death_count_amount + snowman_hit_count_amount)

func open():
	visible = true
	_set_max_value()
	_reset_value()

func close():
	visible = false
	closed.emit()

func _on_close_button_pressed():
	close()
