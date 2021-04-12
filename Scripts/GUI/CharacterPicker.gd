extends VBoxContainer

var player : Dictionary
export (NodePath) var text_path
var text
export (NodePath) var character_path
var character
export (NodePath) var box_path
var box
export (NodePath) var level_box_path
var level_box
export (NodePath) var level_path
var level_node

signal pick_character(character)
signal unpick_character(character)
signal start()

var level := 0
var levelSelected := false
var moveDelay := 0.1
var delayTimer := 0.0
var taken_characters : Array

func _ready():
	text = get_node(text_path)
	character = get_node(character_path)
	box = get_node(box_path)
	level_node = get_node(level_path)
	level_box = get_node(level_box_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if delayTimer > 0:
		delayTimer -= delta
	
	if text and character:
		if player:
			if taken():
				character.texture = Icons.get_gui_taken_character(player['character_id'])
			else:
				character.texture = Icons.get_gui_character(player['character_id'])
			character.show()
			text.texture = Icons.get_text(player['character_id'])
			text.show()
		
			if player['selected']:
				level_node.texture = Icons.get_map_icon(level)
		
		else:
			text.hide()
			character.hide()
			
	level_box.visible = player && player['selected']
	level_node.visible = level_box.visible
			
	if box:
		if !player:
			box.texture = Icons.get_box(0)
		elif !player['selected']:
			box.texture = Icons.get_box(1)
		elif !levelSelected:
			box.texture = Icons.get_box(2)
		else:
			box.texture = Icons.get_box(3)
	
func taken():
	return (player and player.character_id in taken_characters 
		and !player['selected'] and player.character_id != 0)

func pickPlayer():
	if !player or taken():
		return
		
	if player['selected']:
#		if levelSelected:
#			emit_signal('start')
#		else:
		levelSelected = true
		player['level'] = level
		emit_signal('pick_character', player)
	else:
		player['selected'] = true
		emit_signal('pick_character', player)
		
func unpickPlayer():
	if player:
		if levelSelected:
			levelSelected = false
			player['level'] = null
			emit_signal('pick_character', player)
		
		elif player['selected']:
			player['selected'] = false
			emit_signal('pick_character', player)
		else:
			emit_signal('unpick_character', player)
			player = {}
	
func move(direction):
	if delayTimer > 0:
		return 
	delayTimer = moveDelay
	
#	If the character is selected we now let them select a map
	if player['selected']:
		if levelSelected:
			return
			
#		Plus one because random level option
		level = fposmod((level + direction), Icons.number_of_maps() + 1)
		
		return

	player['character_id'] = fposmod(player['character_id'] + direction, Icons.number_of_characters())
	

func _unhandled_input(event):
#	If the input wasn't from my player
	if !player or !event or event.get_device() != player["input_id"] or (event is InputEventKey and !player["keyboard"]) or (
	(event is InputEventJoypadButton or event is InputEventJoypadMotion) and player["keyboard"]):
		return
		
	if event.is_action_pressed("start"):
		emit_signal('start')
		
	if event.is_action_pressed("accept"):
		pickPlayer()
		
	if event.is_action_pressed('ui_cancel'):
		unpickPlayer()
		
	if event.is_action_pressed("left") and event.get_action_strength('left') >= 1:
		move(-1)
		
	if event.is_action_pressed("right") and event.get_action_strength('right') >= 1:
		move(1)
