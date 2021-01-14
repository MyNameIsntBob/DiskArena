extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Array, NodePath) var scores

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(len(scores)):
		scores[i] = get_node(scores[i])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hide_extra()
	
func hide_extra():
	if Global.number_of_players < 4 and len(scores) >= 3:
		scores[3].hide()
	if Global.number_of_players < 3 and len(scores) >= 2:
		scores[2].hide()
	if Global.number_of_players < 2 and len(scores) >= 1:
		scores[1].hide()
	if Global.number_of_players < 1 and len(scores) >= 0:
		scores[0].hide()


func _on_Again_pressed():
	Global.start()


func _on_Exit_pressed():
	Global.character_select_screen()
