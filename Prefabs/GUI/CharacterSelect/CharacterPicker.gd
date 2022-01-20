extends VBoxContainer

var player : Dictionary setget set_player

var parent
var id setget set_id

signal pick_character(character)
signal unpick_character(character)
signal start()

var level := 0 setget set_level
var level_selected := false setget set_level_selected
var move_delay := 0.1
var delay_timer := 0.0
var taken_characters : Array

#----------------------------
#          Setters
#----------------------------

func set_player(new_player : Dictionary):
	$Character.player = new_player
	player = new_player

func set_level(new_level : int):
	$Character.level = new_level
	level = new_level


func set_level_selected(new_level_selected : bool):
	$Character.level_selected = new_level_selected
	level_selected = new_level_selected


func set_id(new_id : int):
	$Character.id = new_id
	id = new_id

#----------------------------
#           Logic
#----------------------------

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if delay_timer > 0:
		delay_timer -= delta


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
