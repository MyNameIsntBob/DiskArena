extends VBoxContainer

var player : Dictionary

var parent
var id

signal pick_character(character)
signal unpick_character(character)
signal start()

var level := 0
var level_selected := false
var move_delay := 0.1
var delay_timer := 0.0
var taken_characters : Array


export (NodePath) var name_label_path
var name_label
export (NodePath) var join_label_path
var join_label
export (NodePath) var select_label_path
var select_label
export (NodePath) var character_path
var character
export (NodePath) var box_path
var box
export (NodePath) var level_path
var level_node
export (NodePath) var top_padding_path
var top_padding


func _ready():
	top_padding = get_node(top_padding_path)
	join_label = get_node(join_label_path)
	name_label = get_node(name_label_path)
	select_label = get_node(select_label_path)
	character = get_node(character_path)
	box = get_node(box_path)
	level_node = get_node(level_path)


func _process(delta):
	if delay_timer > 0:
		delay_timer -= delta
	
	join_label.visible = !player
	
	select_label.visible = player and !level_selected
	
	if box:
		if !player:
			box.texture = Icons.get_box(4)
		elif !player['selected']:
			box.texture = Icons.get_box(1)
		elif !level_selected:
			box.texture = Icons.get_box(2)
		else:
			box.texture = Icons.get_box(3)
	
	if name_label and character:
		if player:
			if taken():
				character.texture = Icons.get_gui_taken_character(player['character_id'])
			else:
				character.texture = Icons.get_gui_character(player['character_id'])
			character.show()
			name_label.text = Icons.character_from_id[int(player["character_id"])]
			name_label.show()
		
			if player['selected']:
				print(level)
#				level_node.texture = Icons.get_map_icon(level)
		
		else:
			if parent.num_of_players() + parent.num_of_bots > id: 
				character.texture = Icons.gui['characters']['Ai']
				character.show()
				join_label.hide()
				box.texture = Icons.get_box(4)
			else:
				name_label.hide()
				character.hide()
	
	level_node.visible = player && player['selected']

#----------------------------
#           Logic
#----------------------------


func taken():
	return (self.player and self.player.character_id in taken_characters 
		and !self.player['selected'] and self.player.character_id != 0)


func pickPlayer():
	if !self.player or taken():
		return
		
	if self.player['selected']:
		self.level_selected = true
		self.player['level'] = self.level
		emit_signal('pick_character', self.player)
	else:
		self.player['selected'] = true
		emit_signal('pick_character', self.player)


func unpickPlayer():
	if self.player:
		if self.level_selected:
			self.level_selected = false
			self.player['level'] = null
			emit_signal('pick_character', self.player)
		
		elif self.player['selected']:
			self.player['selected'] = false
			emit_signal('pick_character', self.player)
		else:
			emit_signal('unpick_character', self.player)
			self.player = {}


func move(direction):
	if delay_timer > 0:
		return 
	delay_timer = move_delay
	
#	If the character is selected we now let them select a map
	if self.player['selected']:
		if self.level_selected:
			return
			
#		Plus one because random level option
		self.level = fposmod((self.level + direction), Icons.number_of_maps() + 1)
		
		return

	self.player['character_id'] = fposmod(self.player['character_id'] + direction, Icons.number_of_characters())


func _unhandled_input(event):
#	If the input wasn't from my player
	if !self.player or !event or event.get_device() != self.player["input_id"] or (event is InputEventKey and !self.player["keyboard"]) or (
	(event is InputEventJoypadButton or event is InputEventJoypadMotion) and self.player["keyboard"]):
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
