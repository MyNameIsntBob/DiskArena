extends Node2D

var player_path = preload("res://entities/Character/Player.tscn")
var npc_path = preload("res://entities/Character/Bot.tscn")

func _ready():
	randomize()

func spawnPoints(num_of_players = null):
	if num_of_players == null:
		num_of_players = ScoreKeeper.num_of_players
	if num_of_players > 2:
		return $Players4.get_children()
	else:
		return $Players2.get_children()

# Used when having npcs play in the background on main screen
#func spawnNpcs():
#	var num_of_npcs = randi()%3 + 2
#	var spawn_points = spawnPoints(num_of_npcs)
#
#
#	for i in range(num_of_npcs):
#		var npc = npc_path.instance()
#		Global.add_child(npc)
#		npc.position = spawn_points[i].position

func spawnPlayers():
	for i in range(len(spawnPoints())):
		
		if i < ScoreKeeper.num_of_players:
			spawnPlayer(i + 1)
	
func spawnPlayer(player_id): 
	if !ScoreKeeper.get_stats(player_id):
		return
		
	var location = spawnPoints()[int(player_id) - 1]
	var player
	if ScoreKeeper.get_npc(player_id):
		player = npc_path.instance()
	else:
		player = player_path.instance()
		player.keyboard = ScoreKeeper.get_uses_keyboard(player_id)
		player.input_id = ScoreKeeper.get_input_id(player_id)
	ScoreKeeper.add_player(player)
	Global.add_child(player)
	player.position = location.global_position
	player.player_id = player_id
	player.character_id = ScoreKeeper.get_character_id(player_id)
