extends Control

var main_container
var button

func _ready():
	main_container = find_node('MainContainer')
	button = find_node("Continue")

func _process(delta):
	if get_tree().paused:
		main_container.show()
	else: 
		main_container.hide()

func _on_Continue_pressed():
	Global.continue_game()


func _on_Options_pressed():
#	Input.action_press('ui_down')
#	Input.action_release("ui_down")
	pass
	

func _on_Exit_pressed():
	Global.continue_game()
	Global.load_start_screen()

func _unhandled_input(event):
#	If the input wasn't from my player
	var keyboard = Global.get_uses_keyboard(Global.who_paused)
	var input_id = Global.get_input_id(Global.who_paused)
	if !event or event.get_device() != input_id or (event is InputEventKey and !keyboard) or (
	(event is InputEventJoypadButton or event is InputEventJoypadMotion) and keyboard):
		return
		
	Functions.control_to_UI(event)
	
	if event.is_action_pressed("pause"):
		button.grab_focus()

	if event.is_action_pressed("pause") and main_container.visible:
		Global.continue_game()
