extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (NodePath) var topLeft
export (NodePath) var bottomRight

var powerUpPath = preload("res://Prefabs/Maps/Obstacles/Powers.tscn")
var powerUps = []
var rng = RandomNumberGenerator.new()

var waitTimer = 1.0
var waitPeriod = 8.0

var veriation = 3.0

var maxNumPowers = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	setNewTimer()
	topLeft = get_node(topLeft)
	bottomRight = get_node(bottomRight)
	
func _process(delta):
	if Global.paused:
		return
	
	waitTimer -= delta
	if waitTimer <= 0:
		setNewTimer()
		spawnPower()
		
	if len(powerUps) >= maxNumPowers:
		for i in range(len(powerUps)):
			if !powerUps[i]:
				powerUps.remove(i)
				break
	
func spawnPower():
	if len(powerUps) >= maxNumPowers:
		return
		
	var power = powerUpPath.instance()
	
	power.position.x = rng.randf_range(topLeft.position.x, bottomRight.position.x)
	power.position.y = rng.randf_range(bottomRight.position.y, topLeft.position.y)
	
	Global.add_child(power)
	
func setNewTimer():
	waitTimer = rng.randf_range(waitPeriod - veriation, waitPeriod + veriation)

