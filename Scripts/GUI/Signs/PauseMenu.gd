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
	print("Play")
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
	
