extends Node2D

enum powers {
	SPLIT,
	SPEED,
	TARGET
#	SHIELD/HEART
}

var power = powers.SPLIT

var waitTill = 0.3

# Split veriables
var rotationDeg = 0.25 * PI
var spaceDirection = 0.1

var diskPath = preload("res://Prefabs/Disk.tscn")

var isPaused = false

var last_anim_pos = 0.0
var last_anim = null
var travel_path = null

func _ready():
	power = powers.values()[randi()%powers.size()]
	$Orb.texture = Icons.get_power(power)

# I tried .duplicate() and I couldn't get it to work, people online recommend me
# to just create a new instance because apparently .duplicate() doesn't work very well
# Make sure to give the new instance everything it needs from the original bullet

func _process(delta):
#	if !isPaused and Global.paused:
#		print("Animation stopped")
##		$AnimationTree.anim_player.stop()
##		last_anim_pos = $AnimationPlayer.current_animation_position
##		last_anim = $AnimationPlayer.current_animation
##		travel_path = $AnimationTree.get("parameters/playback").get_travel_path()
##		$AnimationTree.active = false
###		$AnimationPlayer.stop(false)
##		isPaused = true
#
#	if isPaused and !Global.paused:
#		print("Animation Start")
#		$AnimationTree.active = true
##		$AnimationTree.advance(last_anim_pos)
#		$AnimationTree.get("parameters/playback").travel(travel_path)
##		$AnimationPlayer.play()
#		isPaused = false
	
	if waitTill > 0:
		waitTill -= delta
	else:
		self.visible = true

func _on_Area2D_body_entered(body):
	body.sendBack = false
	
	if power == powers.SPLIT:
		split(body)
		
	if power == powers.SPEED:
		speed(body)
		
	if power == powers.TARGET:
		target(body)
		
	self.queue_free()
	
func target(body):
	var target = null
	var otherPlayers = get_tree().get_nodes_in_group("Characters")
	otherPlayers.erase(body)
	if len(otherPlayers) == 0:
		return
	otherPlayers.shuffle()
	for player in otherPlayers:
		if !player.isDead:
			target = player
	
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
