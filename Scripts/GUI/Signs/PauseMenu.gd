extends 'res://Scripts/GUI/Signs/Sign.gd'

var dropped := false

#onready var colorRect = find_node('ColorRect')

#func _ready():
#	$PauseSign.drop()

func _process(delta):
	if Global.paused and !dropped:
#		colorRect.show()
		drop()
		dropped = true

func _on_Play_pressed():
	raise()
	yield(self, 'finished')
#	colorRect.hide()
	dropped = false
	Global.continue_game()


func _on_Exit_pressed():
	raise()
	yield(self, 'finished')
	Global.continue_game()
	Global.load_scene('start')
	
func _unhandled_input(event):
#	If the input wasn't from my player
	if !focused:
		return

	var keyboard = Global.get_uses_keyboard(Global.who_paused)
	var input_id = Global.get_input_id(Global.who_paused)
	if !event or event.get_device() != input_id or (event is InputEventKey and !keyboard) or (
	(event is InputEventJoypadButton or event is InputEventJoypadMotion) and keyboard):
		return
		
	Functions.control_to_UI(event)
	
	if event.is_action_pressed("pause") and dropped:
		_on_Play_pressed()
#		Global.continue_game()
