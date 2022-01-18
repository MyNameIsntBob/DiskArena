extends Node2D

var level = 0
var isMenuScreen := false

export (NodePath) var ChildrenHolder

const scenes = {
	'connect': 'res://Scenes/ConnectScreen.tscn',
	'end': 'res://Scenes/EndScreen.tscn',
	'start': 'res://Scenes/StartScreen.tscn',
	'settings': 'res://Scenes/SettingsScreen.tscn'
}

const levels = {
	'Grass': 'res://Scenes/Maps/Grass.tscn',
	'Lava': 'res://Scenes/Maps/Lava.tscn',
}

const level_from_id = {
	0: 'Random',
	1: 'Grass',
	2: 'Lava'
}

func _ready():
	randomize()
	load_scene('start')
	
func start(num_of_bots = 0):
	# TODO : Fix this issue random amount of bots spawn
	isMenuScreen = false
	add_characters(num_of_bots)
	
	if level == 0:
		level = (randi() % (len(level_from_id) - 1)) + 1
	get_tree().change_scene(levels[level_from_id[level]])
	
	
#	Set everyone's hp to the max hp
	for player_id in player_stats:
		var player = player_stats[player_id]
		player['hp'] = player['max_hp']
		player['score'] = 0
		player['deaths'] = 0
		player['kills'] = 0
		
	$Camera2D.current = true
	$Interface.set_hp_bars()

# Scene Loading
func load_scene(scene):
	$SceneFader.fade_out()
	yield($SceneFader, 'finished')
	
	if scene == 'start':
		player_stats = {}
		add_characters(rand_range(2, 4))
	
	if scene == 'map':
		start()
	else:
		isMenuScreen = true
		if scene == 'connect':
			player_stats = {}
		get_tree().change_scene(scenes[scene])
