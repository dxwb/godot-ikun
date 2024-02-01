extends Node

@onready var state_chart = $StateChart

signal begin_game()

var datatable_names = ["kun_pictures"]

func _ready():
	DatatableManager.all_load_completed.connect(_on_datatable_manager_all_load_completed)

# 开始加载资源
func _on_loading_state_entered():
	DatatableManager.load_datatables(datatable_names)

# 开始加载资源完毕
func _on_datatable_manager_all_load_completed(data: Dictionary):
	_dispatch_data()
	state_chart.send_event("loaded")

# 为各个系统派发数据
func _dispatch_data():
	ChallengeService.challenges = DatatableManager.get_data("kun_pictures")

# 开始游戏
func _on_begin_game_state_entered():
	begin_game.emit()
