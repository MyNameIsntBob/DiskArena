extends Node2D

var splitRange = Vector2(0.35, 0.35)

var rotationDeg = 0.25 * PI
var spaceDirection = 0.1

var diskPath = preload("res://Prefabs/Disk.tscn")

# I tried .duplicate() and I couldn't get it to work, people online recommend me
# to just create a new instance because apparently .duplicate() doesn't work very well
# Make sure to give the new instance everything it needs from the original bullet

func _on_Area2D_body_entered(body):
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
	self.queue_free()
	
func rotate_vel(velocity, angle):
	var new_velocity = Vector2.ZERO
	new_velocity.x = (velocity.x * cos(angle) - velocity.y * sin(angle))
	new_velocity.y = (velocity.x * sin(angle) + velocity.y * cos(angle))
	return new_velocity
