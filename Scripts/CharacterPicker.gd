extends VBoxContainer

var player : Dictionary
export (NodePath) var text_path
var text
export (NodePath) var character_path
var character
export (NodePath) var box_path
var box

signal pick_character(character)
signal unpick_character(character)
signal start()

var moveDelay := 0.1
var delayTimer := 0.0

func _ready():
	text = get_node(text_path)
	character = get_node(character_path)
	box = get_node(box_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if delayTimer > 0:
		delayTimer -= delta
	
	if text and character:
		if player:
			character.texture = Icons.get_gui_character(player['character_id'])
			character.show()
			text.texture = Icons.get_text(player['character_id'])
			text.show()
		else:
			text.hide()
			character.hide()
			
	if box:
		if !player:
			box.texture = Icons.get_box(0)
		elif !player['selected']:
			box.texture = Icons.get_box(1)
		else:
			box.texture = Icons.get_box(2)
	

func pickPlayer():
	if player:
		if player['selected']:
			emit_signal('start')
		else:
			player['selected'] = true
			emit_signal('pick_character', player)
		
func unpickPlayer():
	if player:
		if player['selected']:
			player['selected'] = false
			emit_signal('pick_character', player)
		else:
			emit_signal('unpick_character', player)
			player = {}
	
func moveLeft():
	if delayTimer > 0:
		return
	
	if player['selected']:
		return
	
	player["character_id"] -= 1
	if player["character_id"] < 0:
		player["character_id"] = 3
	
	delayTimer = moveDelay
	
func moveRight():
	if delayTimer > 0:
		return 
		
	if player['selected']:
		return
		
	player["character_id"] += 1
	if player["character_id"] > 3:
		player["character_id"] = 0
		
	delayTimer = moveDelay

func _unhandled_input(event):
#	If the input wasn't from my player
	if !player or !event or event.get_device() != player["input_id"] or (event is InputEventKey and !player["keyboard"]) or (
	(event is InputEventJoypadButton or event is InputEventJoypadMotion) and player["keyboard"]):
		return
		
	if event.is_action_pressed("ui_accept"):
		pickPlayer()
		
	if event.is_action_pressed('ui_cancel'):
		unpickPlayer()
		
	if event.is_action_pressed("ui_left") and event.get_action_strength('ui_left') >= 1:
		moveLeft()
		
	if event.is_action_pressed("ui_right") and event.get_action_strength('ui_right') >= 1:
		moveRight()
