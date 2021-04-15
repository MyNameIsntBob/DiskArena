extends Control

export var player_id : int
var character_id

var hp_icons : Dictionary

func _ready():
	hp_icons = {
		'1': find_node('Hp1'),
		'2': find_node('Hp2'),
		'3': find_node('Hp3'),
	}

func _process(delta):
	change_hp_icons()
		
		
#This works for now, but we might want to change the icons to 
#generate based off of hp and max hp in the future just for simplicity
func change_hp_icons():
	var hp = Global.get_hp(player_id)
	character_id = Global.get_character_id(player_id)
	if character_id == null:
		return
	for i in range(len(hp_icons)):
		if hp < i + 1:
			hp_icons[str(i + 1)].get_child(0).set_frame(4)
		else:
			hp_icons[str(i + 1)].get_child(0).set_frame(character_id - 1)

