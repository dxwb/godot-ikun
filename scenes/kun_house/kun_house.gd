extends StaticBody2D

@onready var sprite_2d = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area: Area2D):
	if (area.owner.has_method('enter_kun_house')):
		area.owner.enter_kun_house()
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, 'scale', Vector2(1.0, 1.5), .1)
	tween.tween_property(sprite_2d, 'scale', Vector2(1.0, 1.0), .5).set_trans(Tween.TRANS_BACK)
