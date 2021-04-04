extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var players : Array
const max_players := 4

export (Array, NodePath) var selecters
export (NodePath) var notice

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for i in range(len(selecters)):
		selecters[i] = get_node(selecters[i])
	notice = get_node(notice)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if len(players) >= 2:
		notice.hide()
	else:
		notice.show()

func start():
	var activePlayers = []
	for player in players:
		if !player.empty():
			activePlayers.append(player)
	
	if len(activePlayers) < 2:
		return
	
	for player in activePlayers:
		if !player['selected'] or not 'level' in player:
			return
	
	for i in range(len(activePlayers)):
		Global.add_new_player(i + 1, activePlayers[i])
		
	Global.level = activePlayers[randi() % len(activePlayers)].level
	
	Global.start()
	
func selected_characters():
	var characters = []
	for player in players:
		if player and player['selected']:
			characters.append(player.character_id)
	
	return characters

func join(keyboard, input_id):
	if find_player(keyboard, input_id) != null or len(players) >= max_players:
		return
	
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
	update_selecter_data()
	
func find_player(keyboard, input_id):
	for i in range(len(players)):
		var player = players[i]
		if player and player['input_id'] == input_id and player['keyboard'] == keyboard:
			return i
	return null
	

func update_selecter_data():
	for i in range(len(selecters)):
		var selecter = selecters[i]
		if i > len(players) - 1:
			selecter.player = {}
		else:
			selecter.player = players[i]
		selecter.taken_characters = selected_characters()
	
func _unhandled_input(event):
	if !event:
		return

	if event.is_action_pressed('ui_cancel') and len(players) == 0:
		Global.load_scene('start')

	if event.is_action_pressed("accept"):
		if event is InputEventKey:
			join(true, event.get_device())
		elif event is InputEventJoypadButton:
			join(false, event.get_device())

func _on_CharacterPicker_pick_character(character):
	players[find_player(character['keyboard'], character['input_id'])] = character
	update_selecter_data()

func _on_CharacterPicker_unpick_character(character):
	var player_id = find_player(character['keyboard'], character['input_id'])
	if player_id != null:
		players[player_id] = {}
		
		update_selecter_data()


func _on_CharacterPicker_start():
	start()
