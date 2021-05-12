extends Node

var number_of_players := 0
#var map

var player_stats : Dictionary 
var who_paused : int
var players = []
var level = 0
var paused := false
var isMenuScreen := false

const scenes = {
	'connect': 'res://Scenes/ConnectScreen.tscn',
	'end': 'res://Scenes/EndScreen.tscn',
	'start': 'res://Scenes/StartScreen.tscn',
	'settings': 'res://Scenes/SettingsScreen.tscn'
}

const levels = {
	'Grass': 'res://Scenes/Maps/Grass.tscn',
	'Lava': 'res://Scenes/Maps/Lava.tscn',
}

var players_to_respawn : Array

const default_stats := {
	'hp': 3,
	'max_hp': 3,
	'keyboard': false,
	'input_id': 0,
	'kills': 0,
	'deaths': 0,
	'score': 0,
	'npc': false
}

const level_from_id = {
	0: 'Random',
	1: 'Grass',
	2: 'Lava'
}

func _ready():
	randomize()
	load_scene('start')
	
func add_characters(num_of_bots = 0):
	players = []
	number_of_players = player_stats.size()
	for i in range(num_of_bots):
		add_new_player(number_of_players + 1, {'npc': true, 'character_id': 0})
		number_of_players += 1
	for player_id in player_stats:
		if player_stats[player_id]["character_id"] == 0:
			player_stats[player_id]["character_id"] = random_character()

func start(num_of_bots = 0):
	isMenuScreen = false
	add_characters(num_of_bots)
	
	if level == 0:
		level = (randi() % (len(level_from_id) - 1)) + 1
	get_tree().change_scene(levels[level_from_id[level]])
	
#	Set everyone's hp to the max hp
	for player_id in player_stats:
		var player = player_stats[player_id]
		player['hp'] = player['max_hp']
		player['score'] = 0
		player['deaths'] = 0
		player['kills'] = 0
	
# Pause and play game
func pause_game(player_id):
	if paused:
		return
		
#	get_tree().paused = true
	paused = true
	who_paused = player_id
	
func continue_game():
	if !paused:
		return
	
#	get_tree().paused = false
	paused = false


# Scene Loading
func load_scene(scene):
	$SceneFader.fade_out()
	yield($SceneFader, 'finished')
	
	if scene == 'start':
		add_characters(rand_range(2, 4))
	
	if scene == 'map':
		start()
	else:
		isMenuScreen = true
		if scene == 'connect':
			player_stats = {}
		get_tree().change_scene(scenes[scene])

# Used to keep track of the kills that people get
func add_kill(player_id):
	var stats = get_stats(player_id)
	stats['kills'] += 1

func player_die(player_id):
#	Get the stats of the player and lower the hp
	var stats = get_stats(player_id)
#	remove_player(player_id)
	
	if !stats:
		stats = default_stats
		
	if stats['hp'] <= 0:
		return
	
	stats['hp'] -= 1
	stats['deaths'] += 1
	
#	If the player just died, we want to record there score
	if stats['hp'] <= 0:
		stats['score'] = number_of_players - number_of_dead_players()
	
	if is_game_over() and !isMenuScreen:
		load_scene('end')
		
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
	
	
# Player functions
func get_player_to_respawn():
	if len(players_to_respawn) > 0:
		return players_to_respawn.pop_front()
	else:
		return null
	
func add_new_player(player_id, player_values):
	player_stats[str(player_id)] = default_stats.duplicate()
	for key in player_values:
		player_stats[str(player_id)][str(key)] = player_values[key]
	
func add_player(player):
	players.append(player)
	
func remove_player(player_id):
	for i in range(len(players)):
		if !players[i] or players[i].player_id == player_id:
			players.remove(i)
			break
			
			
# Character functions
# Gives a random character that's not taken
func random_character():
	var characters = range(1, 5)
	for player_id in player_stats:
		characters.erase(player_stats[player_id].character_id)
	characters.shuffle()
	return characters.pop_front()
	
#Getter functions to simplify the process of getting data
func get_stats(player_id):
	if str(player_id) in player_stats:
		return(player_stats[str(player_id)])

func get_npc(player_id):
	return get_stats(player_id)['npc']
	
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
	

