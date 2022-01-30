extends Control

var player_stats : Dictionary

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
	set_hp_bars()


func set_hp_bars():
	for i in range(1, 5):
		var stat = player_stats[str(i)]
		if SceneManager.isMenuScreen:
			stat.hide()
			continue
		
		if ScoreKeeper.num_of_players < i and player_stats[str(i)]:
			stat.hide()
		else:
			stat.show()
			stat.setup()
