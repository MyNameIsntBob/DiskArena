class_name Character
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

var flashTimer := 0.0
var flashDuration := 0.2
var white := false

export var invincible := false setget set_invincible

var isDead := false

var isPaused := false

var DISK = preload("res://entities/Disk.tscn")
var disks = []

onready var default_layer = self.get_collision_layer()

onready var animationPlayer = $Character/AnimationPlayer
onready var charImage = $Character/Character_icon


func _ready():
	$Character/InvincibleTimer.connect('timeout', self, '_on_invincible_timeout')
	$Character/FlashTimer.connect('timeout', self, '_on_flash_timeout')


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
	
	if white:
		charImage.texture = Icons.get_white_character(character_id)
	else:
		charImage.texture = Icons.get_character(character_id)
	
	
	if invincible:
		set_collision_layer(0)
	else:
		set_collision_layer(default_layer)


# TODO 
# Split this up into mulitiple functions
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
	
	# play run animation
	if input_vector != Vector2(0, 0):
		if animationPlayer.get_current_animation() != 'Run':
			animationPlayer.stop()
			animationPlayer.play("Run")
	# play Idle animation
	else:
		if animationPlayer.get_current_animation() != 'Idle':
			animationPlayer.stop()
			animationPlayer.play('Idle')
			
	# Get the direction the character is heading and make the character look that direction
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
	# TODO
	# Change this to use !Global.can_shoot 
	if Global.game_over:
		return
	
	if len(disks):
		for disk in disks:
			if disk:
				disk.sendBack = true
		return
		
	# get the direction to send the disk
	var bulVelocity = ($Aim/BulletPosition.get_global_position() - get_global_position())
		
	# create the disk and give it all variables
	var disk = DISK.instance()
	Global.add_child(disk)
	disk.sender = self
	disk.position = find_node("BulletPosition").global_position
	disk.velocity = bulVelocity.normalized()
	disk.character_id = character_id
	disks.append(disk)


func kill(direction = Vector2.ZERO) -> bool:
	if isDead or invincible:
		return false
		
	if !SceneManager.isMenuScreen:
		ScoreKeeper.player_die(player_id)
	
	isDead = true
	animationPlayer.stop()
	animationPlayer.play("Death")
	
	charImage.frame_coords.y = int(charImage.frame_coords.y / 2) * 2
	velocity = direction.normalized() * 10
	respawn()
	return true


func respawn():
	yield(animationPlayer, "animation_finished")
	
	if SceneManager.isMenuScreen || ScoreKeeper.get_hp(player_id) > 0:
		animationPlayer.play("Revive")
		yield(animationPlayer, "animation_finished")
		
		isDead = false
		self.invincible = true

func set_invincible(new_value : bool):
	if new_value == true:
		white = true
		invincible = true
		$Character/InvincibleTimer.start()
		$Character/FlashTimer.start()
	else:
		white = false
		invincible = false
		$Character/InvincibleTimer.stop()
		$Character/FlashTimer.stop()


func _on_flash_timeout():
	white = !white


func _on_invincible_timeout():
	self.invincible = false

