extends Node2D


var number_of_players := 0

var player_stats : Dictionary

var players = []
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

# Tells us if the game is over
func is_game_over():
	return number_of_players - number_of_dead_players() <= 1

# Tells us how many dead players there are
func number_of_dead_players():
	var sum = 0
	
	for player_id in player_stats:
		if get_hp(player_id) <= 0:
			sum += 1
	return sum
	
func add_characters(num_of_bots = 0):
	players = []
	for player_id in player_stats:
		if player_stats[player_id]["npc"]:
			player_stats.erase(player_id)
	number_of_players = player_stats.size()
	for i in range(num_of_bots):
		add_new_player(number_of_players + 1, {'npc': true, 'character_id': 0})
		number_of_players += 1
	for player_id in player_stats:
		if player_stats[player_id]["character_id"] == 0:
			player_stats[player_id]["character_id"] = random_character()

# Used to keep track of the kills that people get
func add_kill(player_id):
	var stats = get_stats(player_id)
	if stats:
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
	
#	if is_game_over() and !isMenuScreen:
#		load_scene('end')
	
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
		characters.erase(int(player_stats[player_id].character_id))
	characters.shuffle()
	return characters.pop_front()



#Getter functions to simplify the process of getting data
func get_stats(player_id):
	if str(player_id) in player_stats:
		return(player_stats[str(player_id)])

func get_npc(player_id):
	if str(player_id) in player_stats:
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
