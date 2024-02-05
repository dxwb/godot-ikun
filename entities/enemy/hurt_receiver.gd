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
	# 因为目前角色是一击必杀，所以暂时这样写
	# 受伤后解除受击，防止角色死亡后仍然有受击的效果
	hurting = false
	sprite.modulate = Color.WHITE
	#hurt_timer.start()
	emit_signal("hurted")
