extends Area2D

@onready var sprite := $Sprite

func _ready() -> void: #On ready
	sprite.play("Fire") #play fire animation
