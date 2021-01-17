extends Node

var number_of_players := 0
#var map

var player_stats : Dictionary 
var who_paused : int

var scenes = {
	'2': 'res://Scenes/lava_map/2player.tscn',
	'CharacterSelect': 'res://Scenes/ConnectScreen.tscn',
	'EndScreen': 'res://Scenes/EndScreen.tscn',
}

var players_to_respawn : Array

const default_stats := {
	'hp': 3,
	'max_hp': 3,
	'keyboard': false,
	'input_id': 0,
	'kills': 0,
	'deaths': 0,
	'score': 0
}

func _ready():
	pass
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#func grab_map():
#	map = get_tree().get_current_scene().find_node('Maps')

func start():
	number_of_players = player_stats.size()
	get_tree().change_scene(scenes[str(number_of_players)])
	
	print(get_tree().get_current_scene().find_node('Master'))
	
#	Set everyone's hp to the max hp
	for player_id in player_stats:
		var player = player_stats[player_id]
		player['hp'] = player['max_hp']
		player['score'] = 0
		player['deaths'] = 0
		player['kills'] = 0
	
func pause_game(player_id):
	get_tree().paused = true
	who_paused = player_id
	
func continue_game():
	get_tree().paused = false

func character_select_screen():
	player_stats = {}
	get_tree().change_scene(scenes['CharacterSelect'])

func load_end_screen():
	get_tree().change_scene(scenes['EndScreen'])

# Used to keep track of the kills that people get
func add_kill(player_id):
	var stats = get_stats(player_id)
	stats['kills'] += 1

func player_die(player_id):
#	Get the stats of the player and lower the hp
	var stats = get_stats(player_id)
	
	if !stats:
		stats = default_stats
		
	if stats['hp'] <= 0:
		return
	
	stats['hp'] -= 1
	stats['deaths'] += 1
	
#	If the player isn't dead yet, respon them
	if stats['hp'] > 0:
		players_to_respawn.append(player_id)
		
#	If the player just died, we want to record there score
	else:
		stats['score'] = number_of_players - number_of_dead_players()
	
	if is_game_over():
		load_end_screen()
		
# Tells us how many dead players there are
func number_of_dead_players():
	var sum = 0
	
	for player_id in player_stats:
		if get_hp(player_id) <= 0:
			sum += 1
	return sum
	
# Tells us if the game is over
func is_game_over():
	return number_of_players - number_of_dead_players() <= 1
	
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
		
func get_kills(player_id):
	if str(player_id) in player_stats:
		return(get_stats(player_id)['kills'])
	
func get_deaths(player_id):
	if str(player_id) in player_stats:
		return(get_stats(player_id)['deaths'])
	
func get_score(player_id):
	if str(player_id) in player_stats:
		return(get_stats(player_id)['score'])
	
