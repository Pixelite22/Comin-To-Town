extends PlayerState

func enter(prev_state: String, data := {}): #When state is entered
	print("Walking State Entered from ", prev_state)
#	player.velocity.x > 0.0 or player.velocity.x < 0
	if Input.is_action_pressed("Left"):
		player.sprite.flip_h = true
	elif Input.is_action_pressed("Right"):
		player.sprite.flip_h = false
	player.sprite.play(self.name) #run the animation that shares the name with the state

func physics_update(_delta): #Every physics frame/tick check for these conditions
#	player.velocity.y += player.gravity * _delta
#	player.move_and_slide()
	
	if Input.is_action_just_released("Left") or Input.is_action_just_released("Right") or (Input.is_action_pressed("Left") and Input.is_action_pressed("Right")):
		state_ended.emit(IDLE)
#	if not player.is_on_floor(): #if player isn't touching the floor
#		state_ended.emit(FALLING) #change the state to that of the falling state
	if Input.is_action_just_pressed("Jump"): #If the player pressed the jump button
		state_ended.emit(JUMPING) #Put player into jumping state
