extends KinematicBody2D

var velocity = Vector2(0, 0)
export var speed = 600

var sender

var b := false
var sendBack := false

func _physics_process(delta):
	
	if sendBack:
		velocity = (sender.global_position - self.global_position).normalized()
	
	var collision_info = move_and_collide(velocity * delta * speed)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
	


func _on_ObjectChecker_body_entered(body):
	if body == self:
		return
	
	if body == sender:
		self.queue_free()
		return
		
	if body is KinematicBody2D and body.get("player_id"):
		body.kill()


func _on_ObjectChecker_area_entered(area):
	if (area.name == 'area' + str(sender.player_id)):
		if b:
			sendBack = true
		else:
			b = true
			
		
