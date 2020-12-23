extends Node2D

var player_path = preload("res://Prefabs/Player.tscn")
var disk_path = preload('res://Prefabs/Disk.tscn')
var players : Array

export var spawn_1 : NodePath
export var spawn_2 : NodePath
export var spawn_3 : NodePath
export var spawn_4 : NodePath

var spawn_locations : Array

func _ready():
	if spawn_1:
		spawn_locations.append(get_node(spawn_1))
	if spawn_2:
		spawn_locations.append(get_node(spawn_2))
	if spawn_3:
		spawn_locations.append(get_node(spawn_3))
	if spawn_4:
		spawn_locations.append(get_node(spawn_4))
	spawnPlayers()
	
func spawnPlayers():
	for i in range(len(spawn_locations)):
		if i < Global.number_of_players:
			spawnPlayer(spawn_locations[i], i + 1)
	
func respawnPlayer(player_id):
	spawnPlayer(spawn_locations[int(player_id) - 1], player_id)
	
func spawnPlayer(location, player_id):
	var player = player_path.instance()
	players.append(player)
	find_parent("Master").add_child(player)
	player.position = location.global_position
	player.player_id = player_id
	player.keyboard = Global.get_uses_keyboard(player_id)
	player.input_id = Global.get_input_id(player_id)
