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
	Global.character_select_screen()

func _unhandled_input(event):
#	If the input wasn't from my player
	var keyboard = Global.get_uses_keyboard(Global.who_paused)
	var input_id = Global.get_input_id(Global.who_paused)
	if !event or event.get_device() != input_id or (event is InputEventKey and !keyboard) or (
	(event is InputEventJoypadButton or event is InputEventJoypadMotion) and keyboard):
		return
		
	if event.is_action_pressed("down"):
		var a = InputEventAction.new()
		a.action = "ui_down"
		a.pressed = true
		Input.parse_input_event(a)
	
	if event.is_action_released("down"):
		var a = InputEventAction.new()
		a.action = "ui_down"
		a.pressed = false
		Input.parse_input_event(a)
		
	if event.is_action_pressed('up'):
		var a = InputEventAction.new()
		a.action = "ui_up"
		a.pressed = true
		Input.parse_input_event(a)
	
	if event.is_action_released('up'):
		var a = InputEventAction.new()
		a.action = "ui_up"
		a.pressed = false
		Input.parse_input_event(a)
		
	if event.is_action_pressed('left'):
		var a = InputEventAction.new()
		a.action = "ui_left"
		a.pressed = true
		Input.parse_input_event(a)
	
	if event.is_action_released('left'):
		var a = InputEventAction.new()
		a.action = "ui_left"
		a.pressed = false
		Input.parse_input_event(a)
		
	if event.is_action_pressed('right'):
		var a = InputEventAction.new()
		a.action = "ui_right"
		a.pressed = true
		Input.parse_input_event(a)
	
	if event.is_action_released('right'):
		var a = InputEventAction.new()
		a.action = "ui_right"
		a.pressed = false
		Input.parse_input_event(a)
		
	if event.is_action_pressed('accept'):
		var a = InputEventAction.new()
		a.action = "ui_accept"
		a.pressed = true
		Input.parse_input_event(a)
	
	if event.is_action_released('accept'):
		var a = InputEventAction.new()
		a.action = "ui_accept"
		a.pressed = false
		Input.parse_input_event(a)
	
	if event.is_action_pressed("pause"):
		button.grab_focus()

	if event.is_action_pressed("pause") and main_container.visible:
		Global.continue_game()
