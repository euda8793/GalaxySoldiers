extends Node2D
class_name Reticle

@onready
var sprite := $AnimatedSprite2D as AnimatedSprite2D

var tween : Tween

func _ready():
	var x_offset = get_viewport_rect().size.x / 2.0
	var y_offset = get_viewport_rect().size.y / 2.0
	position = Vector2(x_offset, y_offset)

func start():
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(sprite, "frame", 5, 0.3)
	
	tween.kill()
	tween = get_tree().create_tween()
	tween.set_loops()
	tween.tween_property(sprite, "frame", 3, 0.05)
	tween.tween_property(sprite, "frame", 5, 0.05)

func stop():
	tween.kill()
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(sprite, "frame", 0, 0.2)
