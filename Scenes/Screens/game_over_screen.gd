extends Node2D

signal retry_button_pressed

@onready var sprite := $AnimatedSprite2D

func _ready() -> void: #on Ready
	SignalBus.santa_died.connect(make_screen_appear) #Connect the santa dead signal to make the screen appear function
	

func make_screen_appear():
	await get_tree().create_timer(1.0).timeout#create a 1 second timer, and await the timeout signal when it hits 0
	
	show() #show the screen 
	modulate.a = 0.0 #Makes the screen invisible
	sprite.play("default") #play the default animation
	fade_in() #Call the fade in function

func fade_out(duration: float = 5.0): #Fade out function, makes the screen fade out when we code a retry button
	var tween = create_tween() #create a tween to shift opaque screen to invisible
	# Animates the alpha value from its current value to 0.0 over the specified duration
	tween.tween_property(self, "modulate:a", 0.0, duration)
	hide()

func fade_in(duration: float = 5.0): #Fade in function
	var tween = create_tween() #Create a tween to shift 
	# Animates the alpha value from its current value to 1.0 over the specified duration
	tween.tween_property(self, "modulate:a", 1.0, duration)

func _on_retry_pressed() -> void: #funstion for the retry button
	retry_button_pressed.emit() #When the button is pressed, emit the signal which will be passed to main in the program
	fade_out() #call fade out... though i don't think this will actually do much
