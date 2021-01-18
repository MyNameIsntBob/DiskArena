extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var button = find_node("Play")
	button.grab_focus()


func _on_Play_pressed():
	Global.character_select_screen()


func _on_Options_pressed():
	pass # Replace with function body.


func _on_Exit_pressed():
	get_tree().quit()
	
func _unhandled_input(event):
	Functions.control_to_UI(event)
