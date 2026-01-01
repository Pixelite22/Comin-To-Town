extends PlayerState

func enter(prev_state: String, data := {}): #When state is entered
	if Input.is_action_pressed("Sprint"): #If player is pressing the sprint button
		if Input.is_action_pressed("Left"): #and is pressing the left button
			player.sprite.flip_h = true #Make sure the sprite is flipped the right way
			player.sprite.offset.x = -117 #and offset correctly
		elif Input.is_action_pressed("Right"): #and is pressing the right button
			player.sprite.flip_h = false #Make sure the sprite is flipped the right way
			player.sprite.offset.x = 0 #and offset correctly
		player.sprite.play(self.name) #run the animation that shares the name with the state
	else: #and if they aren't pressing sprint
		state_ended.emit(WALKING) #immediatly end the sprint state and enter walking

func physics_update(_delta): #Every physics frame/tick check for these conditions
	if Input.is_action_just_pressed("Slide"): #If the player wants to slide
		state_ended.emit(SLIDING) #enter the sliding state
	
	#If they want to stop moving
	if Input.is_action_just_released("Left") or Input.is_action_just_released("Right") or (Input.is_action_pressed("Left") and Input.is_action_pressed("Right")):
		state_ended.emit(IDLE) #enter the idle state
	
	if Input.is_action_just_released("Sprint"): #and if they let go of the sprint button but are still moving
		state_ended.emit(WALKING) #move to walking
	
	if not player.is_on_floor(): #if player isn't touching the floor
		state_ended.emit(FALLING) #change the state to that of the falling state
	
	if Input.is_action_just_pressed("Jump"): #If the player pressed the jump button
		state_ended.emit(JUMPING) #Put player into jumping state
