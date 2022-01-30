extends SignMenu

var players : Array
const max_players := 4

var num_of_bots := 0

signal go_back

export (Array, NodePath) var selector_paths
var selectors := []


func _ready():
	randomize()
	for i in range(len(selector_paths)):
		var current_selector = get_node(selector_paths[i])
		current_selector.set_parent(self)
		current_selector.set_id(i)
		selectors.append(current_selector)


func start():
	var activePlayers = []
	for player in players:
		if !player.empty():
			activePlayers.append(player)
	
	for player in activePlayers:
		if !player['selected'] or not 'level' in player or player["level"] == null:
			return
	
	ScoreKeeper.reset_stats()
	
	for i in range(len(activePlayers) + num_of_bots):
		if i < len(activePlayers):
			ScoreKeeper.add_new_player(i + 1, activePlayers[i])
		else:
			ScoreKeeper.add_new_player(i + 1, {'npc': true})
	
	var level = 0
	if len(activePlayers):
		level = activePlayers[randi() % len(activePlayers)].level
	
	if len(activePlayers) and num_of_players() + num_of_bots >= 2:
		SceneManager.load_arena(level)


func selected_characters():
	var characters = []
	for player in players:
		if player and player['selected']:
			characters.append(player.character_id)
	
	return characters


func join(keyboard, input_id):
	if find_player(keyboard, input_id) != null or len(players) >= max_players:
		return
		
	if num_of_bots + num_of_players() >= 4 and num_of_bots > 0:
		num_of_bots -= 1
	
	var player = {
		'keyboard': keyboard,
		'input_id': input_id,
		'character_id': 0,
		'selected': false
	}
	
	var open = -1
	for i in range(len(players)):
		if players[i].empty():
			open = i
			break
	
	if open < 0:
		players.append(player)
	else:
		players[open] = player
	update_selector_data()


func add_bot():
	if num_of_bots + num_of_players() < 4:
		num_of_bots += 1


func remove_bot():
	if num_of_bots:
		num_of_bots -= 1


func find_player(keyboard, input_id):
	for i in range(len(players)):
		var player = players[i]
		if player and player['input_id'] == input_id and player['keyboard'] == keyboard:
			return i
	return null


func num_of_players():
	var amount := 0
	for player in players:
		if !player.empty():
			amount += 1
	return amount


func update_selector_data():
	for i in range(len(selectors)):
		var selector = selectors[i]
		if i > len(players) - 1:
			selector.set_player({})
		else:
			selector.set_player(players[i])
		selector.set_taken_characters(selected_characters())


func _unhandled_input(event):
	if !event or !focused:
		return
	
	if event.is_action_pressed('ui_cancel') and num_of_players() == 0:
		raise()
		emit_signal("go_back")
	
	if event.is_action_pressed('add_bot'):
		add_bot()
	
	if event.is_action_pressed('remove_bot'):
		remove_bot()
	
	if event.is_action_pressed("accept"):
		if event is InputEventKey:
			join(true, event.get_device())
		elif event is InputEventJoypadButton:
			join(false, event.get_device())


func _on_CharacterPicker_pick_character(character):
	players[find_player(character['keyboard'], character['input_id'])] = character
	update_selector_data()


func _on_CharacterPicker_unpick_character(character):
	var player_id = find_player(character['keyboard'], character['input_id'])
	if player_id != null:
		players[player_id] = {}
		
		update_selector_data()


func _on_CharacterPicker_start():
	start()
