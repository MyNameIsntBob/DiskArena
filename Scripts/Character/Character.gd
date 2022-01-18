extends KinematicBody2D

#expor vars
export var player_id := 0
export var character_id := 0

#tune vars
var acceleration := 1500
var max_speed := 100
var velocity := Vector2(0, 0)
var friction := 0.2

var input_vector := Vector2(0, 0)
var look_vector := Vector2(0, 0)

var imortalTimer := 2.0
var imortalDuration := 2.0

export var white := false

var isDead := false

var isPaused := false

##export var diskPath : FilePath
var diskPath = preload("res://Prefabs/Disk.tscn")
var disks = []

onready var default_layer = self.get_collision_layer()

onready var animationPlayer = $Character/AnimationPlayer
onready var charImage = $Character/Character_icon

#export var cameraPath : NodePath 
#How to get an Object's path
	
func _process(delta):
	
	if Global.paused:
		if !isPaused:
			isPaused = true
			animationPlayer.stop(false)
			
		return
	
	else:
		if isPaused:
			isPaused = false
			animationPlayer.play()
			pass
	
#	set_collision_layer(0)
	if white and imortalTimer > 0:
		charImage.texture = Icons.get_white_character(character_id)
	else:
		charImage.texture = Icons.get_character(character_id)
	
#	You just spawned in
	if imortalTimer > 0:
		imortalTimer -= delta
		set_collision_layer(0)
	else:
		set_collision_layer(default_layer)
		

func _physics_process(delta):
	
	if Global.paused:
		return
	
	if isDead:
		velocity = velocity.linear_interpolate(Vector2.ZERO, 0.05)
		var collision_info = move_and_collide(velocity)
		if collision_info:
			velocity = velocity.bounce(collision_info.normal)
			velocity *= 0.9
		
		return
	
	if input_vector != Vector2(0, 0):
		velocity += input_vector * acceleration * delta
		velocity = velocity.clamped(max_speed)
	else:
		velocity = velocity.linear_interpolate(Vector2(0, 0), friction)
	
#	play run animation
	if input_vector != Vector2(0, 0):
		if animationPlayer.get_current_animation() != 'Run':
			animationPlayer.stop()
			animationPlayer.play("Run")
#	play Idle animation
	else:
		if animationPlayer.get_current_animation() != 'Idle':
			animationPlayer.stop()
			animationPlayer.play('Idle')
			
#	Get the direction the character is heading and make the character look that direction
	var direction = -int(input_vector.normalized().angle() * (4 / PI)) + 2
	
	if direction > 7:
		direction -= 8
	if direction < 0:
		direction += 8

	if input_vector != Vector2.ZERO:
		charImage.frame_coords.y = direction
			
	velocity = move_and_slide(velocity)
	
	if abs(look_vector.x) + abs(look_vector.y) >= 0.5:
		$Aim.look_at(self.position + look_vector.normalized())

func add_disk(disk):
	disks.append(disk)
	
func remove_disk(disk):
	disks.erase(disk)

func shoot():
	if len(disks):
		for disk in disks:
			if disk:
				disk.sendBack = true
		return
		
#	get the direction to send the disk
	var bulVelocity = ($Aim/BulletPosition.get_global_position() - get_global_position())
		
#	create the disk and give it all variables
	var disk = diskPath.instance()
	Global.add_child(disk)
	disk.sender = self
	disk.position = find_node("BulletPosition").global_position
	disk.velocity = bulVelocity.normalized()
	disk.character_id = character_id
	disks.append(disk)
	
func kill(direction = Vector2.ZERO):
	if isDead or imortalTimer > 0:
		return
		
	if !Global.isMenuScreen:
		Global.player_die(player_id)
#	imortalTimer = imortalDuration
	isDead = true
	animationPlayer.stop()
	animationPlayer.play("Death")
	charImage.frame_coords.y = int(charImage.frame_coords.y / 2) * 2
	velocity = direction.normalized() * 10
	yield(animationPlayer, "animation_finished")
	
	if Global.get_hp(player_id) > 0:
		animationPlayer.play("Revive")
		yield(animationPlayer, "animation_finished")
		
		isDead = false
		imortalTimer = imortalDuration
		
