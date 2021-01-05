extends Node

const gui = {
	'characters':{
		'Demon': preload('res://Art/GUI/Demon.png'),
		'Goblin': preload('res://Art/GUI/Goblin.png'),
		'Human': preload('res://Art/GUI/Human.png'),
		'Robot': preload('res://Art/GUI/Robot.png'),
	},
	'taken_characters':{
		'Demon': preload('res://Art/GUI/Taken-Demon.png'),
		'Goblin': preload('res://Art/GUI/Taken-Goblin.png'),
		'Human': preload('res://Art/GUI/Taken-Human.png'),
		'Robot': preload('res://Art/GUI/Taken-Robot.png'),
	},
	'text':{
		'Demon': preload('res://Art/Text/demon.png'),
		'Goblin': preload('res://Art/Text/goblin.png'),
		'Human': preload('res://Art/Text/human.png'),
		'Robot': preload('res://Art/Text/robot.png'),
	},
	'box':[
		preload('res://Art/GUI/JoinCharacterBox.png'),
		preload('res://Art/GUI/CharacterBox.png'),
		preload('res://Art/GUI/EmptyCharacterBox.png'),
	]
}

const maps = {}

const characters = {
	'Demon': preload('res://Art/Characters/Demon-Sheet.png'),
	'Goblin': preload('res://Art/Characters/Goblin-Sheet.png'),
	'Human': preload('res://Art/Characters/Human-Sheet.png'),
	'Robot': preload('res://Art/Characters/Robot-Sheet.png'),
}

const white_characters = {
	'Demon': preload('res://Art/Characters/White-Demon-Sheet.png'),
	'Goblin': preload('res://Art/Characters/White-Goblin-Sheet.png'),
	'Human': preload('res://Art/Characters/White-Human-Sheet.png'),
	'Robot': preload('res://Art/Characters/White-Robot-Sheet.png'),
}

const bullets = {
	'Demon': preload('res://Art/Bullets/FireBallMerged-Sheet.png'),
	'Goblin': '',
	'Human': '',
	'Robot': preload('res://Art/Bullets/Gear.png')
}

const character_from_id = {
	0: 'Demon',
	1: 'Goblin',
	2: 'Human',
	3: 'Robot'
}

func get_character(character_id):
	return characters[character_from_id[int(character_id)]]

func get_white_character(character_id):
	return white_characters[character_from_id[int(character_id)]]

func get_gui_character(character_id):
	return gui['characters'][character_from_id[int(character_id)]]
	
func get_gui_taken_character(character_id):
	return gui['taken_characters'][character_from_id[int(character_id)]]
	
func get_text(character_id):
	return gui['text'][character_from_id[int(character_id)]]
	
func get_box(box_id):
	return gui['box'][int(box_id)]
