extends Node2D

var waitTill = 0.3
export var attackAt = 1.5
var players = []
var diskPath = preload("res://Prefabs/Disk.tscn")

var isPaused := false

#func _init():
#	print('spawn')
#	var timer = Timer.new()
#	timer.connect("timeout", self, 'kill')
#	timer.set_wait_time(attackAt)
#	timer.start()
#
func _process(delta):
	if Global.paused and !isPaused:
		$Timer.stop()
		$AnimationPlayer.stop(false)
	
	if isPaused and !Global.paused:
		$Timer.start()
		$AnimationPlayer.play()
		
		
		
#	if waitTill > 0:
#		waitTill -= delta
#	else:
#		self.visible = true
#

func _on_Area2D_body_entered(body):
	players.append(body)
	

func _on_Area2D_body_exited(body):
	if body in players:
		players.erase(body)

func kill():
	for player in players:
		player.kill()

func _on_AnimationPlayer_animation_finished(anim_name):
	self.queue_free()


func _on_Timer_timeout():
	kill()
