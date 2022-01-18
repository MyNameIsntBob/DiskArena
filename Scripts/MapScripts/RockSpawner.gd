extends Node2D

var top_left
var bottom_right

var rock_path = preload("res://Prefabs/Maps/Obstacles/Rocks.tscn")
var rng = RandomNumberGenerator.new()

var wait_timer = 1.0
var wait_period = 2.0

var veriation = 2.0

# TODO Make so that is actually getting used
var max_num_powers = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	setNewTimer()
	
	top_left = Global.find_node("TopLeft")
	bottom_right = Global.find_node("BottomRight")

func _process(delta):
	if Global.paused:
		return
	
	wait_timer -= delta
	if wait_timer <= 0:
		setNewTimer()
		spawnRock()
	
func spawnRock():
	var rock = rock_path.instance()
	
	rock.position.x = rng.randf_range(top_left.position.x, bottom_right.position.x)
	rock.position.y = rng.randf_range(bottom_right.position.y, top_left.position.y)
	
	Global.add_child(rock)
	
func setNewTimer():
	wait_timer = rng.randf_range(wait_period - veriation, wait_period + veriation)

