extends Area2D

@onready var sprite := $Sprite

func _ready() -> void: #On ready
	sprite.play("Fire") #play fire animation
	SignalBus.connect("snowball_hit", extinguish)

func extinguish():
	print("Extinguished Reached")
	queue_free()
