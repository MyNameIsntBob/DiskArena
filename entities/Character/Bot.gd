extends Character

var target
var shootTimer
const waitTillShoot := 2.0
const shootVariation := 0.5

var moveVariation := 5

var isTimeStopped := false

func _ready():
	randomize()
	shootTimer = $ShootTimer
	shootTimer.start()
	input_vector = Vector2(rand_range(-1.0, 1.0), rand_range(-1.0, 1.0))


func _process(delta):
	if Global.paused or isDead:
		if !isTimeStopped:
			shootTimer.stop()
			isTimeStopped = true
	else:
		if isTimeStopped:
			shootTimer.start()
			isTimeStopped = false

func _physics_process(delta):
	
	if Global.paused or isDead:
		return
	
	change_movement(delta)
	
	input_vector = input_vector.normalized()
	
	if target and !target.isDead:
		look_vector = target.get_global_position() - global_position
	else:
		var otherPlayers = get_tree().get_nodes_in_group("Characters")
		otherPlayers.erase(self)
		if len(otherPlayers) == 0:
			return
		otherPlayers.shuffle()
		for player in otherPlayers:
			if !player.isDead:
				target = player
	
func change_movement(delta):
	input_vector += Vector2(rand_range(-1.0, 1.0), rand_range(-1.0, 1.0)) * moveVariation * delta

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


func _on_ShootTimer_timeout():
	shoot()
	shootTimer.set_wait_time(rand_range(waitTillShoot - shootVariation, shootVariation + shootVariation))
	shootTimer.start()
