extends RigidBody2D

signal pick_character(character)
signal unpick_character(character)
signal start()

onready var char_picker = find_node('CharacterPicker')

func set_parent(parent):
	char_picker.parent = parent
	
func set_id(id):
	char_picker.id = id

func set_taken_characters(characters):
	char_picker.taken_characters = characters
	
func set_player(player):
	char_picker.player = player
	



func _on_CharacterPicker_pick_character(character):
	emit_signal("pick_character", character)


func _on_CharacterPicker_start():
	emit_signal('start')


func _on_CharacterPicker_unpick_character(character):
	emit_signal('unpick_character', character)
