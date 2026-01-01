extends PlayerState

func enter(prev_state: String, data := {}): #When state is entered
	player.times_jumped += 1 #Add 1 to the times jumped counter
	player.sprite.play(self.name) #run the animation that shares the name with the state
	jump_sound_fx(player.times_jumped) #run this function to play the correct noise for the jump, each level of jump having a different noise attached to it
	player.jump_ctr -= 1 #Subtract one from the players jump counter

func jump_sound_fx(times): #Function for jump noises
	if times == 1: #if it is the first jump
		player.soundfx.stream = load("res://Sounds/Sound Effects/Ho1.mp3") #Load Ho 1
		player.soundfx.play() #Play loaded sound
	if times == 2: #if it is the second jump
		player.soundfx.stream = load("res://Sounds/Sound Effects/Ho2.mp3") #load Ho 2
		player.soundfx.play() #Play loaded sound
	if times >= 3: #if it is the third time or greater (somehow)
		player.soundfx.stream = load("res://Sounds/Sound Effects/Ho3.mp3") #load Ho 3
		player.soundfx.play() #Play loaded sound

func physics_update(_delta): #Every physics frame/tick check for these conditions
	if player.is_on_floor(): #If the player is on the floor
		if (Input.is_action_pressed("Left") or Input.is_action_pressed("Right")) and not (Input.is_action_pressed("Left") and Input.is_action_pressed("Right")):
			#and is trying to walk
			state_ended.emit(WALKING) #transition to the walking state
		else: #otherwise
			state_ended.emit(IDLE) #transition to the idle state
			
	if not player.is_on_floor(): #If the player is in the air
		if player.velocity.y > 0: #if the player has a positive y velocity
			state_ended.emit(FALLING) #enter the falling state
		if player.velocity.y < 0 and player.jump_ctr > 0 and Input.is_action_just_pressed("Jump"): #If the player is trying to jump and can
			state_ended.emit(JUMPING) #enter the jumping state
		if Input.is_action_pressed("Jump") and player.glide and player.velocity.y > 0 and player.times_jumped == player.jump_max: #if player is trying to glide and can
			state_ended.emit(GLIDING) #enter the gliding state
