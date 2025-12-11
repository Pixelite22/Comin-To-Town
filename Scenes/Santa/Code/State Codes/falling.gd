extends PlayerState

func enter(prev_state: String, data := {}): #When state is entered
	print("Falling State Entered from ", prev_state)
	player.sprite.play(self.name) #run the animation that shares the name with the state

func physics_update(_delta): #Every physics frame/tick check for these conditions
#	player.velocity.y += player.gravity * _delta
#	player.move_and_slide()
	
	if player.is_on_floor():
		if Input.is_action_pressed("Left") or Input.is_action_pressed("Right") and not (Input.is_action_pressed("Left") and Input.is_action_pressed("Right")):
			state_ended.emit(WALKING)
		else:
			state_ended.emit(IDLE)
