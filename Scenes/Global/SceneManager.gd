extends Node2D

var level = 0
var isMenuScreen := false

export (NodePath) var ChildrenHolder

var main_menu = 'res://Scenes/StartScreen.tscn'

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
	load_main_menu()

func load_main_menu():
	ScoreKeeper.reset_stats()
	change_scene(main_menu)
	PlayerSpawner.spawnNpcs()

func load_arena(level = 0):
	if level == 0:
		level = _random_level()
	
	ScoreKeeper.reset_scores()
	
	Global.set_hp_bars()
	
	change_scene(levels[level_from_id[level]])

func _random_level():
	return (randi() % (len(level_from_id) - 1)) + 1
	
func change_scene(scene):
	$SceneFader.fade_out()
	yield($SceneFader, 'finished')
	get_tree().change_scene(main_menu)
	Global.focus_camera()
