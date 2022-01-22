extends Node2D

var powerUpPath = preload("res://entities/powers.tscn")
var powerUps = []
var rng = RandomNumberGenerator.new()

var waitTimer = 1.0
var waitPeriod = 8.0

var veriation = 3.0

var maxNumPowers = 5

func _ready():
	rng.randomize()
	setNewTimer()

func _process(delta):
	if SceneManager.isMenuScreen || ScoreKeeper.is_game_over():
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

