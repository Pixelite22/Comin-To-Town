extends PlayerState

func enter(prev_state: String, data := {}): #When state is entered
	player.sprite.play(self.name) #run the animation that shares the name with the state

func physics_update(_delta): #Every physics frame/tick check for these conditions
#	player.velocity.y += player.gravity * _delta
#	player.move_and_slide()
	
	if player.is_on_floor(): #of player is on floor and 
		if Input.is_action_pressed("Left") or Input.is_action_pressed("Right") and not (Input.is_action_pressed("Left") and Input.is_action_pressed("Right")): #is trying to move right or left
			state_ended.emit(WALKING) #enter the walking state
		else: #else
			state_ended.emit(IDLE) #move to the idle state
	
	if player.velocity.y < 0 and player.jump_ctr > 0 and not player.is_on_floor(): #if player is trying to jump
		state_ended.emit(JUMPING) #enter the jumping state
	
	if not player.is_on_floor(): #if player isn't on floor, but
		if player.velocity.y < 0 and player.jump_ctr > 0 and Input.is_action_just_pressed("Jump"): #is trying to jump in midair
			state_ended.emit(JUMPING) #move to the jumping state
		if Input.is_action_pressed("Jump") and player.glide and player.velocity.y > 0 and player.times_jumped == player.jump_max: #is trying to glide
			state_ended.emit(GLIDING) #move to the gliding state
