extends Node2D

var player_path = preload("res://Prefabs/Player.tscn")
var npc_path = preload('res://Prefabs/Bot.tscn')
var disk_path = preload('res://Prefabs/Disk.tscn')

var counter : float
var spawned := false

export(Array, NodePath) var spawn_locations

export(NodePath) var map2
export(NodePath) var map4

#Change spawn location node paths to spawn location 
func _ready():
	for i in range(len(spawn_locations)):
		spawn_locations[i] = get_node(spawn_locations[i])
	
#	$Map.texture = Icons.get_map(Global.number_of_players)
	if Global.number_of_players < 3:
		if map4:
			get_node(map2).visible = true
			get_node(map4).queue_free()
	else:
		if map2:
			get_node(map4).visible = true
			get_node(map2).queue_free()
	
func _process(delta):
	
#	Change this spawn method, pass a function spawnPlayer too each player, when the players die, they 
#   need to pass that function to the global, so Global will call respawn when the player dies
	if counter >= 0.01:
		if not spawned:
			spawned = true
			spawnPlayers()
	else:
		counter += delta
		
	if len(Global.players) < Global.number_of_players:
		var player_to_respawn = Global.get_player_to_respawn()
		if player_to_respawn != null:
			spawnPlayer(player_to_respawn)
	
func spawnPlayers():
	for i in range(len(spawn_locations)):
		if i < Global.number_of_players:
			spawnPlayer(i + 1)
	
func spawnPlayer(player_id):
	var location = spawn_locations[int(player_id) - 1]
	var player
	if Global.get_npc(player_id):
		player = npc_path.instance()
	else:
		player = player_path.instance()
		player.keyboard = Global.get_uses_keyboard(player_id)
		player.input_id = Global.get_input_id(player_id)
	Global.add_player(player)
	find_parent("Master").add_child(player)
	player.position = location.global_position
	player.player_id = player_id
	player.character_id = Global.get_character_id(player_id)
	
