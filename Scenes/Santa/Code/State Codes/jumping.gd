extends PlayerState

func enter(prev_state: String, data := {}): #When state is entered
	print(self.name + " State Entered from ", prev_state)
	player.times_jumped += 1
	player.sprite.play(self.name) #run the animation that shares the name with the state
	jump_sound_fx(player.times_jumped)
	player.jump_ctr -= 1

func jump_sound_fx(times):
	if times == 1:
		player.soundfx.stream = load("res://Sounds/Sound Effects/Ho1.mp3")
		player.soundfx.play()
	if times == 2:
		player.soundfx.stream = load("res://Sounds/Sound Effects/Ho2.mp3")
		player.soundfx.play()
	if times == 3:
		player.soundfx.stream = load("res://Sounds/Sound Effects/Ho3.mp3")
		player.soundfx.play()

func physics_update(_delta): #Every physics frame/tick check for these conditions
	if player.is_on_floor():
		if (Input.is_action_pressed("Left") or Input.is_action_pressed("Right")) and not (Input.is_action_pressed("Left") and Input.is_action_pressed("Right")):
			state_ended.emit(WALKING)
		else:
			state_ended.emit(IDLE)
			
	if not player.is_on_floor():
		if player.velocity.y > 0:
			state_ended.emit(FALLING)
		if player.velocity.y < 0 and player.jump_ctr > 0 and Input.is_action_just_pressed("Jump"):
			state_ended.emit(JUMPING)
		if Input.is_action_pressed("Jump") and player.glide and player.velocity.y > 0 and player.times_jumped == player.jump_max:
			state_ended.emit(GLIDING)
