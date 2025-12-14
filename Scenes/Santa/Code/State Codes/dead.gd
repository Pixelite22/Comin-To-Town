extends PlayerState

func enter(prev_state: String, data := {}): #When state is entered
	print(self.name + " State Entered from ", prev_state)
	player.sprite.play(self.name) #run the animation that shares the name with the state
