extends Node2D

var player_path = preload("res://Prefabs/Player.tscn")
var disk_path = preload('res://Prefabs/Disk.tscn')
var players : Array

var counter : float
var spawned := false

export(Array, NodePath) var spawn_locations

export(NodePath) var map2
export(NodePath) var map4


#var spawn_locations : Array

#Change spawn location node paths to spawn location 
func _ready():
	for i in range(len(spawn_locations)):
		spawn_locations[i] = get_node(spawn_locations[i])
	
#	$Map.texture = Icons.get_map(Global.number_of_players)
	if Global.number_of_players < 3:
		if map4:
			get_node(map4).queue_free()
#		$Map4.queue_free()
	else:
		if map2:
			get_node(map2).queue_free()
	
func _process(delta):
	if counter >= 0.01:
		if not spawned:
			spawned = true
			spawnPlayers()
	else:
		counter += delta
		
	if len(players) < Global.number_of_players:
		var player_to_respawn = Global.get_player_to_respawn()
		if player_to_respawn != null:
			spawnPlayer(player_to_respawn)
	
func spawnPlayers():
	for i in range(len(spawn_locations)):
		if i < Global.number_of_players:
			spawnPlayer(i + 1)
	
func respawnPlayer(player_id):
	spawnPlayer(player_id)
	
func spawnPlayer(player_id):
	var location = spawn_locations[int(player_id) - 1]
	var player = player_path.instance()
	Global.add_player(player)
	find_parent("Master").add_child(player)
	player.position = location.global_position
	player.player_id = player_id
	player.keyboard = Global.get_uses_keyboard(player_id)
	player.input_id = Global.get_input_id(player_id)
	player.character_id = Global.get_character_id(player_id)
	
