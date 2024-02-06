extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var loot_bag = $LootBag

func _on_body_entered(body):
	animation_player.play("swing")
	# 小概率出卡片
	var f = randf()
	if f < .2:
		loot_bag.drop()
	
