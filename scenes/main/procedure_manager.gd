extends Node

@onready var state_chart = $StateChart

var datatable_dics = {
	"kun_pictures": false
}

func _ready():
	DatatableManager.all_load_completed.connect(_on_datatable_manager_all_load_completed)

# 开始加载资源
func _on_loading_state_entered():
	DatatableManager.load_datatables(datatable_dics.keys())

func _on_datatable_manager_all_load_completed(data: Dictionary):
	print('已完成')
	print(data)
