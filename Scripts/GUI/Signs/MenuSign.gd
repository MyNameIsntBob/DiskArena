extends 'res://Scripts/GUI/Signs/Sign.gd'

signal press_play
signal press_options
signal press_exit

func _on_Play_pressed():
#	raise()
##	$Chain3/Join1.queue_free()
##	$Chain4/Join1.queue_free()
#	yield($Tween, "tween_completed")
	if focused:
		emit_signal('press_play')


func _on_Options_pressed():
	if focused:
		emit_signal("press_options")
#	Global.load_scene('settings')

func _on_Exit_pressed():
	if focused:
		emit_signal("press_exit")
#	get_tree().quit()

