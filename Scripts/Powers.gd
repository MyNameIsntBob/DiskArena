extends Node2D

enum powers {
	SPLIT,
	SPEED,
	TARGET
}

var power = powers.SPLIT

var waitTill = 0.3

# Split veriables
var splitRange = Vector2(0.35, 0.35)

var rotationDeg = 0.25 * PI
var spaceDirection = 0.1

var diskPath = preload("res://Prefabs/Disk.tscn")

func _ready():
	power = powers.values()[randi()%powers.size()]
	power = powers.TARGET
	$Orb.texture = Icons.get_power(power)

# I tried .duplicate() and I couldn't get it to work, people online recommend me
# to just create a new instance because apparently .duplicate() doesn't work very well
# Make sure to give the new instance everything it needs from the original bullet

func _process(delta):
	if waitTill > 0:
		waitTill -= delta
	else:
		self.visible = true

func _on_Area2D_body_entered(body):
	if power == powers.SPLIT:
		split(body)
		
	if power == powers.SPEED:
		speed(body)
		
	if power == powers.TARGET:
		target(body)
		
	self.queue_free()
	
func target(body):
	var players = []
	
	print(Global.players)
	for player in Global.players:
		if player and player != body.sender:
			players.append(player)
	var target = players[randi() % players.size()]
	
	if !target:
		return
	
	body.velocity = target.global_position - body.global_position
	
func is_the_same(body):
	return body.player_id == 1

func speed(body):
	body.speed *= 2
	
func split(body):
	var newDisk = diskPath.instance()
	
	newDisk.velocity = body.velocity
	newDisk.character_id = body.character_id
	newDisk.sender = body.sender
	newDisk.sender.add_disk(newDisk)
	newDisk.position = body.position
	
	newDisk.position += rotate_vel(newDisk.velocity, 0.5 * PI) * spaceDirection 
	body.position += rotate_vel(body.velocity, -0.5 * PI) * spaceDirection
	body.get_parent().add_child(newDisk)
	
	body.velocity = rotate_vel(body.velocity, rotationDeg)
	newDisk.velocity = rotate_vel(newDisk.velocity, -rotationDeg)
	
func rotate_vel(velocity, angle):
	var new_velocity = Vector2.ZERO
	new_velocity.x = (velocity.x * cos(angle) - velocity.y * sin(angle))
	new_velocity.y = (velocity.x * sin(angle) + velocity.y * cos(angle))
	return new_velocity
