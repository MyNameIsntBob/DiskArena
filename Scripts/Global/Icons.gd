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
	'Demon': preload('res://Art/Bullets/fireBall-Sheet.png'),
	'Goblin': preload('res://Art/Bullets/greenFireBall-Sheet.png'),
	'Human': preload('res://Art/Bullets/blueFireBall-Sheet.png'),
	'Robot': preload('res://Art/Bullets/grayFireBall-Sheet.png')
}

const maps = {
	'4player': preload('res://Art/Maps/TestMapSplit.png'),
	'3player': preload('res://Art/Maps/TestMapSplit.png'),
	'2player': preload('res://Art/Maps/TestMap.png'),
}

const powers = {
	'Split': preload('res://Art/powers/Split.png'),
	'Speed': preload('res://Art/powers/Speed.png'),
	'Target': preload('res://Art/powers/Target.png')
}

const character_from_id = {
	0: 'Demon',
	1: 'Goblin',
	2: 'Human',
	3: 'Robot'
}

const powers_from_id = {
	0: 'Split',
	1: 'Speed',
	2: 'Target'
}

func get_power(power):
	return powers[powers_from_id[power]]

func get_map(number_of_players):
	return maps[str(number_of_players) + 'player']

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
	
func get_bullet(character_id):
	return bullets[character_from_id[int(character_id)]]
