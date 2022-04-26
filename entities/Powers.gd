extends Node2D

# TODO 
# It's bad practice to have this be all three types, 
# separate this into the different powers

enum powers {
	SPLIT,
	SPEED,
	TARGET
}

var power = powers.SPLIT

var wait_till = 0.3

var rotation_deg = 0.25 * PI
var space_direction = 0.1

var DISK = preload("res://entities/Disk.tscn")

var last_anim_pos = 0.0
var last_anim = null
var travel_path = null

func _ready():
	power = powers.values()[randi()%powers.size()]
	$Orb.texture = Icons.get_power(power)


func _process(delta):
	if wait_till > 0:
		wait_till -= delta
	else:
		self.visible = true


func target(body: Disk):
	var target = null
	var otherPlayers = get_tree().get_nodes_in_group("Characters")
	otherPlayers.erase(body.sender)
	if len(otherPlayers) == 0:
		return
	otherPlayers.shuffle()
	for player in otherPlayers:
		if !player.isDead:
			target = player
	
	if !target:
		return
	
	body.velocity = target.global_position - body.global_position


func speed(body):
	body.speed *= 2


func split(body):
	var newDisk = DISK.instance()
	
	newDisk.velocity = body.velocity
	newDisk.character_id = body.character_id
	newDisk.sender = body.sender
	newDisk.sender.add_disk(newDisk)
	newDisk.position = body.position
	
	newDisk.position += _rotate_vel(newDisk.velocity, 0.5 * PI) * space_direction 
	body.position += _rotate_vel(body.velocity, -0.5 * PI) * space_direction
	Global.add_child(newDisk)
	
	body.velocity = _rotate_vel(body.velocity, rotation_deg)
	newDisk.velocity = _rotate_vel(newDisk.velocity, -rotation_deg)


func _rotate_vel(velocity, angle):
	var new_velocity = Vector2.ZERO
	new_velocity.x = (velocity.x * cos(angle) - velocity.y * sin(angle))
	new_velocity.y = (velocity.x * sin(angle) + velocity.y * cos(angle))
	return new_velocity


func _on_Area2D_body_entered(body: Disk):
	body.sendBack = false
	
	if power == powers.SPLIT:
		split(body)
		
	if power == powers.SPEED:
		speed(body)
		
	if power == powers.TARGET:
		target(body)
		
	self.queue_free()
