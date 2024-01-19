extends Receiver

@export var sprite: Sprite2D

@onready var hurt_timer = $HurtTimer

signal hurted()

var hurting = false
# 施法时间
var time = 3.0

func _process(delta):
	if hurting:
		var ratio = hurt_timer.time_left / time
		sprite.modulate = Color(1, ratio, ratio)

# 开始受攻击
func _on_hurt_receiver_received(sender):
	hurting = true
	hurt_timer.start()

func _on_hurt_receiver_received_exited(sender):
	hurting = false
	hurt_timer.stop()
	sprite.modulate = Color.WHITE

# 受伤
func _on_hurt_timer_timeout():
	hurt_timer.start()
	emit_signal("hurted")
