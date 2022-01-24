extends Node

const gui = {
	'characters':{
		'Demon': preload('res://Art/GUI/Character/Demon.png'),
		'Goblin': preload('res://Art/GUI/Character/Goblin.png'),
		'Human': preload('res://Art/GUI/Character/Human.png'),
		'Robot': preload('res://Art/GUI/Character/Robot.png'),
		'Ai': preload('res://Art/GUI/Character/AI.png'),
		'Random': preload('res://Art/GUI/Character/Random.png')
	},
	'taken_characters':{
		'Demon': preload('res://Art/GUI/Character/Taken-Demon.png'),
		'Goblin': preload('res://Art/GUI/Character/Taken-Goblin.png'),
		'Human': preload('res://Art/GUI/Character/Taken-Human.png'),
		'Robot': preload('res://Art/GUI/Character/Taken-Robot.png'),
	},
	'text':{
		'Demon': preload('res://Art/Text/demon.png'),
		'Goblin': preload('res://Art/Text/goblin.png'),
		'Human': preload('res://Art/Text/human.png'),
		'Robot': preload('res://Art/Text/robot.png'),
		'Random': preload('res://Art/Text/demon.png')
	},
	'box':[
		preload('res://Art/GUI/Box/JoinCharacterBox.png'),
		preload('res://Art/GUI/Box/CharacterBox.png'),
		preload('res://Art/GUI/Box/LevelSelect.png'),
		preload('res://Art/GUI/Box/EmptyLevelBox.png'),
		preload('res://Art/GUI/Box/EmptyCharacterBox.png')
	],
	'map':{
		'Random': preload("res://Art/GUI/MapIcons/Random.png"),
		'Grass': preload("res://Art/GUI/MapIcons/Grass.png"),
		'Lava': preload("res://Art/GUI/MapIcons/Lava.png"),
	}
}

const signs = {
	'selected': {
		"Play": preload("res://Art/GUI/Signs/Main/PlaySelected.png"),
		"Options": preload("res://Art/GUI/Signs/Main/OptionsSelected.png"),
		"Exit": preload("res://Art/GUI/Signs/Main/ExitSelected.png"),
		"Continue": preload("res://Art/GUI/Signs/Pause/ContinueSelected.png"),
		"ExitPaused": preload("res://Art/GUI/Signs/Pause/ExitSelected.png")
	},
	"Play": preload("res://Art/GUI/Signs/Main/Play.png"),
	"Options": preload("res://Art/GUI/Signs/Main/Options.png"),
	"Exit": preload("res://Art/GUI/Signs/Main/Exit.png"),
	"Continue": preload("res://Art/GUI/Signs/Pause/Continue.png"),
	"ExitPaused": preload("res://Art/GUI/Signs/Pause/Exit.png")
}

const characters = {
	'Demon': preload('res://Art/Characters/Demon-Sheet2.png'),
	'Goblin': preload('res://Art/Characters/Goblin-Sheet2.png'),
	'Human': preload('res://Art/Characters/Human-Sheet2.png'),
	'Robot': preload('res://Art/Characters/Robot-Sheet2.png'),
}

const white_characters = {
	'Demon': preload("res://Art/Characters/Demon-White-Sheet.png"),
	'Goblin': preload('res://Art/Characters/Goblin-White-Sheet.png'),
	'Human': preload('res://Art/Characters/Human-White-Sheet.png'),
	'Robot': preload('res://Art/Characters/Robot-White-Sheet.png'),
}

const bullets = {
	'Demon': preload('res://Art/Bullets/fireBall-Sheet.png'),
	'Goblin': preload('res://Art/Bullets/greenFireBall-Sheet.png'),
	'Human': preload('res://Art/Bullets/blueFireBall-Sheet.png'),
	'Robot': preload('res://Art/Bullets/grayFireBall-Sheet.png')
}

const powers = {
	'Split': preload('res://Art/powers/Split.png'),
	'Speed': preload('res://Art/powers/Speed.png'),
	'Target': preload('res://Art/powers/Target.png')
}

const character_from_id = {
	0: 'Random',
	1: 'Demon',
	2: 'Goblin',
	3: 'Human',
	4: 'Robot',
}

const powers_from_id = {
	0: 'Split',
	1: 'Speed',
	2: 'Target'
}

func number_of_characters():
	return len(character_from_id)
	
# -1 to exclude random
func number_of_maps():
	return len(gui['map']) - 1

func get_map_icon(map_id):
	return gui['map'][SceneManager.level_from_id[map_id]]

func get_power(power):
	return powers[powers_from_id[power]]

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
	
func get_sign(selected, title):
	if selected:
		return signs['selected'][title]
	return signs[title]
