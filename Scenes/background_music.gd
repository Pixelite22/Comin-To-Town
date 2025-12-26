extends AudioStreamPlayer

#Preload the sound effects for the background music
const Marshmellow_World = preload("res://Sounds/Background Music/Marshmallow World - No Vocals.mp3")
const Wind = preload("res://Sounds/Background Music/Wind Sound SOUND EFFECT - No Copyright[Download Free].mp3")

func _ready() -> void: #On ready,
	SignalBus.santa_died.connect(death_music) #Connect the death signal to the death_music function 

func death_music(): 
	stop() #Stop the music playing currently on the node
	stream = Wind #Set the stream to the wind sound effect
	play() #Play the current sound effect, which was just set to wind
