extends KinematicBody2D

#expor vars
export var input_id := 0
export var keyboard := false
export var player_id := 0

#tune vars
var acceleration := 2500
var max_speed := 300
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

##export var diskPath : FilePath
var diskPath = preload("res://Prefabs/Disk.tscn")
var disk

#export var cameraPath : NodePath 
#How to get an Object's path

func _ready():
	if player_id == 1:
		self.modulate = Color(0.5, 0, 0)
	elif player_id == 2:
		self.modulate = Color(0, 0.5, 0)
	elif player_id == 3:
		self.modulate = Color(0, 0, 0.5)

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
	
	velocity = move_and_slide(velocity)
	
#	lookControl
	if keyboard:
		look_at(get_global_mouse_position())
	else:
		var look_vector = Vector2(0, 0)
		look_vector.x = look_right - look_left
		look_vector.y = look_down - look_up
		
		look_at(position + look_vector.normalized())
	
	
func _unhandled_input(event):
	if !event or event.get_device() != input_id:
		return
	

#	If this player is using the keyboard
	if keyboard:
		if event is InputEventKey:
			if event.is_action("ui_right"):
				right = event.get_action_strength('ui_right')
			if event.is_action("ui_left"):
				left = event.get_action_strength('ui_left')
			if event.is_action("ui_up"):
				up = event.get_action_strength("ui_up")
			if event.is_action('ui_down'):
				down = event.get_action_strength("ui_down")
			if event.is_action("shoot") or event.is_action("ui_accept"):
				shoot()

#	If the player is useing a controller
	else:
			
		if event is InputEventJoypadButton or event is InputEventJoypadMotion:
			if event.is_action('ui_right'):
				right = event.get_action_strength('ui_right')
			if event.is_action('ui_left'):
				left = event.get_action_strength('ui_left')
			if event.is_action('ui_up'):
				up = event.get_action_strength('ui_up')
			if event.is_action("ui_down"):
				down = event.get_action_strength('ui_down')
			if event.is_action("shoot"):
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
		disk.send_back = true
		return
		
#	get the direction to send the disk
	var bulVelocity
	if keyboard:
		bulVelocity = (get_global_mouse_position() - global_position).normalized()
	else:
		bulVelocity = Vector2(0, 0)
		bulVelocity.x = look_right - look_left
		bulVelocity.y = look_down - look_up
		
#	create the disk and give it all variables
	disk = diskPath.instance()
	find_parent("Master").add_child(disk)
	disk.sender = self
	disk.position = find_node("BulletPosition").global_position
	disk.velocity = bulVelocity
	disk.modulate = self.modulate
	
func kill():
	Global.player_die(player_id)
	self.queue_free()
