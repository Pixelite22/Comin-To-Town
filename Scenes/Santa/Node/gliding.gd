extends PlayerState

func enter(prev_state: String, data := {}): #When state is entered
	player.hasGlided = true #set the hasGlided flag on the player script to true
	#player.sprite.play(self.name) #run the animation that shares the name with the state
	player.sparkleSprite.play("Active") #Play the sparkle effect to indicate gliding
	player.sparkleSprite.show() #Unhide the sparkle effect

func physics_update(_delta): #Every physics frame/tick check for these conditions
	if player.is_on_floor(): #if player is on the floor
		if (Input.is_action_pressed("Left") or Input.is_action_pressed("Right")) and not (Input.is_action_pressed("Left") and Input.is_action_pressed("Right")):
			#and is trying to walk left or right
			state_ended.emit(WALKING) #transition to the walking state
		else: #Otherwise
			state_ended.emit(IDLE) #Transition to the idle state
		stop_sparkles() #and call the stop sparkling function
	
	if not player.is_on_floor(): #If player is in the air
		if not Input.is_action_pressed("Jump"): #and isn't pressing the jump button
			state_ended.emit(FALLING) #transition to the falling state
			stop_sparkles() #and call stop sparkles
			#The following code might be why we lose a jump when having a triple jump and a glide active
		if player.velocity.y < 0 and player.jump_ctr > 0 and Input.is_action_just_pressed("Jump"): #and the player is trying to jump
			state_ended.emit(JUMPING) #transition to the falling state
			stop_sparkles() #and call stop sparkles

func stop_sparkles():
	player.sparkleSprite.play("Inactive") #Play the inactive animation
	player.sparkleSprite.hide() #Hide the animation
