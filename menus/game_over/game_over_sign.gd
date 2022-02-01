extends BaseSignMenu

export (Array, NodePath) var player_paths
var players = []

func _ready():
	for player_path in player_paths:
		players.append(get_node(player_path))


func set_scores():
	for player in players:
		if is_instance_valid(player):
			player.set_score()
		else:
			players.erase(player)


func _on_Continue_pressed():
	print("Continue Pressed")


func _on_Exit_pressed():
	SceneManager.load_main_menu()
