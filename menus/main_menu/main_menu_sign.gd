extends BaseSignMenu

signal press_play
signal press_options
signal press_exit

func _on_Play_pressed():
	if focused:
		emit_signal('press_play')


func _on_Options_pressed():
	if focused:
		emit_signal("press_options")


func _on_Exit_pressed():
	if focused:
		emit_signal("press_exit")

func _unhandled_input(event):
	Functions.control_to_UI(event)
