extends Area2D

@onready var sprite := $Sprite

func _ready() -> void:
	sprite.play("Fire")
