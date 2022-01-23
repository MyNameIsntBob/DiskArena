extends Node

var player_stats : Dictionary

const default_stats := {
	'hp': 0,
	'max_hp': 3,
	'keyboard': false,
	'input_id': 0,
	'kills': 0,
	'deaths': 0,
	'score': 0,
	'npc': false,
	'character_id': 0
}

var num_of_players := 0

var players = []

#---------------------------
#    PRIVATE FUNCTIONS
#---------------------------

func _number_of_dead_players():
	var sum = 0
	
	for player_id in player_stats:
		if get_hp(player_id) <= 0:
			sum += 1
	return sum

func reset_scores():
	for player_id in player_stats:
		var player = player_stats[player_id]
		player['hp'] = player['max_hp']
		player['score'] = 0
		player['deaths'] = 0
		player['kills'] = 0

func reset_stats():
	player_stats = {}
	num_of_players = 0

# Tells us if the game is over
func is_game_over():
	return num_of_players - _number_of_dead_players() <= 1

#---------------------------
#      SET UP STATS
#---------------------------
func setup_npc_stats(num_of_npcs = 0):
	if num_of_npcs == 0:
		num_of_npcs = randi()%3 + 2
	
	for i in range(num_of_npcs):
		add_new_player(i + 1, {'npc': true})
	
	num_of_players = num_of_npcs

func add_new_player(player_id, player_values):
	print("Add Player: ", player_id, "\nValues: ", player_values)
	player_stats[str(player_id)] = default_stats.duplicate()
	for key in player_values:
		player_stats[str(player_id)][str(key)] = player_values[key]
		
	if player_stats[str(player_id)]['character_id'] == 0:
		player_stats[str(player_id)]['character_id'] = random_unused_character()
	
	num_of_players += 1

#func add_player(player):
#	pass

#
## TODO Rework this function
#func add_characters(num_of_bots = 0):
##	players = []
#	for player_id in player_stats:
#		if player_stats[player_id]["npc"]:
#			player_stats.erase(player_id)
#	num_of_players = player_stats.size()
#	for i in range(num_of_bots):
#		add_new_player(num_of_players + 1, {'npc': true, 'character_id': 0})
#		num_of_players += 1
#	for player_id in player_stats:
#		if player_stats[player_id]["character_id"] == 0:
#			player_stats[player_id]["character_id"] = random_character()
#
## Used to keep track of the kills that people get
func add_kill(player_id):
	var stats = get_stats(player_id)
	if stats:
		stats['kills'] += 1
	Global.set_scores()

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
		stats['score'] = num_of_players - _number_of_dead_players()

	if is_game_over() and !SceneManager.isMenuScreen:
		Global.game_over()


func add_player(player):
	players.append(player)
#
##func remove_player(player_id):
##	for i in range(len(players)):
##		if !players[i] or players[i].player_id == player_id:
##			players.remove(i)
##			break


# Gives a random character that's not taken
func random_unused_character():
	var characters = range(1, 5)
	for player_id in player_stats:
		characters.erase(int(player_stats[player_id].character_id))
	characters.shuffle()
	return characters.pop_front()


#-------------------------------
#       GETTER FUNCTIONS
#-------------------------------

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
