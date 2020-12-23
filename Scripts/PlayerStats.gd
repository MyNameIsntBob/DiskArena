extends Control

export var player_id : int

var hp : int

var hp_icons : Dictionary

func _ready():
	hp_icons = {
		'1': find_node('Hp1'),
		'2': find_node('Hp2'),
		'3': find_node('Hp3'),
	}

func _process(delta):
#	Get Hp
	if player_id:
		hp = Global.get_hp(player_id)
#	Change Icons to match hp
	change_hp_icons()
		
		
#This works for now, but we might want to change the icons to 
#generate based off of hp and max hp in the future just for simplicity
func change_hp_icons():
	if hp < 3:
		hp_icons['3'].visible = false
	else:
		hp_icons['3'].visible = true
		
	if hp < 2:
		hp_icons['2'].visible = false
	else:
		hp_icons['2'].visible = true
	
	if hp < 1:
		hp_icons['1'].visible = false
	else:
		hp_icons['1'].visible = true
