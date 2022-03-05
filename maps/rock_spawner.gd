extends Node2D

onready var rock_path = load("res://entities/rocks.tscn")
var rng = RandomNumberGenerator.new()

var wait_timer = 1.0
var wait_period = 2.0

var veriation = 2.0


func _ready():
	rng.randomize()
	setNewTimer()


func _process(delta):
	if Global.paused:
		return
	
	wait_timer -= delta
	if wait_timer <= 0:
		setNewTimer()
		spawnRock()


func spawnRock():
	if Global.game_over:
		return
	
	var rock = rock_path.instance()
	
	rock.position = Spawners.random_spawn_position()
	
	Global.add_child(rock)


func setNewTimer():
	wait_timer = rng.randf_range(wait_period - veriation, wait_period + veriation)
