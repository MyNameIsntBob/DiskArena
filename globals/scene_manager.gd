extends Node2D

#var level = 0
var isMenuScreen := false

export (NodePath) var ChildrenHolder

onready var SIGNS = preload("res://menus/signs.tscn")

#const main_menu_screen = "res://menus/main_menu/StartScreen.tscn"

const levels = {
	'Grass': "res://maps/grass.tscn",
	'Lava': "res://maps/lava.tscn",
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
	isMenuScreen = true
	ScoreKeeper.reset_stats()
	ScoreKeeper.setup_npc_stats()
	change_scene(levels['Grass'])
	Global.add_child(SIGNS.instance())
	PlayerSpawner.spawnPlayers()

func load_arena(level = 0):
	isMenuScreen = false
	if level == 0:
		level = _random_level()
	
	ScoreKeeper.reset_scores()
	
	Global.remove_children()
	Global.set_hp_bars()
	
	change_scene(levels[level_from_id[level]])
	PlayerSpawner.spawnPlayers()

func _random_level():
	return (randi() % (len(level_from_id) - 1)) + 1
	
func change_scene(scene):
	print('change_scene: ', scene)
	$SceneFader.fade_out()
	yield($SceneFader, 'finished')
	get_tree().change_scene(scene)
	Global.focus_camera()
