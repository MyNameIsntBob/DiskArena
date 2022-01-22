extends SignMenu

export (Array, NodePath) var player_paths
var players = []

func _ready():
	for player_path in player_paths:
		players.append(get_node(player_paths))
	
#	for i in range(players):
#		if ScoreKeeper.num_of_players < i + 1:
#			players[i].queue_free()

func set_scores():
	for player in players:
		player.get_node('PlayerScore').set_score()
