extends StaticBody2D

@export var kun_packed_scene: PackedScene

@onready var sprite_2d = $Sprite2D
@onready var spawn_timer = $SpawnTimer

func _ready():
	set_random_wait_time()
	spawn_timer.start()


func _process(delta):
	pass


func _on_area_2d_area_entered(area: Area2D):
	if (area.owner.has_method('enter_kun_house')):
		area.owner.enter_kun_house()
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, 'scale', Vector2(1.0, 1.5), .1)
	tween.tween_property(sprite_2d, 'scale', Vector2(1.0, 1.0), .5).set_trans(Tween.TRANS_BACK)

# 让小鸡从鸡舍里面逃出来
func _on_spawn_timer_timeout():
	var x = randi_range(-100, 100)
	var y = randi_range(50, 200)
	var pos = global_position + Vector2(x, y)
	var kun: Kun = kun_packed_scene.instantiate()
	kun.global_position = global_position
	kun.leave_kun_house(pos)
	get_tree().get_current_scene().add_child(kun)

	# 生成小鸡之后，设置随机时间
	set_random_wait_time()

func set_random_wait_time():
	spawn_timer.wait_time = randf_range(2.0, 5.0)
