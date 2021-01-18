extends Node

func control_to_UI(event):
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
