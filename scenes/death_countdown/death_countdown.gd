# 管理玩家的死亡倒计时
extends Timer

@export var time = 10

signal countdown_changed(time: int)
signal countdown_timeout()

var _time: int
var ui: DeathCountdownUI

func _ready():
	_time = time
	ui = get_tree().get_first_node_in_group("death_countdown_ui")

func _on_player_died():
	ui.show()
	ui.set_text(_time)
	start()

func _on_timeout():
	_time -= 1
	emit_signal("countdown_changed", _time)
	ui.set_text(_time)

	if _time == 0:
		_time = time
		stop()
		emit_signal("countdown_timeout")
	else:
		start()
