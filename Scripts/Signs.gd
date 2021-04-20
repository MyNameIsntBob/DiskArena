extends Node2D

export var drop_time := 1.0
export var raise_time := 1.0

var raise_to
var drop_to = -175.0
var dropping = true

signal finished

func _ready():
	raise_to = $Mount.position.y

	drop()

func drop():
	print("Dropping")
	$Tween.interpolate_property($Mount, "position", $Mount.position, Vector2(0, drop_to), drop_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	print('Dropped')
#	yield($Tween, "tween_completed")
#	emit_signal('finished')
	
func raise():
	$Tween.interpolate_property($Mount, "position", $Mount.position, Vector2(0, raise_to), raise_time, Tween.TRANSLINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
#	yield($Tween, "tween_completed")
#	emit_signal('finished')
