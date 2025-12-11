extends PlayerState

func enter(prev_state: String, data := {}): #When state is entered
	var cur_velocity = player.velocity
	player.collision.scale.y /= 2
	player.sprite.offset.y = -134
	player.sprite.play(self.name) #run the animation that shares the name with the state
	
	disable_feature(movement)
	player.velocity = cur_velocity
	
	await get_tree().create_timer(1.0).timeout
	transfer_state_slide()

func transfer_state_slide():
	if not player.is_on_floor():
		state_ended.emit(FALLING)
	
	elif Input.is_action_pressed("Left") or Input.is_action_pressed("Right") and not (Input.is_action_pressed("Left") and Input.is_action_pressed("Right")): #If player pressed left or right
		if Input.is_action_pressed("Sprint"):
			state_ended.emit(RUNNING)
		else:
			state_ended.emit(WALKING)
	
	elif player.is_on_floor():
		state_ended.emit(IDLE)

func physics_update(_delta): #Every physics frame/tick check for these conditions
	pass

func exit():
	player.collision.scale.y *= 2
	player.sprite.offset.y = 0
	reenable_feature(movement)
