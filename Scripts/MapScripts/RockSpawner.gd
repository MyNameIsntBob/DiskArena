extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (NodePath) var topLeft
export (NodePath) var bottomRight

var rockPath = preload("res://Prefabs/Maps/Obstacles/Rocks.tscn")
var rng = RandomNumberGenerator.new()

var waitTimer = 1.0
var waitPeriod = 2.0

var veriation = 2.0

var maxNumPowers = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	setNewTimer()
	topLeft = get_node(topLeft)
	bottomRight = get_node(bottomRight)
	
func _process(delta):
	waitTimer -= delta
	if waitTimer <= 0:
		setNewTimer()
		spawnRock()
	
func spawnRock():
	var power = rockPath.instance()
	
	power.position.x = rng.randf_range(topLeft.position.x, bottomRight.position.x)
	power.position.y = rng.randf_range(bottomRight.position.y, topLeft.position.y)
	
	find_parent("Master").add_child(power)
	
func setNewTimer():
	waitTimer = rng.randf_range(waitPeriod - veriation, waitPeriod + veriation)

