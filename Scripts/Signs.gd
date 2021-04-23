extends Node2D

export var drop_time := 2.0
export var raise_time := 1.0

var raise_to
var drop_to = -175.0
var dropping = true

signal finished

func _ready():
	raise_to = $Mount.position.y

	drop()

func drop():
	$Tween.interpolate_property($Mount, "position", $Mount.position, Vector2(0, drop_to), drop_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
#	yield($Tween, "tween_completed")
#	emit_signal('finished')
	
func raise():
	$Tween.interpolate_property($Mount, "position", $Mount.position, Vector2(0, raise_to), raise_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
#	emit_signal('finished')


func _on_Play_pressed():
	raise()
	$Chain3/Join1.queue_free()
	$Chain4/Join1.queue_free()
	yield($Tween, "tween_completed")
	Global.load_scene('connect')
#	print('Play')
	pass # Replace with function body.



func _on_Options_pressed():
	Global.load_scene('settings')

func _on_Exit_pressed():
	get_tree().quit()
