extends KinematicBody2D

var velocity = Vector2(0, 0)
export var defaultSpeed = 300
var speed = 0
var character_id : int
var slowDown = 100

var sender

var b := false
var sendBack := false

#func _ready():
#	speed = defaultSpeed

func _process(delta):
	if (!sender):
		self.queue_free()
	
func _physics_process(delta):
	
	if speed > defaultSpeed:
		speed -= delta * slowDown
	if speed < defaultSpeed:
		speed = defaultSpeed
	
	if sendBack:
		velocity = (sender.global_position - self.global_position).normalized()
	
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
	if collision_info:
#		print(collision_info)
#		if collision_info == sender:
#			self.queue_free()
#		elif collision_info is KinematicBody2D and collision_info.get("player_id"):
#			collision_info.kill
#		else:
		velocity = velocity.bounce(collision_info.normal)
		sendBack = false
		
	
	$Bullet.texture = Icons.get_bullet(character_id)
	
	var direction = -int(velocity.normalized().angle() * (4 / PI)) + 2
	
	if direction > 7:
		direction -= 8
	if direction < 0:
		direction += 8
		
	$Bullet.frame_coords.y = direction
	
#func split():
##	velocity
#	velocity - Vector2(0.1, 0.1)
#	pass

#If you can figure it out, move all of this to the move_and_collide to simplify
func _on_ObjectChecker_body_entered(body):
	if body == self:
		return

	if body == sender:
		sender.remove_disk(self)
		self.queue_free()
		return

#	if body is KinematicBody2D and body.get("player_id"):
	if body.get_collision_layer_bit(3):
		body.kill()
		Global.add_kill(sender.player_id)


func _on_ObjectChecker_area_entered(area):
	return 
#	Originally sent it back to the player, now we don't do that
	
	if (area.name == 'area' + str(sender.player_id)):
		if b:
			sendBack = true
		else:
			b = true
			
		
