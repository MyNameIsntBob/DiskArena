extends Node2D

var powerUpPath = preload("res://Prefabs/Maps/Obstacles/Powers.tscn")
var powerUps = []
var rng = RandomNumberGenerator.new()

var waitTimer = 1.0
var waitPeriod = 8.0

var veriation = 3.0

var maxNumPowers = 5

var active = false

func _ready():
	rng.randomize()

func activate():
	setNewTimer()
	active = true

func deactivate():
	active = false

func _process(delta):
	if !active:
		return
	
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
	
	power.position = Spawners.random_spawn_position()
	
	Global.add_child(power)
	
func setNewTimer():
	waitTimer = rng.randf_range(waitPeriod - veriation, waitPeriod + veriation)

