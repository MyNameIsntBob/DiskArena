extends Control

export (NodePath) var fullScreenButton


func _ready():
	var button = find_node("Save")
	button.grab_focus()
	fullScreenButton = get_node(fullScreenButton)


func _process(delta):
	if fullScreenButton:
		fullScreenButton.pressed = Settings.fullScreen


func go_back():
	SceneManager.load_main_menu()


func _on_CheckBox_toggled(button_pressed):
	Settings.set_full_screen(button_pressed)


func _on_Save_pressed():
	Settings.save_game()
	go_back()


func _on_Cancel_pressed():
	Settings.load_game()


func _unhandled_input(event):
	Functions.control_to_UI(event)
