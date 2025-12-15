extends PlayerState

func enter(prev_state: String, data := {}): #When state is entered
	print(self.name + " State Entered from ", prev_state)
	player.sprite.play(self.name) #run the animation that shares the name with the state
	player.soundfx.play()


func physics_update(_delta): #Every physics frame/tick check for these conditions
	if player.is_on_floor():
		if Input.is_action_pressed("Left") or Input.is_action_pressed("Right") and not (Input.is_action_pressed("Left") and Input.is_action_pressed("Right")):
			state_ended.emit(WALKING)
		else:
			state_ended.emit(IDLE)
		

	
#	if player.velocity.y <= 0: #if player isn't touching the floor
#		state_ended.emit(FALLING) #change the state to that of the falling state
#	elif Input.is_action_just_pressed("Jump"): #If the player pressed the jump button
#		state_ended.emit(JUMPING) #Put player into jumping state
#	elif Input.is_action_pressed("Left") or Input.is_action_pressed("Right") and not (Input.is_action_pressed("Left") and Input.is_action_pressed("Right")): #If player pressed left or right
#		print("Trying to reach walking")
#		state_ended.emit(WALKING) #Put player into running state
