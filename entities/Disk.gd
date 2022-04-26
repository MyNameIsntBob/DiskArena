extends KinematicBody2D
class_name Disk

var velocity = Vector2(0, 0)
export var defaultSpeed = 300
var speed = 0
var character_id : int
var slowDown = 100

var sender

var b := false
var sendBack := false

var isPaused := false


func _process(delta):
	if (!sender):
		self.queue_free()
		
	if sender.isDead or Global.game_over:
		sendBack = true


func _physics_process(delta):
	
	if Global.paused:
		if !isPaused:
			isPaused = true
			$AnimationPlayer.stop(false)
			
		return
	
	else:
		if isPaused:
			isPaused = false
			$AnimationPlayer.play()
			pass
	
	if speed > defaultSpeed:
		speed -= delta * slowDown
	if speed < defaultSpeed:
		speed = defaultSpeed
	
	if sendBack and sender:
		velocity = (sender.global_position - self.global_position).normalized()
	
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
	if collision_info:
		sendBack = false
		velocity = velocity.bounce(collision_info.normal)
		
	
	$Bullet.texture = Icons.get_bullet(character_id)
	
	var direction = -int(velocity.normalized().angle() * (4 / PI)) + 2
	
	direction = fposmod(direction, 8)
	
	$Bullet.frame_coords.y = direction


#If you can figure it out, move all of this to the move_and_collide to simplify
func _on_ObjectChecker_body_entered(body):
	if body == self:
		return
	
	if body == sender:
		sender.remove_disk(self)
		self.queue_free()
		return
	
	if body.get_collision_layer_bit(3):
		if body.kill(velocity):
			ScoreKeeper.add_kill(sender.player_id)
