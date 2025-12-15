extends AudioStreamPlayer

const Marshmellow_World = preload("res://Sounds/Background Music/Marshmallow World - No Vocals.mp3")
const Wind = preload("res://Sounds/Background Music/Wind Sound SOUND EFFECT - No Copyright[Download Free].mp3")

func _ready() -> void:
	SignalBus.santa_died.connect(death_music)

func death_music():
	print("Santa died detected from sound")
	stop()
	stream = Wind
	play()
