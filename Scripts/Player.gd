extends KinematicBody2D

#expor vars
export var input_id := 0
export var keyboard := false
export var player_id := 0
export var character_id := 0

#tune vars
var acceleration := 1500
var max_speed := 100
var velocity := Vector2(0, 0)
var friction := 0.2
var deadzone := 0.2

#input takers
var left := 0.0
var right := 0.0
var up := 0.0
var down := 0.0

var look_left := 0.0
var look_right := 0.0
var look_up := 0.0
var look_down := 0.0

var imortalTimer := 2.0
var imortalDuration := 2.0

export var white := false

##export var diskPath : FilePath
var diskPath = preload("res://Prefabs/Disk.tscn")
var disk

onready var default_layer = self.get_collision_layer()

onready var animationPlayer = $AnimationPlayer

#export var cameraPath : NodePath 
#How to get an Object's path

func _ready():
	pass
	
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
#	moveControl
	var input_vector = Vector2(0, 0)
	input_vector.x = right - left
	input_vector.y = down - up
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
	
	
#	lookControl
	var look_vector = Vector2(0, 0)
	if keyboard:
		$Aim.look_at(get_global_mouse_position())
	else:
		look_vector.x = look_right - look_left
		look_vector.y = look_down - look_up
		if abs(look_vector.x) + abs(look_vector.y) >= 0.5:
			$Aim.look_at(self.position + look_vector.normalized())
		
	
	
func _unhandled_input(event):
#	If the input wasn't from my player
	if !event or event.get_device() != input_id or (event is InputEventKey and !keyboard) or (
	(event is InputEventJoypadButton or event is InputEventJoypadMotion) and keyboard):
		return

	if event.is_action("ui_right"):
		right = event.get_action_strength('ui_right')
	if event.is_action("ui_left"):
		left = event.get_action_strength('ui_left')
	if event.is_action("ui_up"):
		up = event.get_action_strength("ui_up")
	if event.is_action('ui_down'):
		down = event.get_action_strength("ui_down")
	if event.is_action_pressed("shoot") or event.is_action_pressed("ui_accept"):
		shoot()
		
	if event.is_action('aim_right'):
		look_right = event.get_action_strength('aim_right')
	if event.is_action('aim_left'):
		look_left = event.get_action_strength('aim_left')
	if event.is_action('aim_up'):
		look_up = event.get_action_strength('aim_up')
	if event.is_action('aim_down'):
		look_down = event.get_action_strength('aim_down')

func shoot():
	if disk:
		disk.sendBack = true
		return
		
#	get the direction to send the disk
	var bulVelocity
	if keyboard:
		bulVelocity = (get_global_mouse_position() - global_position)
	else:
		bulVelocity = Vector2(0, 0)
		bulVelocity.x = look_right - look_left
		bulVelocity.y = look_down - look_up
		
		if bulVelocity == Vector2.ZERO:
			bulVelocity = Vector2(cos($Aim.rotation), sin($Aim.rotation))
		
#	create the disk and give it all variables
	disk = diskPath.instance()
	find_parent("Master").add_child(disk)
	disk.sender = self
	disk.position = find_node("BulletPosition").global_position
	disk.velocity = bulVelocity.normalized()
	disk.character_id = character_id
	
func kill():
	Global.player_die(player_id)
	self.queue_free()
