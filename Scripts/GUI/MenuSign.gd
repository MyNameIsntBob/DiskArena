extends Node2D

func _ready():
	$MenuSign.drop()

func _on_MenuSign_press_exit():
	get_tree().quit()

# TODO 
# Make so that options open
func _on_MenuSign_press_options():
#	Global.load_scene('settings')
	pass

func _on_MenuSign_press_play():
#	Global.load_scene('connect')
	$MenuSign.raise()
	yield($MenuSign, 'finished')
	$CharacterSelect.drop()


func _on_go_back():
	$MenuSign.drop()
	
