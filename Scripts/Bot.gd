extends KinematicBody2D

#expor vars
#export var input_id := 0
#export var keyboard := false
export var player_id := 0
export var character_id := 0

var target
var shootTimer := 1.5
const waitTillShoot := 1.5

#tune vars
var acceleration := 1500
var max_speed := 100
var velocity := Vector2(0, 0)
var friction := 0.2
var deadzone := 0.2

#input takers
#var left := 0.0
#var right := 0.0
#var up := 0.0
#var down := 0.0
var input_vector : Vector2

var moveVariation := 5

var imortalTimer := 2.0
#const imortalDuration := 2.0

export var white := false

##export var diskPath : FilePath
var diskPath = preload("res://Prefabs/Disk.tscn")
var disks = []

onready var default_layer = self.get_collision_layer()

onready var animationPlayer = $AnimationPlayer

#export var cameraPath : NodePath 
#How to get an Object's path

func _ready():
	randomize()
	input_vector = Vector2(rand_range(-1.0, 1.0), rand_range(-1.0, 1.0))
	
func _process(delta):
#	set_collision_layer(0)
	if white and imortalTimer > 0:
		$Character.texture = Icons.get_white_character(character_id)
	else:
		$Character.texture = Icons.get_character(character_id)
	
#	You just spawned in
	if imortalTimer > 0:
		imortalTimer -= delta
		set_collision_layer(0)
	else:
		set_collision_layer(default_layer)
		

func _physics_process(delta):
	change_movement(delta)
	
#	moveControl
#	var input_vector = Vector2(0, 0)
#	input_vector.x = right - left
#	input_vector.y = down - up
#	input_vector = input_vector.normalized()
	input_vector = input_vector.normalized()
	
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
		$Character.frame_coords.y = direction
			
	velocity = move_and_slide(velocity)
#	var collission_info = move_and_collide(velocity)
	
	if !target:
		var otherPlayers = Global.players.duplicate()
		otherPlayers.erase(self)
		if len(otherPlayers) == 0:
			return
		target = otherPlayers[randi() % len(otherPlayers)]
	$Aim.look_at(target.get_global_position())
	
	if shootTimer < 0:
		shoot()
	else:
		shootTimer -= delta

func change_movement(delta):
	
	input_vector += Vector2(rand_range(-1.0, 1.0), rand_range(-1.0, 1.0)) * moveVariation * delta
	
#	for i in range(len(directions)):
#		var dir = directions[i]
#		dir += rand_range(-1.5, 1.0) * moveVariation * delta
#
#		if dir > 1:
#			dir = 1.0
#		if dir < 0:
#			dir = 0.0
#
#		directions[i] = dir

func add_disk(disk):
	disks.append(disk)
	
func remove_disk(disk):
	disks.erase(disk)

func shoot():
	
	shootTimer = waitTillShoot
	
	if len(disks):
		for disk in disks:
			if disk:
				disk.sendBack = true
		return
		
#	get the direction to send the disk
#	Shoot the bullet towards the bulletPoision
	var bulVelocity = ($Aim/BulletPosition.get_global_position() - get_global_position())
		
#	create the disk and give it all variables
	var disk = diskPath.instance()
	find_parent("Master").add_child(disk)
	disk.sender = self
	disk.position = find_node("BulletPosition").global_position
	disk.velocity = bulVelocity.normalized()
	disk.character_id = character_id
	disks.append(disk)
	
func kill():
	Global.player_die(player_id)
	self.queue_free()



func _on_Right_body_entered(body):
	if input_vector.x > 0:
		input_vector.x = rand_range(-0.5, -0.1)


func _on_Left_body_entered(body):
	if input_vector.x < 0:
		input_vector.x = rand_range(0.1, 0.5)


func _on_Bottom_body_entered(body):
	if input_vector.y > 0:
		input_vector.y = rand_range(-0.5, -0.1)


func _on_Top_body_entered(body):
	if input_vector.y < 0:
		input_vector.y = rand_range(0.1, 0.5)
