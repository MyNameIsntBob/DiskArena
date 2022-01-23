extends SignMenu

export (Array, NodePath) var player_paths
var players = []

func _ready():
	for player_path in player_paths:
		players.append(get_node(player_path))


func set_scores():
	print('set scores')
	for player in players:
		if is_instance_valid(player):
			player.set_score()
		else:
			players.erase(player)
