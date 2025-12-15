extends Node2D

@onready var sprite := $AnimatedSprite2D

func _ready() -> void:
	SignalBus.santa_died.connect(make_screen_appear)
	SignalBus.hit_death_barrier.connect(make_screen_appear)

func make_screen_appear():
	await get_tree().create_timer(1.0).timeout
	
	show()
	modulate.a = 0.0
	sprite.play("default")
	fade_in()

func fade_out(duration: float = 5.0):
	var tween = create_tween()
	# Animates the alpha value from its current value to 0.0 over the specified duration
	tween.tween_property(self, "modulate:a", 0.0, duration)

func fade_in(duration: float = 5.0):
	var tween = create_tween()
	# Animates the alpha value from its current value to 1.0 over the specified duration
	tween.tween_property(self, "modulate:a", 1.0, duration)
