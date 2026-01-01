extends PlayerState

func enter(prev_state: String, data := {}): #When state is entered
	if Input.is_action_pressed("Left"): #if the player is walking left
		player.sprite.flip_h = true #flip the sprite so it faces the correct direction
		player.sprite.offset.x = -117 #and offset it so it is in the same location, as the sprite wasn't perfectly centered
	elif Input.is_action_pressed("Right"): #if the player is walking right
		player.sprite.flip_h = false #Make sure the sprite is facing the correct way
		player.sprite.offset.x = 0 #reset the offset if needed
	
	player.sprite.play(self.name) #run the animation that shares the name with the state

func physics_update(_delta): #Every physics frame/tick check for these conditions
	#if player releases the input
	if Input.is_action_just_released("Left") or Input.is_action_just_released("Right") or (Input.is_action_pressed("Left") and Input.is_action_pressed("Right")):
		state_ended.emit(IDLE) #transition to the idle state
	
	if Input.is_action_pressed("Sprint"): #if player holds the sprint button
		state_ended.emit(RUNNING) #enter the running state
	
	if not player.is_on_floor(): #if player isn't touching the floor
		state_ended.emit(FALLING) #change the state to that of the falling state
	
	if Input.is_action_just_pressed("Jump"): #If the player pressed the jump button
		state_ended.emit(JUMPING) #Put player into jumping state
