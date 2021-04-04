extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var fade_time = 0.5
export var fade_in = true

var fade

signal finished

# Called when the node enters the scene tree for the first time.
func _ready():
	fade = $CanvasLayer/ColorRect
	fade_in()

func fade_out():
	get_tree().paused = true
	$Tween.interpolate_property(fade, "color:a", fade.color.a, 1, fade_time, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	emit_signal('finished')
	fade_in()
	
func fade_in():
	fade.color.a = 1
	$Tween.interpolate_property(fade, "color:a", fade.color.a, 0, fade_time, Tween.TRANS_CUBIC, Tween.EASE_IN)
	$Tween.start()
	yield($Tween, "tween_completed")
	get_tree().paused = false
	

