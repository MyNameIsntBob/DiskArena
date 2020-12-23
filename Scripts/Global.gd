extends Node

var number_of_players := 2
var map

var player_stats := {
	'1': {
		'hp': 3,
		'max_hp': 3, 
		'keyboard': true,
		'input_id': 0
	},
	'2': {
		'hp': 2,
		'max_hp': 3,
		'keyboard': false,
		'input_id': 0
	}
} 

const default_stats := {
	'hp': 3,
	'max_hp': 3
}

func _ready():
	map = get_tree().get_current_scene().find_node('Maps')

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
		map.respawnPlayer(player_id)
	
func add_new_player(player_id):
	player_stats[str(player_id)] = default_stats
	
func get_stats(player_id):
	if str(player_id) in player_stats:
		return(player_stats[str(player_id)])
	else:
		add_new_player(player_id)
		return(get_stats(player_id))
	
func get_max_hp(player_id):
	return(get_stats(player_id)['max_hp'])

func get_hp(player_id):
	return(get_stats(player_id)['hp'])

func get_uses_keyboard(player_id):
	return(get_stats(player_id)['keyboard'])
	
func get_input_id(player_id):
	return(get_stats(player_id)['input_id'])
	
