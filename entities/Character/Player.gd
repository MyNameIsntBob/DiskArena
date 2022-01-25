extends Character

#expor vars
export var input_id := 0
export var keyboard := false

#input takers
var left := 0.0
var right := 0.0
var up := 0.0
var down := 0.0

var look_left := 0.0
var look_right := 0.0
var look_up := 0.0
var look_down := 0.0


func _process(delta):
	if Global.paused or isDead:
		right = 0
		left = 0
		up = 0
		down = 0


func _physics_process(delta):
	if Global.paused:
		return
	
	# moveControl
	var iv = Vector2(0, 0)
	iv.x = right - left
	iv.y = down - up
	input_vector = iv.normalized()
	
	# lookControl
	if keyboard:
		look_vector = get_global_mouse_position() - global_position
	else:
		var lv = Vector2(0, 0)
		lv.x = look_right - look_left
		lv.y = look_down - look_up
		
		if abs(lv.x) + abs(lv.y) >= 0.5:
			look_vector = lv
	
func _unhandled_input(event):
	if Global.paused:
		return
	
	# If the input wasn't from my player
	if !event or event.get_device() != input_id:
		return 
		
	# If I'm a keyboard and it was a Joypad event
	if keyboard:
		if event is InputEventJoypadButton or event is InputEventJoypadMotion:
			return
	
	# If I'm a Joypad and it was a keyboard or mouse event
	else:
		if event is InputEventKey or event is InputEventMouseButton:
			return
	
	if event.is_action_pressed("pause"):
		Global.pause_game(player_id)
		
	if isDead:
		return
		
	if event.is_action("right"):
		right = event.get_action_strength('right')
	if event.is_action("left"):
		left = event.get_action_strength('left')
	if event.is_action("up"):
		up = event.get_action_strength("up")
	if event.is_action('down'):
		down = event.get_action_strength("down")
	if event.is_action_pressed("shoot") or event.is_action_pressed("accept"):
		shoot()
		
	if event.is_action('aim_right'):
		look_right = event.get_action_strength('aim_right')
	if event.is_action('aim_left'):
		look_left = event.get_action_strength('aim_left')
	if event.is_action('aim_up'):
		look_up = event.get_action_strength('aim_up')
	if event.is_action('aim_down'):
		look_down = event.get_action_strength('aim_down')
		
