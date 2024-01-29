extends Node

@export_dir var datatable_path: String
@export var delim = ","
@export var can_async = true

signal load_completed(datatable_name: String, data: Dictionary)
signal all_load_completed(data: Dictionary)

var thread := Thread.new()
var _datatable_dics = {}

func _exit_tree():
	thread.wait_to_finish()

func load_datatables(datatable_names: PackedStringArray) -> void:
	if can_async:
		thread.start(_load_datatables.bind(datatable_names))
		#var ret = thread.wait_to_finish()
		#for name in datatable_names:
			#var data = ret[name]
			#load_completed.emit(name, data)
	else:
		_load_datatables(datatable_names)

func _load_datatables(datatable_names: PackedStringArray) -> void:
	for name in datatable_names:
		var data = _load_datatable(name)
		load_completed.emit(name, data)
	all_load_completed.emit(_datatable_dics)

# 加载数据表
func _load_datatable(datatable_name: String) -> Dictionary:
	var full_name = datatable_path + '/' + datatable_name + ".csv"

	assert(FileAccess.file_exists(full_name), "文件不存在！")

	var file = FileAccess.open(full_name, FileAccess.READ)
	var result = {}

	# csv数据解析
	var data_name: PackedStringArray = file.get_csv_line(delim)
	var desc: PackedStringArray = file.get_csv_line(delim)
	var type_name: PackedStringArray = file.get_csv_line(delim)

	while not file.eof_reached():
		var raw_row_data = file.get_csv_line(delim)
		var row = {}

		for i in raw_row_data.size():
			var _d_name: StringName = data_name[i]
			var _d_desc: StringName = desc[i]
			var _d_type: StringName = type_name[i]

			match _d_type:
				"int":
					row[_d_name] = raw_row_data[i].to_int() if raw_row_data[i] != "" else 0
				"string":
					row[_d_name] = raw_row_data[i]

		if not row.is_empty():
			result[StringName(row["ID"])] = row

	_datatable_dics[datatable_name] = result

	return result
