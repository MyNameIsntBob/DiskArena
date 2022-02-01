class_name BaseSignMenu
extends Node2D

signal finished

export (Array, NodePath) var button_paths
var buttons : Array
export var drop_time := 2.0
export var raise_time := 1.0

var raise_to
var drop_to = -175.0
var dropping = true
var focused = false


func _ready():
	for path in button_paths:
		var button = get_node(path)
		buttons.append(button)
	raise_to = $Mount.position.y


func _process(delta):
	if focused:
		for button in buttons:
			if button.button().is_hovered():
				button.button().grab_focus()


func drop():
	$Tween.interpolate_property($Mount, "position", $Mount.position, Vector2(0, drop_to), drop_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	emit_signal('finished')
	
	focused = true
	if len(buttons) > 0:
		buttons[0].button().grab_focus()


func raise():
	focused = false
	if len(buttons) > 0:
		buttons[0].button().release_focus()
	
	$Tween.interpolate_property($Mount, "position", $Mount.position, Vector2(0, raise_to), raise_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, 'tween_completed')
	emit_signal('finished')
