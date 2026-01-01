extends PlayerState

func enter(prev_state: String, data := {}): #When state is entered
	var cur_velocity = player.velocity #save the player's velocity
	player.collision.scale.y /= 2 #Shrink the collision by 2
	player.sprite.offset.y = -134 #and move the sprite so it's sprite correctly collides with the collision
	player.sprite.play(self.name) #run the animation that shares the name with the state
	
	disable_feature(movement) #disable movement while sliding
	player.velocity = cur_velocity #Set player velocity to the current velocity
	
	await get_tree().create_timer(1.0).timeout #wait a second
	transfer_state_slide() #pass to the transfer state function

func transfer_state_slide():
	if not player.is_on_floor(): #if the player isn't on the floor
		state_ended.emit(FALLING) #enter the falling state
	
	#If the player is trying to move after the slide
	elif Input.is_action_pressed("Left") or Input.is_action_pressed("Right") and not (Input.is_action_pressed("Left") and Input.is_action_pressed("Right")): #If player pressed left or right
		if Input.is_action_pressed("Sprint"): #if the movement is a sprint
			state_ended.emit(RUNNING) #move to the running state
		else: #otherwise
			state_ended.emit(WALKING) #move to the walking state
	
	#if the player isn't trying to move and is on the floor
	elif player.is_on_floor(): 
		state_ended.emit(IDLE) #enter the idle state

func physics_update(_delta): #Every physics frame/tick check for these conditions
	pass

func exit(): #On exiting the state
	player.collision.scale.y *= 2 #Regrow the collision
	player.sprite.offset.y = 0 #reset the sprites offset
	reenable_feature(movement) #reenable movement
