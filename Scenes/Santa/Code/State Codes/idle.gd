extends PlayerState

func enter(prev_state: String, data := {}): #When state is entered
	print(self.name + " State Entered from ", prev_state)
	player.velocity.x = 0.0 #Make sure x velocity is set to 0
	player.sprite.play(self.name) #run the animation that shares the name with the state


func physics_update(_delta): #Every physics frame/tick check for these conditions
#	player.velocity.y += player.gravity * _delta
#	player.move_and_slide()
	
	if Input.is_action_just_pressed("Jump"): #If the player pressed the jump button
		state_ended.emit(JUMPING) #Put player into jumping state
	
	elif not player.is_on_floor(): #if player isn't touching the floor
		state_ended.emit(FALLING) #change the state to that of the falling state
	
	elif Input.is_action_pressed("Left") or Input.is_action_pressed("Right") and not (Input.is_action_pressed("Left") and Input.is_action_pressed("Right")): #If player pressed left or right
		print("Trying to reach walking")
		state_ended.emit(WALKING) #Put player into running state
