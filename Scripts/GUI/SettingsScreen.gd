extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (NodePath) var fullScreenButton

# Called when the node enters the scene tree for the first time.
func _ready():
	var button = find_node("Save")
	button.grab_focus()
	fullScreenButton = get_node(fullScreenButton)

func _process(delta):
	if fullScreenButton:
		fullScreenButton.pressed = Settings.fullScreen

func go_back():
	Global.load_scene('start')

func _on_CheckBox_toggled(button_pressed):
	Settings.set_full_screen(button_pressed)


func _on_Save_pressed():
	Settings.save_game()
	go_back()


func _on_Cancel_pressed():
	Settings.load_game()
	
func _unhandled_input(event):
	Functions.control_to_UI(event)
