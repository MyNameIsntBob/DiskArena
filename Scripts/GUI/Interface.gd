extends Control

var player_stats : Dictionary

#export var hp_bars : Array(NodePath)
export var hp_bar_4 : NodePath
export var hp_bar_3 : NodePath
export var hp_bar_2 : NodePath
export var hp_bar_1 : NodePath

func _ready():
	player_stats = {
		'1': get_node(hp_bar_1),
		'2': get_node(hp_bar_2),
		'3': get_node(hp_bar_3),
		'4': get_node(hp_bar_4)
	}
	hide_extra()
	
func hide_extra():
	if Global.number_of_players < 4 and player_stats['4']:
		player_stats['4'].hide()
	if Global.number_of_players < 3 and player_stats['3']:
		player_stats['3'].hide()
	if Global.number_of_players < 2 and player_stats['2']:
		player_stats['2'].hide()
	if Global.number_of_players < 1 and player_stats['1']:
		player_stats['1'].hide()
