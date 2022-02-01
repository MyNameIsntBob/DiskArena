extends BaseSignMenu


func _on_Play_pressed():
	raise()
	yield(self, 'finished')
	Global.continue_game()


func _on_Exit_pressed():
	raise()
	yield(self, 'finished')
	Global.continue_game()
	SceneManager.load_main_menu()


func _unhandled_input(event):
	if !focused:
		return

	# TODO 
	# Move this into it's own function _current_user or _paused_user
	var keyboard = ScoreKeeper.get_uses_keyboard(Global.who_paused)
	var input_id = ScoreKeeper.get_input_id(Global.who_paused)
	if !event or event.get_device() != input_id or (event is InputEventKey and !keyboard) or (
	(event is InputEventJoypadButton or event is InputEventJoypadMotion) and keyboard):
		return
	
	Functions.control_to_UI(event)
	
	if event.is_action_pressed("pause") and Global.paused:
		_on_Play_pressed()
