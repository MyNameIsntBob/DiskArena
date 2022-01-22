class_name SignMenu
extends Node2D

signal finished

export (Array, NodePath) var buttons
export var drop_time := 2.0
export var raise_time := 1.0

var raise_to
var drop_to = -175.0
var dropping = true
var focused = false


func _ready():
	for i in range(len(buttons)):
		buttons[i] = get_node(buttons[i])
	raise_to = $Mount.position.y


func _process(delta):
	if focused:
		for button in buttons:
			if button.is_hovered():
				button.grab_focus()


func drop():
	$Tween.interpolate_property($Mount, "position", $Mount.position, Vector2(0, drop_to), drop_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	emit_signal('finished')
	
	focused = true
	if len(buttons) > 0:
		buttons[0].grab_focus()


func raise():
	focused = false
	if len(buttons) > 0:
		buttons[0].release_focus()
	
	$Tween.interpolate_property($Mount, "position", $Mount.position, Vector2(0, raise_to), raise_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, 'tween_completed')
	emit_signal('finished')


func _on_focus_entered(button_id):
	var button = buttons[button_id]
	button.get_parent().texture = Icons.get_sign(true, button.name)


func _on_focus_exited(button_id):
	var button = buttons[button_id]
	button.get_parent().texture = Icons.get_sign(false, button.name)


