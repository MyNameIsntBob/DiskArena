extends Node

var number_of_players := 0
#var map

var player_stats : Dictionary 

var scenes = {
	'2': 'res://Scenes/lava_map/2player.tscn',
}

var players_to_respawn : Array

const default_stats := {
	'hp': 3,
	'max_hp': 3,
	'keyboard': false,
	'input_id': 0
}

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#func grab_map():
#	map = get_tree().get_current_scene().find_node('Maps')

func start():
	number_of_players = player_stats.size()
	get_tree().change_scene(scenes[str(number_of_players)])
#	grab_map()

func player_die(player_id):
#	Get the stats of the player and lower the hp
	var stats = player_stats[str(player_id)]
	
	if !stats:
		stats = default_stats
		
	if stats['hp'] <= 0:
		return
	
	stats['hp'] -= 1
	
#	If the player isn't dead yet, respon them
	if stats['hp'] > 0:
		players_to_respawn.append(player_id)
		
func get_player_to_respawn():
	if len(players_to_respawn) > 0:
		return players_to_respawn.pop_front()
	else:
		return null
	
func add_new_player(player_id, player_values):
	player_stats[str(player_id)] = default_stats.duplicate()
	for key in player_values:
		player_stats[str(player_id)][str(key)] = player_values[key]
	
#Getter functions to simplify the process of getting data
func get_stats(player_id):
	if str(player_id) in player_stats:
		return(player_stats[str(player_id)])
	
func get_max_hp(player_id):
	if str(player_id) in player_stats:
		return(get_stats(player_id)['max_hp'])

func get_hp(player_id):
	if str(player_id) in player_stats:
		return(get_stats(player_id)['hp'])

func get_uses_keyboard(player_id):
	if str(player_id) in player_stats:
		return(get_stats(player_id)['keyboard'])
	
func get_input_id(player_id):
	if str(player_id) in player_stats:
		return(get_stats(player_id)['input_id'])
	
func get_character_id(player_id):
	if str(player_id) in player_stats:
		return(get_stats(player_id)['character_id'])
	
