extends PlayerState

func enter(prev_state: String, data := {}): #When state is entered
	player.hasGlided = true
	print(self.name + " State Entered from ", prev_state)
	#player.sprite.play(self.name) #run the animation that shares the name with the state
	player.sparkleSprite.play("Active")
	player.sparkleSprite.show()

func physics_update(_delta): #Every physics frame/tick check for these conditions
#	player.velocity.y += player.gravity * _delta
#	player.move_and_slide()
	
	if player.is_on_floor():
		if (Input.is_action_pressed("Left") or Input.is_action_pressed("Right")) and not (Input.is_action_pressed("Left") and Input.is_action_pressed("Right")):
			state_ended.emit(WALKING)
		else:
			state_ended.emit(IDLE)
		stop_sparkles()
	
	if not player.is_on_floor():
		if not Input.is_action_pressed("Jump"):
			state_ended.emit(FALLING)
			stop_sparkles()
		if player.velocity.y < 0 and player.jump_ctr > 0 and Input.is_action_just_pressed("Jump"):
			state_ended.emit(JUMPING)
			stop_sparkles()

func stop_sparkles():
	player.sparkleSprite.play("Inactive")
	player.sparkleSprite.hide()
